#!/bin/bash

service mysql start

echo "CREATE USER IF NOT EXIXTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';" > mydb.sql
echo "CREATE DATABASE $DB_NAME;" >> mydb.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" >> mydb.sql

mysql < mydb.sql

mysqld