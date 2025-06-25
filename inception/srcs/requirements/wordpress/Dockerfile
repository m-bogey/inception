FROM debian:bullseye

RUN apt update && apt install -y \
	php php-fpm php-mysql curl unzip wget

# 🔥 INSTALLE WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

# telecharge wordpress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

#config php
#COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

EXPOSE 9000

# Crée le dossier PID si inexistant
#RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

#CMD ["php-fpm7.4", "-F"]
CMD ["sleep", "infinity"]
