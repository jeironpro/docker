# ------------------------------------------------------------------------------------------
# Docker
# ------------------------------------------------------------------------------------------

# Docker es una plataforma abierta para desarrollar, distribuir y ejecutar aplicaciones. Docker permite empaquetar una aplicación con todo lo que necesita para ejecutarse y tambien te permite separar las aplicaciones de la infraestructura.

# Los paquetes son contenedores que siempre funcionan igual sin importar el sistema operativo, la computadora o donde se despliegue (local, servidor, nube).

# ------------------------------------------------------------------------------------------
# Contenedor vs maquina virtual
# ------------------------------------------------------------------------------------------

# Existe la confusión entre contenedor y máquina virtual.
# Diferencias entre un contenedor y una máquina virtual
# Una máquina virtual necesita un sistema operativo completo mientras que un contenedor comparte el kernel del sistema.
# Una máquina virtual es pesada mientras que un contenedor es ligero.
# Una máquina virtual es lenta de arrancar mientras que un contenedor arranca en segundos.
# Una máquina virtual consume decenas de GB mientras que un contenedor solo consume pocos MB.

# Un contenedor es como una mini PC que solo contiene lo necesario para ejecutar una app concreta.

# ------------------------------------------------------------------------------------------
# Imagen vs contenedor
# ------------------------------------------------------------------------------------------

# Existe confusión entre imagen y contenedor
# Una imagen es un mdodelo o una plantilla que no cambia mientras que un contenedor es una instancia de una imagen funcionando que si puede cambiar mientras se ejecuta.

# Una imagen es como un receta de un plato y el contenedor es el plato servido.

# ------------------------------------------------------------------------------------------
# Docker engine
# ------------------------------------------------------------------------------------------

# Docker engine es la parte que ejecuta los contenedor que incluye:
# el daemon de docker (dockerd) que escucha las solicitudes de la API de Docker y administra objetos de Docker como imágenes, contenedores, redes y volúmenes. Un daemon también puede comunicarse con otros daemons para administrar los servicios de Docker.
# CLI es el cliente de Docker que permite interactuar con Docker via comandos. Cuando se utilizan comandos como docker run, el cliente envía estos comandos a dockerd para que los ejecute. El comando docker utiliza la API de Docker y puede comunicarse como más de un daemon.
# Y por supuesto la API de docker.

# ------------------------------------------------------------------------------------------
# Docker Hub
# ------------------------------------------------------------------------------------------

# Docker Hub es el repositorio público donde se encuentran muchas imágenes listas para usar. Incluso se puede realizar registros propios privados.

# Primeros comandos
# docker run: ejecuta un contenedor a partir de una imagen.
# docker ps: lista los contenedores en ejecución.
# docker ps -a: lista todos los contenedores incluyendo los detenidos.
# docker stop <id_contenedor>: detiene un contenedor específico en ejecución.
# docker rm <id_contenedor>: elimina un contenedor específico detenido.
# docker images: lista las imágenes disponibles en el sistema.
# docker pull: descarga una imagen específica desde Docker Hub.
# docker run -d -p <port> <contenedor>: ejecuta un contenedor y lo expone en el puerto específico.

# ------------------------------------------------------------------------------------------
# Dockerfile
# ------------------------------------------------------------------------------------------

# Un dockerfile es un archivo de texto que contiene instrucciones para construir una imagen. Cada instrucción crea una capa en la imagen final. Es como una receta paso a paso para el contenedor.

# Instrucciones de un dockerfile
# FROM: indica la imagen base
# RUN: ejecuta todos los comandos en la imagen
# COPY: copia archivos desde tu computadora al contenedor
# CMD: comando que se ejecuta cuando arranca el contenedor
# EXPOSE: indica el puerto que tu aplicación usuará
# WORKDIR: carpeta de trabajo dentro del contenedor

# Ejemplo básico de una imagen Python
# Imagen base
# FROM python:3.12-slim

# Carpeta de trabajo
# WORKDIR /app

# Copiar archivos
# COPY . /app

# Instalar dependencias
# RUN pip install --no-cache-dir -r requirements.txt

