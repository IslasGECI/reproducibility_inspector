# Inspector de Reproducibilidad

Verifica si es posible generar los reportes especificados en `analyses.json` de
￼cada repositorio en Git que el equipo IslasGECI tiene en Bitbucket.

```bash
docker build --tag islasgeci/reproducibility_inspector:latest .
```

```bash
docker run \
    --detach \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume reproducibility_inspector_vol:/workdir \
    --volume secrets_vol:/.vault \
    islasgeci/reproducibility_inspector:latest
```

El volumen de Docker `secrets_vol` debe contener el archivo `.secrets` con las
contraseñas del equipo.
