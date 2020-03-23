# How to move docker's default /var/lib/docker to another directory on Ubuntu/Debian Linux

The following config will guide you through a process of changing the docker's default `/var/lib/docker` storage disk space to another directory. There are various reasons why you may want to change docker's default directory from which the most obvious could be that ran out of disk space. The following guide should work for both Ubuntu and Debian Linux or any other systemd system. Make sure to follow this guide in the exact order of execution.

Let's get started by modifying systemd's docker start up script. Open file `/lib/systemd/system/docker.service` with your favorite text editor and replace the following line where `/new/path/docker` is a location of your new chosen docker directory:

FROM: `ExecStart=/usr/bin/docker daemon -H fd://`<br/>
TO: `ExecStart=/usr/bin/docker daemon -g /new/path/docker -H fd://`

When ready stop docker service:

```shell
$ sudo systemctl stop docker
```

It is important here that you have completely stopped docker daemon. The following linux command will yield no output only if docker service is stopped:

```shell
$ ps aux | grep -i docker | grep -v grep
```

If no output has been produced by the above command, create a new directory you specified above and optionally `rsync` current docker data to a new directory:

```shell
$ sudo mkdir /new/path/docker
$ sudo rsync -aqxP /var/lib/docker/ /new/path/docker
```

Once this is done reload systemd daemon:

```shell
$ sudo systemctl daemon-reload
```

At this stage we can safely restart docker daemon:

```shell
$ sudo systemctl disable docker
$ sudo systemctl enable docker
```

Restart the system and confirm that docker runs within a new data directory:

```shell
$ ps aux | grep -i docker | grep -v grep

root      2095  0.2  0.4 664472 36176 ?        Ssl  18:14   0:00 /usr/bin/docker daemon -g  /new/path/docker -H fd://
root      2100  0.0  0.1 360300 10444 ?        Ssl  18:14   0:00 docker-containerd -l /var/run/docker/
libcontainerd/docker-containerd.sock --runtime docker-runc
```

All done.

## Source

- [How to move docker's default /var/lib/docker to another directory on Ubuntu/Debian Linux](https://linuxconfig.org/how-to-move-docker-s-default-var-lib-docker-to-another-directory-on-ubuntu-debian-linux)
