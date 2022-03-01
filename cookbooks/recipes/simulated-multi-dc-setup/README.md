---
technoglogies:      kafka
version:				1.14.0
validated-at:			31.12.2021
---

# Simulated Multi-DC Setup on one machine

This recipe will show how to setup a 2 datacenter Kafka platform on the same machine using docker compose and platys.

## Initialise data platform

We will create two different platforms, each one in its own directory, and configure them so that the service names are not overlapping. 

### Data Center 1

Let's [initialise a platys-supported data platform](../../../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services KAFKA,KAFKA_AKHQ -s trivadis/platys-modern-data-platform -w 1.14.0
```

Rename the `config.yml` file to include the datacenter (`dc1`)

```bash
mv config.yml config-dc1.yml
```

Edit the `config-dc1.yml` file and add the two global properties `data_centers` and `data_center_to_use` and change the header as shown below:

```
      # Default values for the generator
      # this file can be used as a template for a custom configuration
      # or to know about the different variables available for the generator
      platys:
          platform-name: 'dc1-platform'
          platform-stack: 'trivadis/platys-modern-data-platform'
          platform-stack-version: '1.14.0'
          structure: 'subfolder'
      # ========================================================================
      # Global configuration, valid for all or a group of services
      # ========================================================================
      # Timezone, use a Linux string such as Europe/Zurich or America/New_York
      use_timezone: ''
      # the name of the repository to use for private images, which are not on docker hub (currently only Oracle images)
      private_docker_repository_name: 'trivadis'

      data_centers: 'dc1,dc2'
      data_center_to_use: 1

      #
      # ===== Apache Kafka ========
      #
      KAFKA_enable: true
      #
      # ===== Apache Kafka HQ ========
      #
      KAFKA_AKHQ_enable: true
```

The `data_center_to_use` property specifies that this configuration is for the first datacenter, which is named `dc1` by the `data_centers` list property.

Using `subfolder` for the `structure` will generate the platform inside a subfolder named according to the `platform-name`. 

Generate the stack using the `-c` option to specify the config file to use

```bash
platys gen -c ${PWD}/config-dc1.yml
```

You should now have a subfolder named `dc1-platform`

```bash
docker@ubuntu:~/platys-cookbook$ ls -lsa
total 16
4 drwxrwxr-x  3 docker docker 4096 Dec 31 09:12 .
4 drwxr-xr-x 61 docker docker 4096 Dec 31 03:02 ..
4 -rwxr-xr-x  1 docker docker 1122 Dec 31 09:12 config-dc1.yml
4 drwxrwxr-x 12 docker docker 4096 Dec 31 09:12 dc1-platform
```

Navigate into this folder and start the stack for `dc1`

```bash
docker-compose -f dc1-platform/docker-compose.yml up -d
```

### Data Center 2

For data center 2, we could also go trough the `platys init` as before, but we can also just copy the configuration file and adapt it, like shown here

```bash
cp config-dc1.yml config-dc2.yml
```

now edit `config-dc2.yml` and change the property `platform-name` and `data_center_to_use` to specfiy data center 2:

```yaml
      platys:
          platform-name: 'dc2-platform'
...          
      data_center_to_use: 2
```

Generate the stack using the `-c` option to specify the config file to use

```bash
platys gen -c ${PWD}/config-dc2.yml
```

You should now have an additional subfolder named `dc2-platform`

```bash
docker@ubuntu:~/platys-cookbook$ ls -lsa
total 16
4 drwxrwxr-x  3 docker docker 4096 Dec 31 09:12 .
4 drwxr-xr-x 61 docker docker 4096 Dec 31 03:02 ..
4 -rwxr-xr-x  1 docker docker 1122 Dec 31 09:12 config-dc1.yml
4 -rwxr-xr-x  1 docker docker 1122 Dec 31 09:18 config-dc2.yml
4 drwxrwxr-x 12 docker docker 4096 Dec 31 09:12 dc1-platform
4 drwxrwxr-x 12 docker docker 4096 Dec 31 09:20 dc2-platform
```

Navigate into this folder and start the stack for `dc2`

```bash
docker-compose -f dc2-platform/docker-compose.yml up -d
```

We have now 2 different stacks running, each one representing one data center. 

### Work with the two data centers and Kafka

Both stack have their own home page generated. You can find them on port `80` and `81`:
 
 * **DC1** 
   * Homepage: <http://dataplatform:80>
   * Service List: <http://dataplatform:80/services>
 * **DC2**
   * Homepage: <http://dataplatform:81>
   * Service List: <http://dataplatform:81/services>


### Restrictions

Currently only [Zookeeper](../../../documentation/services/zookeeper.md), [Kafka Borker](../../../documentation/services/kafka.md), [Control Center](../../../documentation/services/confluent-control-center.md), [CMAK](../../../documentation/services/cmak.md), [AKHQ](../../../documentation/services/akhq.md) and [Wetty](../../../documentation/services/wetty.md) support to run in two different, simulated data centers. All the other services can still be used, but they should only be enabled in one of the two stacks. 