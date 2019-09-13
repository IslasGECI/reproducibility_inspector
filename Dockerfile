FROM docker:19
RUN apk update && apk upgrade && apk add \
    bash \
    mercurial
