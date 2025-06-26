#!/bin/bash
set -e

WP_PATH='/var/www/html'

sleep 10

if [ ! -f ${WP_PATH}/wp-config.php ]; then
  wp config create --allow-root \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --path="${WP_PATH}"

  wp core install --allow-root \
    --url=${WP_URL} \
    --title="${WP_TITLE}" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --path="${WP_PATH}"

  wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASSWORD} --allow-root --path="${WP_PATH}"
fi

exec /usr/sbin/php-fpm7.3 -F

