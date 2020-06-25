# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configuración de la máquina virtual

1. Crea una máquina virtual con un disco duro de 256 GB
1. Monta el disco disco duro de 256 GB en `/var/lib/docker` (Ver
   [video](https://youtu.be/jeXFCM9DYNo) sustituyendo `/mnt/datos` por `/var/lib/docker`)
1. Actualiza el sistema operativo: `sudo apt update && sudo apt dist-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Agrega variables de entorno a `~/.profile` (sustituye `<USUARIO>` y `<CONTRASEÑA>` con las
   credenciales correspondientes):
    - `export BITBUCKET_USERNAME=<USUARIO>`
    - `export BITBUCKET_PASSWORD=<CONTRASEÑA>`
1. Instala Make y Docker `sudo apt install --yes make docker.io`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Crea el directorio de trabajo: `sudo mkdir /.testmake && sudo chown ${USER}:${USER} /.testmake`
1. Crea un volumen de Docker con los secretos del equipo. ([Ver más
   información.](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing))

## Construye imagen de Docker

Clona el repo y construye la imagen

```shell
git clone https://github.com/IslasGECI/reproducibility_inspector.git
docker build --tag islasgeci/reproducibility_inspector:latest .
```

Ejecuta el contenedor

```shell
docker run \
    --detach \
    --name reproducibility_inspector \
    --restart always \
    --volume ${HOME}/.testmake:${HOME}/.testmake \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume reproducibility_inspector_vol:/workdir \
    --volume secrets_vol:/.vault \
    islasgeci/reproducibility_inspector:latest
```
