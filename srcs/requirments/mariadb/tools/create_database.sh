#!/bin/bash

# --- MariaDB Data Directory Initialization ---
# This block ensures that the MariaDB data directory is correctly set up
# if it's a fresh volume (e.g., on the very first run of your container).
# `mysql_install_db` creates the initial system databases (mysql, information_schema, etc.).
# This is required for MariaDB to start correctly on an empty data directory.
# This part runs as the 'mysql' user because of the `USER mysql` in the Dockerfile.
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory with mysql_install_db..."
    # --user=mysql is important here as the script is now running as the 'mysql' user
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB data directory initialized."
fi

# --- Start MariaDB in Background for Initial Setup ---
# We start `mysqld` in the background temporarily so we can then run
# `mysql` client commands (like creating users/databases) against it.
echo "Starting MariaDB server in background for initial setup..."
mysqld --user=mysql --datadir=/var/lib/mysql &
MYSQLD_PID=$! # Store the Process ID of the background mysqld

# --- Wait for MariaDB to be Ready ---
# Use `mysqladmin ping` to check if MariaDB is accepting connections.
# This loop ensures the subsequent `mysql` client commands don't fail due to connection issues.
echo "Waiting for MariaDB to be ready to accept connections..."
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is not yet available, retrying in 2 seconds..."
    sleep 2
done
echo "MariaDB is up and running!"

# --- Execute Initial Database Setup Commands ---
# These commands create your database and user.
# `IF NOT EXISTS` ensures these commands are safe to run even if the container restarts
# (though ideally, they only effectively run once on first volume creation).
# Ensure your `docker-compose.yml` sets the DB_USER, DB_PWD, DB_NAME, and MYSQL_ROOT_PASSWORD
# environment variables for this MariaDB service, as these are used here.
echo "Executing initial database and user setup commands..."
# Connect as 'root' with the password set via MYSQL_ROOT_PASSWORD environment variable.
# Use EOF for a multi-line SQL script.
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES; # Important to apply privilege changes immediately
EOF
# Note: The backticks around $DB_NAME are good practice if your database name contains special characters.

echo "Initial database and user setup complete."

# --- Transition to Foreground Process ---
# Kill the temporary background MariaDB process that was started for setup.
kill $MYSQLD_PID
wait $MYSQLD_PID 2>/dev/null # Wait for it to properly exit to avoid orphaned processes

echo "MariaDB setup finished. Starting server in foreground..."
# Replace the current script process with the `mysqld` server process.
# `exec` is crucial here: it makes `mysqld` the primary process of the Docker container.
# The container will stay running as long as `mysqld` is running, and will stop if `mysqld` stops.
exec mysqld --user=mysql --datadir=/var/lib/mysql