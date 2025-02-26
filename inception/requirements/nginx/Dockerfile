# Debian 11 (Bullseye)
FROM debian:bullseye

#Mettre a jour paquets et installer nginx
RUN apt update && apt upgrade && apt install -y nginx

# Lancer nginx en avant plan (daemon off), pour que le conteneur reste actif 
CMD ["nginx", "-g", "daemon off;"]
