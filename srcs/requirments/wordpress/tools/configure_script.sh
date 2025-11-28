#!/bin/bash

print_info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

# creating the dirs that will be used after by nginx and wordpress
mkdir -p /var/www/
mkdir -p /var/www/html

cd /var/www/html

rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root --path=/var/www/html

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

mv /wp-config.php /var/www/html/wp-config.php

print_info "installing..."

wp core install --url=${DOMAIN_NAME}/ --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root

print_info "Creating User...";

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root

# wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root

print_info "Assigning Port...";

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

print_info "Creating new dir run/php...";

mkdir -p /run/php

# Ensure PHP-FPM workers receive container environment variables so getenv() works for web requests
# Do not clear environment and expose DB env vars to php-fpm workers
if ! grep -q "clear_env = no" /etc/php/7.4/fpm/pool.d/www.conf 2>/dev/null; then
    echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf
fi

cat >> /etc/php/7.4/fpm/pool.d/www.conf <<EOF
env[DB_NAME] = ${DB_NAME}
env[DB_USER] = ${DB_USER}
env[DB_PWD] = ${DB_PWD}
env[DB_HOST] = ${DB_HOST}
env[WP_HOME] = ${DOMAIN_NAME}
env[WP_SITEURL] = ${DOMAIN_NAME}
EOF

# wp redis enable --allow-root

print_info "Try to run...";

exec /usr/sbin/php-fpm7.4 -F

print_info "DONE";