#!/bin/bash

set -e  # arrête le script en cas d’erreur

# === CONFIG ===
CERT_DIR="/etc/nginx/ssl"
KEY="$CERT_DIR/nginx.key"
CERT="$CERT_DIR/nginx.crt"
DOMAIN="localhost"

# === CRÉATION DU DOSSIER SSL SI NÉCESSAIRE ===
mkdir -p $CERT_DIR

# === GÉNÉRER LE CERTIFICAT SI PAS DÉJÀ PRÉSENT ===
if [ ! -f "$KEY" ] || [ ! -f "$CERT" ]; then
    echo "🚀 Génération du certificat SSL auto-signé pour $DOMAIN"
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "$KEY" \
        -out "$CERT" \
        -subj "/C=FR/ST=75/L=Paname/O=42/OU=Inception/CN=$DOMAIN"
else
    echo "✅ Certificat SSL déjà présent, rien à faire"
fi

# === DÉMARRER NGINX ===
echo "🔥 Lancement de NGINX..."
nginx -g 'daemon off;'

