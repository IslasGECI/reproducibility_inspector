# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configuración en servidor local o en estación de trabajo

1. Actualiza el sistema operativo: `sudo apt update && sudo apt dist-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Instala Git, Make y Docker `sudo apt install --yes git make docker.io`
1. Verifica que tengas más de 100 GB disponibles para Docker con `df -H /var/lib/docker`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Crea el directorio de trabajo: `sudo mkdir --parents /home/ciencia_datos/.testmake`
1. Crea un archivo con las credenciales del equipo. ([Ver más
   información.](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing))

## Construye imagen de Docker

Clona el repo, corre las pruebas del hospedero, construye la imagen, corre el contendor y corre las
pruebas del contenedor huesped:

```shell
git clone https://github.com/IslasGECI/reproducibility_inspector.git
cd reproducibility_inspector
make --file=build/Makefile tests
make --file=build/Makefile image
make --file=build/Makefile container
docker exec reproducibility_inspector make tests
```
