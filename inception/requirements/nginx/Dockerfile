FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/ssl/ /etc/nginx/ssl/

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443

CMD ["/entrypoint.sh"]

