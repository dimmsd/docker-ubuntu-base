[![Build Status](https://travis-ci.org/dimmsd/docker-ubuntu-base.svg?branch=master)](https://travis-ci.org/dimmsd/docker-ubuntu-base)

## Ubuntu base image

[The Docker Hub page](https://hub.docker.com/r/dimmsd/ubuntu-base)

Image size  165 MB

Squashing images with [docker-squash](https://github.com/goldmann/docker-squash) 107 MB

Image size if the image is built with --squash option  139 MB

### Using the `Makefile`

```
$ make help
build				Build a Dockerfile
build-s				Build a Dockerfile with --squash option (experimental mode)
build-ds			Build a Dockerfile with docker-squash (need instelled docker-sqush)
run				Run image and start interactive bash session
```

How install `docker-squash` see [github project page](https://github.com/goldmann/docker-squash)

### Example

```
$ git clone git://github.com/dimmsd/docker-ubuntu-base.git
$ cd docker-ubuntu-base
$ cp .env.example .env
$ make build
```

### Enable docker experimental mode

```
$ echo $'{\n    "experimental": true\n}' | sudo tee -a /etc/docker/daemon.json;
$ sudo systemctl restart docker
```


### Run Docker commands without sudo

##### 1. Add the `docker` group if it doesn't already exist

```console
$ sudo groupadd docker
```

##### 2. Add the connected user `$USER` to the docker group

Optionally change the username to match your preferred user.

```console
$ sudo gpasswd -a $USER docker
```

##### 3. Restart the `docker` daemon

```console
$ sudo service docker restart
# OR
$ sudo service docker.io restart
# OR
$ sudo systemctl restart docker
```

##### 4. Known Issues

```console
$ WARNING: Error loading config file: /home/<user>/.docker/config.json: stat /home/<user>/.docker/config.json: permission denied
# Fix
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ sudo chmod g+rwx "/home/$USER/.docker" -R
```

