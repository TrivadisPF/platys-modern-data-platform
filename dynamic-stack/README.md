![](./../tri_logo_high.jpg)

# Modern Data Platform (MDP) Stack Generator 2.0.0

This is the dynamic version of the Modern Data Platform stack. It is the version we will continue with, the full-stack is no longer maintained. 

The idea here is to specify the possible and supported services in a template file, from which a docker-compose stack file can be generated. The generator is dynamic and services have to be enabled in order for them to appear in the stack. 

You can run the Modern Data Platform Stack Generator (MDP Stack Generator) on macOS and 64-bit Linux.

## MDP Stack Generator

The service generator is available as a docker image from where it can be run. 

It can be found on [Docker Hub](https://hub.docker.com/repository/docker/trivadis/modern-data-platform-stack-generator) under `trivadis/modern-data-platform-stack-generator`.

Tag      | Status         |  Changes
---------|----------------| --------------------------
1.2.0-preview | on-going  | Support of different Jupyter versions, Support of multiple MQTT brokers, InfluxDB added, new version of bash script
1.0.0    | stable         | Initial, first version

If you want to build the docker image locally, perform (this is not necessary if you follow the installation instructions below).

```
docker build -t trivadis/modern-data-platform-stack-generator:1.2.0-preview .
```

## Prerequisites

The MDP Stack Generator relies on the Docker Engine for any meaningful work, so make sure you have Docker Engine installed either locally or remote, depending on your setup.

  * On desktop systems install Docker Desktop for Mac and Windows
  * On Linux systems, install the Docker for your OS as described on the Get Docker page

For running the Modern Data Platform Stack you also have to install Docker-Compose. 

You also need an internet connection in order to download the necessary images. 

## Installing Stack Generator

Follow the instructions below to install the MDP Stack Generator on a Mac or Linux systems. Running on Windows is not yet supported. 

* Run this command to download the current stable release of the MDP Stack Generator:

```
sudo curl -L "https://github.com/TrivadisPF/modern-data-platform-stack/releases/download/2.0.0-preview/mdp.sh" -o /usr/local/bin/mdp
```

* Apply executable permissions to the binary:

```
sudo chmod +x /usr/local/bin/mdp 
```

Use the `--version` option to check that the generator has been installed successfully.

```
$ mdp --version
Trivadis Docker-based Modern Data Platform Generator v2.0.0
```
   
## Uninstalling

To uninstall `mdp` perform

```
sudo rm /usr/local/bin/mdp
```
   
## Getting Started with the MDP Stack Generator

Let's see the MDP Stack Generator in Action. We will use it to create a stack running Kafka and Zookeeper.

### Initialize the environment

First create a directory holding the platform generator configuration as well as the generated artefacts:

```
mkdir kafka-plaform-example
```

Now let's initialize the current directory to be a Modern Data Platform Stack environment. We specify the concreate stack to use `trivais/modern-data-platform-stack-generator` as well as the version `1.2.0-preview` which is the current version of this generator. With the `-n` option we give the platform a meaningful name. 

```
mdp init -n kafka-platform -sn trivadis/modern-data-platform-stack-generator -sv 1.2.0-preview
```

This generates a `config.yml` file, if it does not exist already, with all the services which can be configured for the platform.

### Configuring the platform

Now we have to configure the platform, using the `config.yml` file which have been created by the `init` command above.

```
nano config.yml
```

You should see all the configuration option, similar to this (only showing the first few lines)

```
      # =============== Do to remove ==========================
      stack_name: trivadis/modern-data-platform-stack-generator 
      stack_version: 1.2.0-preview 
      platform_name: kafka-platform 
      hw_arch: x86-64 
      # =============== Do to remove ==========================


      #zookeeper
      ZOOKEEPER_enable: false
      ZOOKEEPER_volume_map_data: false
      ZOOKEEPER_nodes: 1            # either 1 or 3

      #kafka
      KAFKA_enable: false
      KAFKA_entreprise_enable: false
      KAFKA_volume_map_data: false
      KAFKA_broker_nodes: 3
      KAFKA_delete_topic_enable: false
      KAFKA_auto_create_topics_enable: false

      ...
```
You can now enable the options for the services you like for your stack by changing the `false` to `true` value.

You only have to explicitly enable what you need, as each service is disabled by default. Other settings have meaningful defaults as well. So you can also remove the services you don't need. 

All configuration settings are documented [here](./Configuration.md).


### Generate the platform

Now we are ready to generate the platform. From the `kafka-plaform-example` folder, run the following command:

```
cd kafka-plaform-example
mdp gen
```

and you should see an output similar to this

```
Running the Modern Data Platform Stack Generator ....
Destination = /home/bigdata/mdps-stack-test

Process Definition: '/opt/mdps-gen/stack-config.yml'
Loading file '/opt/mdps-gen/stack-config.yml'...
Parsing YAML...
Loading file '/opt/mdps-gen/vars/default-values.yml'...
Parsing YAML...
Loading file '/tmp/custom-stack-config.yml'...
Parsing YAML...
Return cached file '/opt/mdps-gen/vars/default-values.yml'...
Parsing YAML...
Return cached file '/tmp/custom-stack-config.yml'...
Parsing YAML...
Render template: 'templates/docker-compose.yml.j2' --> 'destination/docker-compose.yml'
Loading file '/opt/mdps-gen/templates/docker-compose.yml.j2'...
Parsing YAML...
Dumping YAML...
Writing file '/opt/mdps-gen/destination/docker-compose.yml'...
Render template: 'templates/mdps-services.yml.j2' --> 'destination/mdps-services.yml'
Loading file '/opt/mdps-gen/templates/mdps-services.yml.j2'...
Parsing YAML...
Dumping YAML...
Writing file '/opt/mdps-gen/destination/mdps-services.yml'...
```

You should now find fully configured `docker-compose.yml` file (according to the settings chosen) as well as some static configuration files, necessary for some services. These static configuration files are not dynamically chosen and available, even if you haven't chosen the service they are for. 

### Running the Generated Stack

Now your MDP Stack is ready to be started. Before doing that, you have to create some environment variables, depending on the services you use. In minimum you should create

* `DOCKER\_HOST\_IP` - the IP address of the network interface of the Docker Host
* `PUBLIC\_IP` - the IP address of the public network interface of the Docker Host (different to `DOCKER\_HOST\_IP` if in a public cloud environment

You can set these environment variables persistently on machine (`/etc/environment`) or user (`~/.pam_environment` or `~/.profile`) level. Another option is to use the `.env` file inside the `docker` folder. All environment variables set in there are used when docker compose is started. 

Now let's start the stack. In a terminal window, navigate into the `docker` folder and execute

```
docker-compose up -d
```

Docker will start downloading the necessary container images and then start the stack. 

To see the logs of all the services, perform

```
docker-compose logs -f
```

You can list a number of service to only see a log for them

```
docker-compose logs -f <service-name> <service-name>
```

To stop and remove the running stack, perform

```
docker-compose down
```

**Note:** be aware that this completely removes the Docker containers and by that all the data within it. If you haven't mapped the data outside the container, then you might lose your work!
