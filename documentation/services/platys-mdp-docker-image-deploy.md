# Platys Modern Data Platform Docker Image Deploy Service

Executes shell scripts provided in folder `docker-entrypoint-init.d` upon startup. The scripts can use `docker build` and `docker publish` commands to build and deploy docker images to the `docker-registry` running with the platform.

## How to enable?

```
platys init --enable-services DOCKER_REGISTRY, PLATYS_MDP_DOCKER_DEPLOY
platys gen
```

## How to use it?

Place shell scritp(s) into `./init/platys-mdp-docker-build/` folder.

`build-and-deploy.sh`

```bash
docker build -t platys/hello-world:1.0.0 .

docker image tag platys/hello-world:1.0.0 $DOCKER_REGISTRY/platys/hello-world:1.0.0
docker image push $DOCKER_REGISTRY/platys/hello-world:1.0.0
```

`Dockerfile`

```
# Use a lightweight base image
FROM alpine:latest

# Set the working directory
WORKDIR /app

# Create a simple script
RUN echo -e '#!/bin/sh\n\necho "Hello, World!"' > hello.sh && chmod +x hello.sh

# Define the default command
CMD ["./hello.sh"]
```

you have to specify insecure registry, if the docker registry is exposed over http

```daemon.json``

```json
{
    "insecure-registries": ["192.168.1.112:5020", "dataplatform:5020", "localhost:5020"]
}
```




