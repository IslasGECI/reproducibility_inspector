FROM docker:19
RUN apk update && apk upgrade && apk add \
    bash \
    curl \
    git \
    mercurial
RUN mkdir -p \
    ${HOME}/IslasGECI \
    ${HOME}/repositorios/reproducibility_inspector/data
