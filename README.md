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
       REPRODUCIBILIDAD> ansible_user=<NOMBRE DEL USUARIO>`
    1. Guarda los cambios y sal del editor
1. (Si no lo haz hecho, crea tu clave SSH: `ssh-keygen`)
1. Agrega la clave SSH de tu estación de trabajo al servidor: `ssh-copy-id <NOMBRE DEL USUARIO>@<IP
   DEL SERVIDOR DE REPRODUCIBILIDAD>`
1. Verifica la configuración: `ansible reproducibility_inspector --module-name ping --become`

> NOTA: Sustituye `<NOMBRE DEL USUARIO>` e `<IP DEL SERVIDOR DE REPRODUCIBILIDAD>` por los valores
> correspondientes. Si tu estación de trabajo es el servidor de reproducibilidad, puedes usar
> `localhost` en lugar de la dirección IP.

> NOTA: El usuario en el servidor de reproducibilidad debe tener privilegios _sudo_.

## Configura el servidor de reproducibilidad

1. Configura _reproducibility_inspector_ mediante Ansible desde tu estación de trabajo:
    1. Clona este repositorio: `git clone https://github.com/IslasGECI/reproducibility_inspector.git`
    1. Entra al repositorio: `cd reproducibility_inspector`
    1. Corre el _playbook_: `ansible-playbook ansible-playbook.yml`
