# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de
￼cada repositorio en Git que el equipo IslasGECI tiene en Bitbucket.

```shell
docker build --tag islasgeci/reproducibility_inspector:latest .
```

```shell
docker run \
    --detach \
    --name reproducibility_inspector \
    --restart always \
    --volume /.testmake:/.testmake \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume reproducibility_inspector_vol:/workdir \
    --volume secrets_vol:/.vault \
    islasgeci/reproducibility_inspector:latest
```

## Prerrequisitos

El volumen de Docker `secrets_vol` debe contener el archivo `.secrets` con las
contraseñas del equipo.

Debe existir el directorio `/.testmake/` en el hospedero de Docker:

```shell
mkdir --parents /.testmake
chown ${USER}:${USER} /.testmake
```
