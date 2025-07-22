#!/bin/bash
set -e

# Prend les variables d'env
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Fix ownership
chown -R mysql:mysql /var/lib/mysql

# Init si pas encore fait
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "⏳ Init du data dir MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
fi

# Start MariaDB temporairement
/usr/sbin/mysqld --skip-networking --datadir=/var/lib/mysql &
pid="$!"

# Attente que ça ping
for i in {30..0}; do
    if mysqladmin ping --silent; then
        break
    fi
    echo "⏳ Attente MariaDB ($i)…"
    sleep 1
done

if ! mysqladmin ping --silent; then
    echo " MariaDB n’a pas démarré !" >&2
    exit 1
fi

# Applique l'init SQL avec variables
echo " Setup DB et User…"
mysql -u root <<-EOSQL
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');
    DELETE FROM mysql.user WHERE User='';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Stop temporaire
mysqladmin -u root --password="${DB_ROOT_PASSWORD}" shutdown
wait "$pid"

# Start final
exec /usr/sbin/mysqld --datadir=/var/lib/mysql

