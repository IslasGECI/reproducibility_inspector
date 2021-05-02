# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configuración en servidor local o en estación de trabajo

1. Actualiza el sistema operativo: `sudo apt update && sudo apt full-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Instala Git, Make y Docker `sudo apt install --yes git make docker.io`
1. Verifica que tengas más de 100 GB disponibles para Docker con `df -H /var/lib/docker`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Crea el directorio de trabajo: `mkdir --parents ~/.testmake`
1. Configura las credenciales de Bitbucket siguiendo las siguientes
   [instrucciones](https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key/#Set-up-SSH-on-macOS/Linux).

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
Si ocurriera un error se obtendra algo parecido a la siguiente linea:
```
make: *** [...] Error 1
```
De lo contrario todo está bien y las pruebas se ejecutaron con exito.
