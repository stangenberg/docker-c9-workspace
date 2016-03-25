# Docker c9-workspace

cloud9 workspace with docker

[![Docker Stars](https://img.shields.io/docker/stars/stangenberg/c9-workspace.svg)][dockerhub] [![Docker Pulls](https://img.shields.io/docker/pulls/stangenberg/c9-workspace.svg)][dockerhub] [![Image Size](https://img.shields.io/imagelayers/image-size/stangenberg/c9-workspace/latest.svg)](https://imagelayers.io/?images=stangenberg/c9-workspace:latest) [![Image Layers](https://img.shields.io/imagelayers/layers/stangenberg/c9-workspace/latest.svg)](https://imagelayers.io/?images=stangenberg/c9-workspace:latest)


Dockerhub: [stangenberg/c9-workspace][dockerhub]

## Features ##

- c9.io ssh workspace
- java 8
- nodejs
- nvm v0.31.0
- docker compose
- lightbend activator


## Exposed volumes ##

- /workspace


## Exposed ports ##

- 22 / SSH 
- 8080, 8081, 8082 / c9.io mapped preview ports 

## Environment Variables

- DOCKER_COMPOSE_VERSION
- ACTIVATOR_VERSION
- NVM_VERSION
- JAVA_HOME


## Usage ##

1. Start a container.
  
  `docker run --name="c9-workspace" -p 22 stangenberg/c9-workspace:latest`

2. Connect a c9.io ssh workspace to the container.


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