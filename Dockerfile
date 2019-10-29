FROM docker:19
RUN apk update && apk upgrade && apk add \
    bash \
    curl \
    git \
    make
RUN mkdir --parents \
    ${HOME}/IslasGECI \
    ${HOME}/repositorios/reproducibility_inspector/data
