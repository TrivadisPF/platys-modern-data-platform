# Modern Data Analytics Stack on Docker

The environment is completly based on docker containers. 

Either use the Virtual Machine image made available in the course, containing a docker installation or provisiong your own Docker environemnt including Docker Compose. Find the information for installing [Docker](https://docs.docker.com/install/#supported-platforms) and [Docker Compose](https://docs.docker.com/compose/install/).
 
[Here](../00-setup/README.md) you can find the installation of an Virtual Machine in Azure. 

In order to simplify the provisioning, a single docker-compose configuration is used. All the necessary software will be provisioned using Docker. 

## What is the Analytics Platform?

The following services are provisioned as part of the Analytics Platform: 

 * Apache Zookeeper
 * Kafka Broker 1 -3
 * Confluent Schema Registry
 * Kafka Connect 1-2 
 * Hadoop Namenode
 * Hadoop Datanode
 * Spark Master
 * Spark Worker 1-2
 * Hive Metastore
 * Apache Zeppelin
 * Streamsets Data Collector
 * Schema registry UI
 * Kafka Connect UI
 * Kafka Manager

In this project, there is an example folder with a few different docker compose configuration for various Confluent Platform configurations. 

## Prepare the Docker Compose configuration

On your Docker Machine, create a folder `analyticsplatform`. 

```
mkdir analyticsplatform
cd analyticsplatform
```

Download the code of the [docker-compose.yml](docker-compose.yml) file from GitHub using wget or curl, i.e. 

```
wget https://raw.githubusercontent.com/TrivadisBDS/modern-data-analytics-stack/master/docker-compose.yml
```

## Prepare the environment

Before we can start the environment, we have to set the environment variable `DOCKER_HOST_IP` to contain the IP-address of the Docker Host and another environment variable `PUBLIC_IP` to the public IP address (not the same if you are using a cloud-based environment). 

You can find the IP-Address of the Docker host using the `ifconfig` or `ip addr` command from the shell window. 

In a terminal window, execute the follwoing two commands, setting the two addresses with the values you got in the previous steps:

```
export PUBLIC_IP=40.91.195.92
export DOCKER_HOST_IP=10.0.1.4
```

If you are not on azure, you can set the `PUBLIC_IP` environment variable to the same value as the `DOCKER_HOST_IP`.

You have to repeat that, whever you open a new terminal window and want to perform some commands in the docker-compose environment. 

## Start the environment

Now let's run all the container specified by the Docker Compose configuration. In the terminal window, where you have exported the two environment variables, perform the following command:

```
docker-compose up -d
```

The first time it will take a while, as it has to download many Docker images.

After it has started, you can get the log output of all services by executing
 
```
docker-compose logs -f
```

if you want to see the services running for our environment, perform the following command:

```
docker ps

CONTAINER ID        IMAGE                                            COMMAND                  CREATED             STATUS                           PORTS                                          NAMES
d01fb522accd        apache/nifi:1.6.0                                "/bin/sh -c ${NIFI_B…"   6 hours ago         Up 6 hours                       8443/tcp, 10000/tcp, 0.0.0.0:38080->8080/tcp   stream-processing_nifi_1
9ecf9a3ab42c        trivadisbds/streamsets-kafka-nosql               "/docker-entrypoint.…"   6 hours ago         Up 6 hours                       0.0.0.0:18630->18630/tcp                       stream-processing_streamsets_1
5e96deeff9cc        confluentinc/ksql-cli:5.0.0-beta1                "perl -e 'while(1){ …"   7 hours ago         Up 7 hours                                                                      stream-processing_ksql-cli_1
cf4893312d40        confluentinc/cp-kafka-rest:5.0.0-beta1-1         "/etc/confluent/dock…"   7 hours ago         Up 7 hours                       8082/tcp, 0.0.0.0:8084->8084/tcp               stream-processing_rest-proxy_1
a36ed06fa71f        landoop/schema-registry-ui                       "/run.sh"                7 hours ago         Up 7 hours                       0.0.0.0:8002->8000/tcp                         stream-processing_schema-registry-ui_1
382358f81cf8        confluentinc/cp-enterprise-kafka:5.0.0-beta1-1   "/etc/confluent/dock…"   7 hours ago         Up 7 hours                       9092/tcp, 0.0.0.0:9093->9093/tcp               stream-processing_broker-2_1
e813de06f7cd        confluentinc/cp-enterprise-kafka:5.0.0-beta1-1   "/etc/confluent/dock…"   7 hours ago         Up 7 hours                       0.0.0.0:9092->9092/tcp                         stream-processing_broker-1_1
c2210b42db6e        confluentinc/cp-enterprise-kafka:5.0.0-beta1-1   "/etc/confluent/dock…"   7 hours ago         Up 7 hours                       9092/tcp, 0.0.0.0:9094->9094/tcp               stream-processing_broker-3_1
db2033adfd2a        trivadisbds/kafka-manager                        "./km.sh"                7 hours ago         Restarting (255) 7 seconds ago                                                  stream-processing_kafka-manager_1
676e4f734b09        confluentinc/cp-zookeeper:5.0.0-beta1-1          "/etc/confluent/dock…"   7 hours ago         Up 7 hours                       2888/tcp, 0.0.0.0:2181->2181/tcp, 3888/tcp     stream-processing_zookeeper_1
```

## Port to Service Mapping

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
2181 |	2181 | zookeeper-1     |
2182 |	2181 | zookeeper-2     |
2183 |	2181 | zookeeper-3     |
9092 |	9092 | kafka-1     |
9093 |	9093 | kafka-2     |
9094 |	9094 | kafka-3     |
8086 | 8086 | rest-proxy |
8085 |	8081 | schema-registry     |
8088 | 8088 | ksql-server |
8083 | 8083 | connect-1 |
8084 | 8084 | connect-2 |
8085 | 8085 | connect-3 |
8081 | 8081 | spark-worker-1 |
8082 | 8082 | spark-worker-2 |
18630 |	186330 | streamsets     |
38080 |	8080 | nifi     |
38081 |	8080 | zeppelin, zeppelin-spark     |
28001 |	8000 | kafka-connect-ui     |
28002 |	8000 | schema-registry-ui     |
29000 |	9000 | kafka-manager     |
29020 |	9020 | kafdrop     |
28010 |	8010 | zoonavigator-web     |
29010 |	9010 | zoonavigator-api     |

## Service Snippets

Each service to be used in a stack is described as an independent artefact (currently a file). The name of the file includes the service-name and an optional version. 

For example the file `kafka-5.1.0` would hold

```
  kafka-1:
    image: confluentinc/cp-enterprise-kafka:5.1.0
    hostname: broker-1
    depends_on:
      - zookeeper-1
    ports:
      - "9092:9092"
    environment:
      KAFKA_BROKER_ID: $1
      KAFKA_BROKER_RACK: 'r1'
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper-1:2181'
      KAFKA_ADVERTISED_LISTENERS: 'PLAINTEXT://${DOCKER_HOST_IP}:9092'
      KAFKA_METRIC_REPORTERS: io.confluent.metrics.reporter.ConfluentMetricsReporter
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_DELETE_TOPIC_ENABLE: 'true'
      KAFKA_AUTO_CREATE_TOPICS_ENABLE: 'false'
      KAFKA_JMX_PORT: 9994
      CONFLUENT_METRICS_REPORTER_BOOTSTRAP_SERVERS: broker-1:9092
      CONFLUENT_METRICS_REPORTER_ZOOKEEPER_CONNECT: zookeeper-1:2181
      CONFLUENT_METRICS_REPORTER_TOPIC_REPLICAS: 1
      CONFLUENT_METRICS_ENABLE: 'true'
      CONFLUENT_SUPPORT_CUSTOMER_ID: 'anonymous'
    restart: always
```


## Idea for a stack file
```
stack: 
  properties: 
    key: value
  version: 1.0
  description: 
    a docker stack with Kafka, Streamsets, 
  services:
    [1-3]kafka-5.1.0
    [1-3]zookeeper
    schema-registry
    [1-2]kafka-connect
    schema-registry-ui
    kafka-connect-ui
    streamsets
    spark-master
    spark-worker[1-3]
    hadoop-namenode
    hadoop-datanode[1-3]
```    
    