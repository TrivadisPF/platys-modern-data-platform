
# Getting Started with `platys` and `modern-data-platform` stack

On this page you generate a simple platform which is based on the `modern-data-platform` stack and can then be run using Docker Compose. 

The platform we will create here, uses Kafka and Zookeeper, but the process should be understandable even if you haven't worked with Kafka before. 

## Prerequisites

Make sure that you have already installed the [Docker Engine](https://docs.docker.com/install/), [Docker Compose](https://docs.docker.com/compose/install/) and the [`platys`](../../../documentation/install.md) toolset. 

## Step 1: Initialise the environment

First create a directory, which will hold the `platys` configuration as well as the generated artefacts:

```
mkdir kafka-platform-example
cd kafka-platform-example
```

Now let's initialise the current directory to use the Modern Data Analytics Platform Stack. 

We specify the platform stack name `trivadis/platys-modern-data-platform` to use as well as the stack version `1.8.0` (the current version of this platform stack). 

With the `-n` option we give the platform a meaningful name. 

```
platys init -n kafka-platform --stack trivadis/platys-modern-data-platform --stack-version 1.8.0 --structure flat
```

This generates a `config.yml` file, if it does not exist already, with all the services which can be configured for the platform.

## Step 2: Configure the platform

Now we can configure the platform, using the `config.yml` file which has been created by the `init` command above.

In an editor (i.e. `nano`) open this configuration file. 

```
nano config.yml
```

You can see the configuration options, available through this platform stack, similar to this (only showing the first few lines)

```
 # Default values for the generator
 # this file can be used as a template for a custom configuration
 # or to know about the different variables available for the generator
      platys:
        platform-name: 'kafka-platform'
        platform-stack: 'trivadis/platys-modern-data-platform'
        platform-stack-version: '1.8.0'
        structure: 'flat'

      # ===== Apache Zookeeper ========
      KAFKA_enable: true
      # one of enterprise, community
      KAFKA_edition: 'community'
      KAFKA_volume_map_data: false
      KAFKA_broker_nodes: 3
      KAFKA_delete_topic_enable: false
      KAFKA_auto_create_topics_enable: false

      ...
```

You can now enable the options for the services you want the platform to support by changing `false` to `true`.

For enabling Kafka and Zookeeper, all we have to do is set the `ZOOKEEPER_enable` and `KAFKA_enable` flag to `true`

      #zookeeper
      ZOOKEEPER_enable: true
      ZOOKEEPER_volume_map_data: false
      ZOOKEEPER_nodes: 1            # either 1 or 3

      #kafka
      KAFKA_enable: true
      KAFKA_entreprise_enable: false
      KAFKA_volume_map_data: false
      KAFKA_broker_nodes: 3
      KAFKA_delete_topic_enable: false
      KAFKA_auto_create_topics_enable: false

You only have to explicitly enable what you need, as each service is disabled by default. Other settings have meaningful defaults as well. So you can also delete the values for all the services you don't need. 

All configuration settings for the `platys-modern-data-platform` platform stack are documented [here](Configuration.md).


A shortcut exists with the `--enable-services` flag, which directly generates a `config.yml` file with the services needed. So to only enable `ZOOKEEPER` and `KAFKA`, we can use

```
platys init --enable-services ZOOKEEPER,KAFKA --stack trivadis/platys-modern-data-platform --stack-version 1.8.0  
```

which produces the following `config.yml`

```
      # Default values for the generator
      # this file can be used as a template for a custom configuration
      # or to know about the different variables available for the generator
      platys:
          platform-name: 'default'
          platform-stack: 'trivadis/platys-modern-data-platform'
          platform-stack-version: '1.8.0'
          structure: 'flat'
      # ===== Global configuation, valid for all or a group of services ========
      # Timezone, use a Linux string such as Europe/Zurich or America/New_York
      use_timezone: ''
      # the name of the repository to use for private images, which are not on docker hub (currently only Oracle images)
      private_docker_repository_name: 'trivadis'
      # ===== Apache Zookeeper ========
      ZOOKEEPER_enable: true
      # ===== Apache Kafka ========
      KAFKA_enable: true
```

if you want to know the service names you can use with the `--enable-services` flag you can query for it using the `list_services` command.

```
platys list_services --stack trivadis/platys-modern-data-platform --stack-version 1.8.0
```

## Step 3: Generate the platform

Now we are ready to generate the platform. In the `kafka-plaform-example` folder, run the following command:

```
platys gen
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
Modern Data Platform Stack generated successfully to /home/docker/Desktop/kafka-plaform-example
```

You now find a fully configured `docker-compose.yml` file (with the services enabled in the `config.yml`) as well as some static configuration files, necessary for the services.

## Step 4: Run the platform 

Now the Platform is ready to be started. Before doing that, you have to create some environment variables, depending on the services you use. In minimum you should create

* `DOCKER_HOST_IP` - the IP address of the network interface of the Docker Host
* `PUBLIC_IP` - the IP address of the public network interface of the Docker Host (different to `DOCKER_HOST_IP` if in a public cloud environment

You can set these environment variables persistently on the machine (`/etc/environment`) or user (`~/.pam_environment` or `~/.profile`) level. 
Another option is to use the `.env` file in the folder where the `docker-compose.yml` file is located. All environment variables set in there are used when the docker compose environment is started. 

Now let's start the platform. In a terminal window, execute

```
docker-compose up -d
```

Docker will start downloading the necessary container images and then start the platform. 

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


At this point, you have seen the basics of how `platys` works using the `modern-data-platform` stack. 

## Where to go next

* [Explore the full list of Platys commands](overview-platys-command.md)
* [Modern Data Platform Stack configuration file reference](../platform-stacks/modern-data-platform/documentation/configuration.md)
