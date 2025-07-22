#  Base image Debian solide
FROM debian:bullseye

#  Met à jour la distro et installe NGINX + OpenSSL + outils utiles
RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl vim curl && \
    mkdir -p /etc/nginx/ssl && \
    mkdir -p /var/run/nginx && \
    mkdir -p /var/www/html && \
    rm -rf /var/lib/apt/lists/*

#  Génération du certificat SSL auto-signé direct pendant le build
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Inception/CN=localhost"

#  Droits béton sur le dossier web
RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

#  On balance notre fichier de config nginx modifié
COPY conf/nginx.conf /etc/nginx/nginx.conf

#  On balance aussi nos fichiers web (page HTML de test ou Wordpress plus tard)
#COPY tools/html /var/www/html

#  On ouvre le port HTTPS
EXPOSE 443

#  Et bim, on démarre NGINX en mode foreground comme des bonhommes
CMD ["nginx", "-g", "daemon off;"]

