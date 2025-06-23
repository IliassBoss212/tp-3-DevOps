# Étape 1 : Build de l'application React
FROM node:18-alpine AS build

# Crée un dossier de travail
WORKDIR /app

# Copie les fichiers package pour installer les dépendances
COPY app/package.json app/package-lock.json ./

# Installation des dépendances
RUN npm install

# Copie le reste de l'application
COPY app/ .

# Construction de l'app React
RUN npm run build

# Étape 2 : Serveur web avec Nginx
FROM nginx:alpine

# Supprime la config HTML par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copie les fichiers générés par React dans Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Lancement de Nginx
CMD ["nginx", "-g", "daemon off;"]