# Comando al iniciar
# CMD ["python", "app.py"]

# Exponer puerto
# EXPOSE 5000

# ------------------------------------------------------------------------------------------
# Volúmenes y persistencia de datos
# ------------------------------------------------------------------------------------------

# Un volúmen es un espacio de almacenamiento persistente gestionado por Docker. Los volumenes permiten que los contenedores lean y escriban datos sin perderlos al eliminar o recrear contenedores.

# Comando para volumnes
# docker volume create <nombre_volumen>: crea un volumen
# docker volume ls: lista los volúmenes existentes
# docker volume inspect <nombre_volumen>: inspecciona un volumen
# docker run -d -v <nombre_volumen>:/app/data mi_imagen: usa un volumen en un contenedor, haciendo que todo lo que la app escriba en /app/data persita aunque se elimine el contenedor

# Es posible montar carpetas locales en lugar de volúmenes
# docker run -d -v /home/usuario/mis_datos:/app/data mi_imagen: los cambios hechos en la app /app/data estaran en la carpeta local

# ------------------------------------------------------------------------------------------
# Redes y comunicación entre contenedores
# ------------------------------------------------------------------------------------------

# Las redes y la comunicación son un aspecto clave para crear configuraciones más complejas, como un backend conectado a una base de datos.

# Cada contenedor tiene su propia red interna por defecto (bridge).
# Para que varios contenedores se comuniquen directamente, se crean redes personalizadas.
# Una red permite que los contenedores se encuentren por nombre sin exponer puertos al host necesariamente.

# docker network create mi_red: crea una red personalizada
# docker network ls: lista todas las redes
# docker network inspect mi_red: inspecciona una red específica

# Conectar contenedores a la red
# docker run -d --name backend --network mi_red mi_imagen
# docker run -d --name db --network mi_red mi_imagen
# Con esto el contenedor backend puede conectarse a la base de datos usanod el nombre del contenedor: host="db" port=5432

# Redes y puertos
# Solo se necesitas exponer puertos si se quiere acceder desde una maquina host:
# docker run -d -p 5000:5000 --network mi_red --name backend mi_imagen
# La base de datos no necesita puerto expuesto si solo la usa backend

# ------------------------------------------------------------------------------------------
# Docker compose
# ------------------------------------------------------------------------------------------

# Un docker compose es una herramienta de Docker que permite definir múltiples contenedores y sus relaciones en un solo archivo docker-compose.yml
# Con un solo comando se puede levantar todo el stack, sin ejecutar contenedores uno a uno

# Comandos para el uso de archivos docker compose
# docker-compose up -d: levanta los contenedores y los ejecuta en segundo plano
# docker-compose ps: listar contenedores levantados
# docker-compose down: detiene y elimina contenedores, redes y volúmnes creados

# Para persistencia de datos:
# services:
#   db:
#     image: postgres
#     environment:
#       POSTGRES_PASSWORD: 1234
#     volumes:
#       - db_data:/var/lib/postgresql/data
#     networks:
#       - app_net

# volumes:
#   db_data:
# Con esto todos los datos de PostgreSQL persisten aunque se eliminen los contenedores.

# ------------------------------------------------------------------------------------------
# Docker Hub (publicación de imagenes)
# ------------------------------------------------------------------------------------------

# Crear una cuenta en Docker Hub
# Ve a https://hub.docker.com
# Registro y creación de un nombre de usuario

# Iniciar sesión
# docker login

# Etiquetar imagen para Docker Hub
# Antes de subir la imagen, se necesita etiquetarla con el mismo nombre de usuario que has configurado en Docker Hub
# docker tag mi_imagen nombre_usuario/mi_imagen:1.0

# Subir la imagen a Docker Hub
# docker push nombre_usuario/mi_imagen:1.0
# Esto sube la imagen al repositorio de Docker Hub
# Ahora cualquier persona (o otra maquina) puede descargarla con:
# docker pull nombre_usuario/mi_imagen:1.0

# Buenas prácticas
# Usar versiones (:1.0. :latest) para controlar actualizaciones
# Evitar subir archivos sensibles dentro del contenedor
# Mantener Dockerfiles claros y organizados
