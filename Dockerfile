FROM ubuntu:18.04
COPY . /workdir
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install --yes \
    cron \
    docker.io \
    jq \
    make \
    tzdata
RUN echo $TZ > /etc/timezone && \
    ln --force --no-dereference --symbolic /usr/share/zoneinfo/$TZ /etc/localtime && \ 
    dpkg-reconfigure --frontend noninteractive tzdata
RUN cd /tmp && \
    git clone https://github.com/IslasGECI/misctools.git && \
    cd misctools && \
    make install
RUN mkdir --parents /workdir/IslasGECI && \
    touch /var/log/cron.log
RUN crontab /workdir/src/Cronfile
WORKDIR /workdir
CMD ["cron", "-f"]
