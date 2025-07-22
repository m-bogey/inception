#!/bin/bash
set -e

WP_PATH='/var/www/html'

# On check que la DB est prête avant d'attaquer
until mysqladmin ping -h"${WORDPRESS_DB_HOST%%:*}" --silent; do
    echo " En attente de la DB..."
    sleep 2
done

#  Si wp-config existe pas, on setup
if [ ! -f "${WP_PATH}/wp-config.php" ]; then
    echo "Création de wp-config.php"
    wp config create --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path="${WP_PATH}"

    echo " Installation de WordPress"
    wp core install --allow-root \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path="${WP_PATH}"

    echo "Création du user secondaire"
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root --path="${WP_PATH}"
fi

#  Lancement PHP-FPM
exec /usr/sbin/php-fpm7.4 -F

