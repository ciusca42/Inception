FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y mariadb-server procps && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories and set initial permissions
# These are typically owned by root, but must be writable by the mysql user.
# `mariadb-server` install usually creates the `mysql` user and group.
RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld # Ensure mysql user can create the socket

# Copy your MariaDB configuration
COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy your entrypoint script
COPY tools/create_database.sh /

# Make the script executable
RUN chmod +x /create_database.sh

# IMPORTANT: Switch to the 'mysql' user BEFORE running the CMD.
# This fixes the "run mysqld as root" error.
USER mysql

# Set the entrypoint script as the CMD. This script will handle startup.
CMD ["/create_database.sh"]