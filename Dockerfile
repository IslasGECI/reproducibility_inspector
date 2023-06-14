FROM ubuntu:22.04
COPY . /workdir
WORKDIR /workdir

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ciencia_datos
ENV TZ=America/Los_Angeles
ENV USER=ciencia_datos

RUN useradd --create-home ${USER}
RUN apt-get update && apt-get install --yes \
    cron \
    curl \
    docker.io \
    jq \
    make \
    tzdata \
    vim
RUN echo $TZ > /etc/timezone && \
    ln --force --no-dereference --symbolic /usr/share/zoneinfo/$TZ /etc/localtime && \ 
    dpkg-reconfigure --frontend noninteractive tzdata
RUN cd /tmp && \
    git clone https://github.com/IslasGECI/testmake.git && \
    cd testmake && \
    make install
RUN mkdir --parents /workdir/IslasGECI && \
    mkdir --parents /workdir/data

RUN crontab /workdir/src/Cronfile
CMD ["cron", "-f"]
