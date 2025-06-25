#!/bin/bash

# Démarre MySQL en background
mysqld_safe --datadir=/var/lib/mysql &

# Attendre que MySQL soit prêt
sleep 10

# Appliquer le fichier SQL
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF

# Stop le MySQL lancé en arrière-plan
mysqladmin shutdown

# Relance proprement en mode foreground
exec mysqld_safe

