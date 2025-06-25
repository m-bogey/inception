FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
#COPY conf/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["/entrypoint.sh"]
#CMD ["mysqld"]

