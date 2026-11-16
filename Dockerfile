# Imagen base liviana de Nginx
FROM nginx:alpine

LABEL proyecto="reserva-horas-medicas" \
      descripcion="Servicio web estatico de reserva de horas medicas"

# Copia los archivos estaticos del sitio al directorio que sirve Nginx
COPY src/ /usr/share/nginx/html/

# Nginx escucha en el puerto 80 dentro del contenedor
EXPOSE 80

# Verificacion de salud del servicio
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
