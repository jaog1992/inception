#!/bin/bash

mkdir -p /var/www/html

# Wait till MariaDB is up
while ! nc -z mariadb 3306; do
    sleep 1
done

# Remove any premade configuration
cd /var/www/html
rm -rf *

# Download WordPress
wp core download --locale=es_ES --allow-root

# Configure the MariaDB connection
wp --path=/var/www/html config create \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=${MYSQL_HOST} \
    --locale=es_ES \
    --allow-root \
    --skip-check
    
# Install WordPress
wp core install \
    --path=/var/www/html \
    --url=${DOMAIN_NAME} \
    --title="jde-orma-s inception project" \
    --admin_name=${WP_ADMIN_USER} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

# Create a second user
wp user create ${MYSQL_SECOND_USER} ${MYSQL_SECOND_USER_MAIL} \
    --user_pass=${MYSQL_SECOND_USER_PASSWORD} \
    --role=editor \
    --allow-root
