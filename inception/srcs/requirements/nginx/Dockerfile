FROM debian:bullseye

RUN apt update && apt install -y nginx openssl curl #&& rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
#COPY ./conf/ssl/ /etc/nginx/ssl/
COPY ./tools/html /var/www/html

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
#CMD ["/entrypoint.sh"]

