# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de cada repositorio en
Git que el equipo [IslasGECI](https://bitbucket.org/IslasGECI/) tiene en Bitbucket.

## Configuración inicial del servidor

1. Crea el usuario ciencia_datos: `sudo adduser ciencia_datos`
1. Agrega `ciencia_datos` a la lista de sudoers: `sudo usermod -aG sudo ciencia_datos` (hay que
   salir y volver a entrar para que los cambios tengan efecto)
1. Entra a la nueva cuenta: `su - ciencia_datos`
1. Crea el directorio de trabajo: `mkdir --parents /home/ciencia_datos/.testmake`
1. Actualiza el sistema operativo: `sudo apt update && sudo apt dist-upgrade --yes && sudo apt
   autoremove --yes`
1. Configura zona horaria: `sudo dpkg-reconfigure tzdata` (selecciona `America/Los_Angeles`)
1. Instala Git, Make y Docker `sudo apt install --yes git make docker.io`
1. Verifica que tengas más de 100 GB disponibles para Docker con `df -H /var/lib/docker`
1. Agrega usuario al grupo `docker` para correr Docker sin sudo : `sudo usermod -aG docker $USER`
   (hay que salir y volver a entrar para que los cambios tengan efecto)
1. Prueba la instalación de Docker: `docker run hello-world`
1. Configura las credenciales de Bitbucket siguiendo las siguientes
   [instrucciones](https://docs.google.com/document/d/1lY7ycXs4J8wp1OyJCmPsvfB7YdQqscqL52cIZxBP6Rw/edit?usp=sharing).

## Construye imagen de Docker

1. Nos conectamos al servidor:
```shell
ssh ciencia_datos@islasgeci.dev
```
- Si no tenemos las credenciales se las pedimos al encargado

2. Clona el repo:
```shell
git clone https://github.com/IslasGECI/reproducibility_inspector.git
```

3. Corre las pruebas del hospedero:
```shell
cd reproducibility_inspector
git fetch && git checkout origin/develop
make --file=build/Makefile tests
```

4. Construye la imagen:
```shell
make --file=build/Makefile image
```

5. Corre el contendor:
  1. Si está corriendo el contenedor _reproducibility_inspector_ páralo y bórralo:
```shell
docker stop reproducibility_inspector
docker rm reproducibility_inspector
```
  1. Corre el contenedor nuevo:
```shell
make --file=build/Makefile container
```

6. Corre las pruebas del contenedor huesped:
```shell
docker exec reproducibility_inspector make tests
```

Si ocurriera un error se obtendrá algo parecido a la siguiente linea:
```
make: *** [...] Error 1
```
De lo contrario todo está bien y las pruebas se ejecutaron con éxito.
