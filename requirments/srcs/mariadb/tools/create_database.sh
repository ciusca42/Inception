#!/bin/bash

service mysql start

echo "CREATE USER IF NOT EXIXTS '$db_user'@'%' IDENTIFIED BY '$db_pwd';" > db.sql
echo "CREATE DATABASE $db_name;" >> db.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';"

mysql < db.sql

mysqld