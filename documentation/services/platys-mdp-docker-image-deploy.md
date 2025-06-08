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
docker build platys/hello-world:latest .

docker deploy platys/hello-world:latest .
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




