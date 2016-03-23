# Docker c9-workspace

cloud9 workspace with docker

[![Docker Stars](https://img.shields.io/docker/stars/stangenberg/c9-workspace.svg)][dockerhub] [![Docker Pulls](https://img.shields.io/docker/pulls/stangenberg/c9-workspace.svg)][dockerhub] [![Image Size](https://img.shields.io/imagelayers/image-size/stangenberg/c9-workspace/latest.svg)](https://imagelayers.io/?images=stangenberg/baseimage:latest) [![Image Layers](https://img.shields.io/imagelayers/layers/stangenberg/c9-workspace/latest.svg)](https://imagelayers.io/?images=stangenberg/baseimage:latest)


Dockerhub: [stangenberg/c9-workspace][dockerhub]

## Features ##

- c9.io ssh workspace
- java 8
- nvm v0.31.0
- docker compose
- lightbend activator


## Exposed volumes ##

- /workspace


## Exposed ports ##

- 22 / SSH 


## Environment Variables

- DOCKER_COMPOSE_VERSION
- ACTIVATOR_VERSION
- NVM_VERSION
- JAVA_HOME


## Usage ##

This is a template for new docker images
See [https://github.com/phusion/baseimage-docker](https://github.com/phusion/baseimage-docker) for usage

Write here what to do with it and how - example run commands


## Build 

Make is used as build system.

- `make` / starts normal docker build.
- `make run` / build and run the container. This uses `c9-workspace` as container name and automatically stops a running container with an equal name beforehand. 
- `make bash` /  build, run the container and start a bash prompt.
- `make ncbuild` / normal build without using the docker cache ( --no-cache ).

[Docker Build Reference https://docs.docker.com/reference/builder/](https://docs.docker.com/reference/builder/)


## License ##

[Published under the MIT License][LICENSE]

[DOCKERHUB]: https://hub.docker.com/r/stangenberg/c9-workspace
[LICENSE]: https://bitbucket.org/stangenberg/docker-c9-workspace/src/master/LICENSE.md "Published under the MIT License"