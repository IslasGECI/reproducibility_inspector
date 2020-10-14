FROM ubuntu:20.04
COPY . /workdir
WORKDIR /workdir
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/inspector
ENV SHELL=/bin/bash
ENV TZ=America/Los_Angeles
ENV USER=inspector
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
RUN mkdir --parents ${HOME}
RUN cd /tmp && \
    git clone https://github.com/IslasGECI/misctools.git && \
    cd misctools && \
    make install
RUN mkdir --parents /workdir/IslasGECI && \
    mkdir --parents /workdir/data && \
    touch /var/log/cron.log
RUN crontab /workdir/src/Cronfile
CMD ["cron", "-f"]
