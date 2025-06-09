FROM debian:bullseye

RUN apt update && apt install -y \
    php php-fpm php-mysql curl unzip wget

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]

