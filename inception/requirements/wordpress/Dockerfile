FROM debian:latest

RUN apt update && apt upgrade && apt install -y php-fpm

#run php-fpm en avant plan et -F pour forcer run en arrier plan et ignorer daemonize option from configuration file
CMD ["php-fpm8.2", "-F"]
