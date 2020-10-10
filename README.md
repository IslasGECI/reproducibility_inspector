# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configura tu estación de trabajo:

1. Configura las credenciales del equipo. ([Ver más
   información.](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing))
1. Instala Ansible en tu estación de trabajo: `sudo apt update && sudo apt install ansible --yes`
1. Agrega _reproducibility_inspector_ a tu inventario:
    1. Abre tu inventario para edición: `sudo vim /etc/ansible/hosts`
    1. Agrega la línea: `reproducibility_inspector ansible_host=<IP DEL SERVIDOR DE
       REPRODUCIBILIDAD> ansible_user=ciencia_datos`
    1. Guarda los cambios y sal del editor
1. (Si no lo haz hecho, crea tu clave SSH: `ssh-keygen`)
1. Agrega la clave SSH de tu estación de trabajo al servidor: `ssh-copy-id ciencia_datos@<IP DEL
   SERVIDOR DE REPRODUCIBILIDAD>`

## Configura el servidor de reproducibilidad

1. Configura _reproducibility_inspector_ mediante Ansible desde tu estación de trabajo:
    1. Verifica la configuración: `ansible reproducibility_inspector --module-name ping --become`
    1. Clona este repositorio: `git clone https://github.com/IslasGECI/reproducibility_inspector.git`
    1. Entra al repositorio: `cd reproducibility_inspector`
    1. Corre el _playbook_: `ansible-playbook ansible-playbook.yml`

## Configuración en una máquina virtual

1. Crea una máquina virtual con un disco duro de 256 GB
1. Monta el disco disco duro de 256 GB en `/var/lib/docker` (Ver
   [video](https://youtu.be/jeXFCM9DYNo) sustituyendo `/mnt/datos` por `/var/lib/docker`)
1. Actualiza el sistema operativo: `sudo apt update && sudo apt dist-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Instala Make y Docker `sudo apt install --yes make docker.io`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Crea el directorio de trabajo: `mkdir --parents /home/ciencia_datos/.testmake`
1. Crea un volumen de Docker con los secretos del equipo. ([Ver más
   información.](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing))

## Construye imagen de Docker

Clona el repo y construye la imagen

```shell
git clone https://github.com/IslasGECI/reproducibility_inspector.git
cd reproducibility_inspector
docker build --tag islasgeci/reproducibility_inspector:latest .
```

Ejecuta el contenedor

```shell
docker run \
    --detach \
    --name reproducibility_inspector \
    --restart always \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume ${HOME}/.testmake:/home/ciencia_datos/.testmake \
    --volume ${HOME}/.vault:/.vault \
    --volume reproducibility_inspector_vol:/workdir \
    islasgeci/reproducibility_inspector:latest
```
