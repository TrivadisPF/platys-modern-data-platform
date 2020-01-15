
# Getting Started with MDP Stack Generator

On this page you generate a simple platform which can then be run on Docker Compose. The platform uses Kafka and Zookeeper and it should be understandable even if you haven't worked with Kafka before. 

## Prerequisites

Make sure that you have already installed the [Docker Engine](https://docs.docker.com/install/), [Docker Compose](https://docs.docker.com/compose/install/) and the [MDP Generator](install.md). 

## Step 1: Initialize the environment

First create a directory holding the platform generator configuration as well as the generated artefacts:

```
mkdir kafka-plaform-example
```

Now let's initialize the current directory to be a Modern Data Platform Stack environment. We specify the concreate stack to use `trivais/modern-data-platform-stack-generator` as well as the version `1.2.0-preview` which is the current version of this generator. With the `-n` option we give the platform a meaningful name. 

```
mdp init -n kafka-platform -sn trivadis/modern-data-platform-stack-generator -sv 1.2.0-preview
```

This generates a `config.yml` file, if it does not exist already, with all the services which can be configured for the platform.

## Step 2: Configure the platform

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


## Step 3: Generate the platform

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

## Step 4: Run the platform 

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


At this point, you have seen the basics of how MDP works.

## Where to go next

* [Explore the full list of MDP commands](commands.md)
* [MDP configuration file reference](configuration.md)