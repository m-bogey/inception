
FROM debian:bullseye

# 🔧 Mise à jour et outils de base
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget php php-fpm php-mysql mariadb-client curl

# 🔥 Téléchargement de WordPress dans /var/www/html
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/html && \
    cd /var/www/html && \
    tar -xzf wordpress-6.0-fr_FR.tar.gz && \
    mv wordpress/* . && \
    rmdir wordpress && \
    rm wordpress-6.0-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/html

# 🔥 Téléchargement et installation du CLI WordPress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# ⚙️ Config PHP
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# 🔥 Script de config WordPress
COPY conf/auto_config.sh /auto_config.sh
RUN chmod +x /auto_config.sh

# 🔥 Correction bug php
RUN mkdir -p /run/php

# Expose le port PHP-FPM
EXPOSE 9000

# 🚀 Lancement avec le script d'auto-config
ENTRYPOINT ["/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]

