# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configura tu estación de trabajo

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

> NOTA: Sustituye `<IP DEL SERVIDOR DE REPRODUCIBILIDAD>` por el valor correspondiente. Si tu
> estación de trabajo es el servidor de reproducibilidad, puedes usar `localhost` en lugar de la
> dirección IP.

> NOTA: En el servidor de reproducibilidad, el usuario `ciencia_datos` debe tener privilegios
> _sudo_. En las instrucciones anteriores, puedes sustituir `ciencia_datos` por el nombre de
> cualquier usuario con privilegios _sudo_.

## Configura el servidor de reproducibilidad

1. Configura _reproducibility_inspector_ mediante Ansible desde tu estación de trabajo:
    1. Verifica la configuración: `ansible reproducibility_inspector --module-name ping --become`
    1. Clona este repositorio: `git clone https://github.com/IslasGECI/reproducibility_inspector.git`
    1. Entra al repositorio: `cd reproducibility_inspector`
    1. Corre el _playbook_: `ansible-playbook ansible-playbook.yml`

## Falta pasar lo siguiente a `ansible-playbook.yml`

1. Crea el directorio de trabajo: `mkdir --parents /home/ciencia_datos/.testmake`
1. Construye imagen de Docker: `docker build --tag islasgeci/reproducibility_inspector:latest .`

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
