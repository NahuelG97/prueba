# Etapa de construcción
FROM node:18-alpine AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto de los archivos del proyecto
COPY . .

# Construir la aplicación
RUN npm run build --prod

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos de la build de Angular al servidor Nginx
COPY --from=build /app/dist/mi-proyecto-angular /usr/share/nginx/html

# Exponer el puerto en el que correrá Nginx
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
