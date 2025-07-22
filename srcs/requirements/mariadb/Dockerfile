FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copie la conf pour bind 0.0.0.0
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Crée le dossier socket
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/entrypoint.sh"]

