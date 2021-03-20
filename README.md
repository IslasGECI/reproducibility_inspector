# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configuración en una máquina virtual

1. Actualiza el sistema operativo: `sudo apt update && sudo apt dist-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Instala Make y Docker `sudo apt install --yes make docker.io`
1. Verifica que tengas más de 100 GB disponibles para Docker con `df -H /var/lib/docker`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Crea el directorio de trabajo: `mkdir --parents /home/ciencia_datos/.testmake`
1. Crea un volumen de Docker con los secretos del equipo. ([Ver más
   información.](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing))

## Construye imagen de Docker

Clona el repo, construye la imagen y corre el contendor:

```shell
git clone https://github.com/IslasGECI/reproducibility_inspector.git
cd reproducibility_inspector
make --file=build/Makefile tests
make --file=build/Makefile image
make --file=build/Makefile container
```
