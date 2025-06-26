#!/bin/bash
set -e

# 0) Forcer la bonne ownership du data dir
chown -R mysql:mysql /var/lib/mysql

# 1) Initialisation du data dir
if [ ! -d /var/lib/mysql/mysql ]; then
  echo "⏳ Initialisation du data dir MariaDB..."
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
fi

# 2) Démarre MariaDB en back
/usr/sbin/mysqld --skip-networking --datadir=/var/lib/mysql &
pid="$!"

# 3) Attends la dispo du serveur
for i in $(seq 30 -1 0); do
  mysqladmin ping --silent && break
  echo "⏳ Attente MariaDB ($i)…"
  sleep 1
done

# 4) Vérifie bien que le serveur répond
mysqladmin ping --silent || { echo "❌ MariaDB n’a pas démarré !" >&2; exit 1; }

# 5) Applique l’init SQL
echo "🚀 Applique init SQL…"
mysql -u root <<-EOSQL
  CREATE DATABASE IF NOT EXISTS wordpress_db;
  CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
  GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%';
  FLUSH PRIVILEGES;
EOSQL

# 6) Stop le serveur temporaire
mysqladmin -u root shutdown
wait "$pid"

# 7) Démarre MariaDB en foreground
exec /usr/sbin/mysqld --datadir=/var/lib/mysql

