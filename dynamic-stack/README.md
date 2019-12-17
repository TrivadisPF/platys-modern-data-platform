# Modern Data Platform (MDP) Stack Generator

This is the dynamic version of the Modern Data Platform stack. It is the version we will continue with, the full-stack is no longer maintained. 

The idea here is to specify the possible and supported services in a template file, from which a docker-compose stack file can be generated. The generator is dynamic and services have to be enabled in order for them to appear in the stack. 

You can run the Modern Data Platform Stack Generator (MDP Stack Generator) on macOS and 64-bit Linux.

## MDP Stack Generator

The service generator is available as a docker image from where it can be run. 

It can be found on [Docker Hub](https://hub.docker.com/repository/docker/trivadis/modern-data-platform-stack-generator) under `trivadis/modern-data-platform-stack-generator`.

Tag           |  Description
------------- | --------------------------
1.0.0         | Initial, first version


If you want to build the docker image locally, perform (this is not necessary if you follow the installation instructions below).

```
docker build -t trivadis/modern-data-platform-stack-generator:1.0.0 .
```

## Prerequisites

The MDP Stack Generator relies on the Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

  * On desktop systems install Docker Desktop for Mac and Windows
  * On Linux systems, install the Docker for your OS as described on the Get Docker page

For running the Modern Data Platform Stack you also have to install Docker-Compose. 

## Installing MDP Stack Generator

Follow the instructions below to install the MDP Stack Generator on a Mac or Linux systems. Running on Windows is not yet supported. 

* Run this command to download the current stable release of the MDP Stack Generator:

```
sudo curl -L "https://github.com/TrivadisPF/modern-data-platform-stack/releases/download/1.0.0/mdps-generate.sh" -o /usr/local/bin/mdps-generate
```

* Apply executable permissions to the binary:

```
sudo chmod +x /usr/local/bin/mdps-generate
```
   
## Uninstalling

To uninstall Docker Compose if you installed using `curl`:

```
sudo rm /usr/local/bin/mdps-generate
```
   
## Getting Started with the MDP Stack Generator

Let's see the MDP Stack Generator in Action. We will use it to create a stack running Kafka and Zookeeper.

### Configuring the generator

First create a directory for the project:

```
mkdir mdps-kafka-example
```

In this new folder, create a `config` folder for the custom configuration for the generator and a `docker` folder to hold the generated artefacts.

```
cd mdps-kafka-example
mkdir docker
mkdir config
```

Create a `custom.yml` inside the `config` folder. This file will be used to override the default settings defined in the file  
 [`generator-config/vars/default-values.yml`](./generator-config/vars/default-values.yml) file. These configuration settings are also documented [here](./Configuration.md).

```
nano config/custom.yml
```

Now add the following content (please ensure indentation is respected in your custom file as this is important for YML files) to the `custom.yml` file. 

```
  stack_name: kafka-stack

  ZOOKEEPER_enabled: true
  KAFKA_enabled: true
  KAFKA_manager_enabled: true
  KAFKA_kafkahq_enabled: true

```

You only have to explicitly enable what you need, as each service is disabled by default. Other settings have meaningful defaults as well. 

### Running the generator

Now we can run the MDP Stack Generator providing 3 mandatory positional arguments:

  * the path for your custom yml stack file, i.e. `config/custom.yml`
  * the path on where the artefacts (such as `docker-compose.yml` file) should be generated to, i.e. `docker`
  * the version of the MDP Stack Generator, actual version is `1.0.0`

From inside the `mdps-kafka-example` folder, run the following command:

```
mdps-generate ${PWD}/config/custom.yml ${PWD}/docker 1.0.0
```

and you should see an output similar to this

```
Running the Modern Data Platform Stack Generator ....

Process Definition: '/opt/analytics-generator/stack-config.yml'
Render template: 'templates/docker-compose.yml.j2' --> 'stacks/docker-compose.yml'
Modern Data Platform Stack generated successfully to /home/bigdata/mdp-kafka-stack-example/docker
```

