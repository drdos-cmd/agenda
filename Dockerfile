FROM nginx:alpine

# Copiar el archivo de configuración personalizado
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar tu página index.html a la ruta web del servidor
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto 8080 para OpenShift
EXPOSE 8080

# Iniciar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
