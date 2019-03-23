# Modern Data (Analytics) Platform (MDP) on Docker

The environment is completly based on docker containers. 

In order to simplify the provisioning, a single docker-compose configuration is used. All the necessary software will be provisioned using Docker. 

## What is the Modern Data (Analytics) Platform?

The following services are provisioned as part of the Modern Data Platform: 

 * Apache Zookeeper
 * Kafka Broker 1 -3
 * Confluent Schema Registry
 * Kafka Connect 1-2
 * Confluent Rest Proxy 1 
 * KSQL Server 1
 * Hadoop Namenode 
 * Hadoop Datanode 1
 * Spark Master
 * Spark Worker 1-2
 * Hive Service
 * Hive Metastore on PostgreSQL
 * Apache Zeppelin
 * Streamsets Data Collector
 * Schema Registry UI
 * Kafka Connect UI
 * Kafka Manager
 * Apache ActiveMQ
 * Mosquitto 1 -2 (as extra)
 * PostreSQL
 * Mongo DB
 * DataStax Enterprise
 * Axon Server
 * Kafka MQTT Proxy 1 (as extra)
 * Oracle RDMBS (as extra)
 * Oracle REST Database Service (as extra)

In this project, there is an example folder with a few different docker compose configuration for various Confluent Platform configurations. 

## Prepare the Docker Compose configuration

On your Docker Machine, create a folder `analyticsplatform`. 

```
mkdir analyticsplatform
cd analyticsplatform
```

Download the code of the [docker-compose.yml](docker-compose.yml) file from GitHub using wget or curl, i.e. 

```
wget https://raw.githubusercontent.com/TrivadisBDS/modern-data-analytics-stack/master/docker/docker-compose.yml
```

Now create a `conf` folder and download the configuration files needed in the `docker-compose.yml` file:

```
#!/bin/bash
mkdir conf
cd conf
base="https://raw.githubusercontent.com/TrivadisBDS/modern-data-analytics-stack/master/docker/conf/"
for file in hadoop-hive.env hadoop.env hive-site.xml hue.ini
do
    wget "$base$file"
done
```

## Prepare the environment

Before we can start the environment, we have to set the environment variable `DOCKER_HOST_IP` to contain the IP-address of the Docker Host and another environment variable `PUBLIC_IP` to the public IP address (not the same if you are using a cloud-based environment). 

You can find the IP-Address of the Docker host using the `ifconfig` or `ip addr` command from the shell window. 

In a terminal window, execute the following two commands, setting the two addresses with the values you got in the previous steps:

```
export PUBLIC_IP=nnn.nnn.nnn.nnn
export DOCKER_HOST_IP=nnn.nnn.nnn
```

If you are not using a cloud based environment, you can set the `PUBLIC_IP` environment variable to the same value as the `DOCKER_HOST_IP`.

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

## Reserved Port to Service Mapping

This table reserves the external ports for the various services. Not all services have to be used in the platform at a given time. But by reserving, we can asure that there are no conflicts if a service is added at a later time.

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
2181 |	2181 | zookeeper-1     |
2182 |	2181 | zookeeper-2     |
2183 |	2181 | zookeeper-3     |
1521 | 1521 | oracle-db |
1882 | 1882 | kafka-mqtt-1 |
1883 | 1883 | mosquitto-1 |
1884 | 1883 | mosquitto-2 |
3306 | 3306 | mysql |
5500 | 5500 | oracle-db |
9001 | 9001 | mosquitto-1 |
9003 | 9001 | mosquitto-2 |
9092 |	9092 | broker-1     |
9093 |	9093 | broker-2     |
9094 |	9094 | broker-3     |
8024 | 8024 | axon-server |
8086 | 8086 | kafka-rest-1 |
8089 |	8081 | schema-registry     |
8088 | 8088 | ksql-server-1 |
8083 | 8083 | connect-1 |
8084 | 8084 | connect-2 |
8085 | 8085 | connect-3 |
8086 | 8086 | rest-proxy-1 |
8081 | 8081 | spark-worker-1 |
8082 | 8082 | spark-worker-2 |
8124 | 8124 | axon-server |
8888 | 8888 | oracle-rest-1 |
18630 | 186330 | streamsets     |
23000 | 3000 | burrow-ui |
23001 | 80 | burrow-dashboard |
23002 | 8000 | burrow     |
28001 | 8000 | kafka-connect-ui     |
28002 | 8000 | schema-registry-ui     |
28080 | 8080 | kadmin     |
28081 | 8080 | adminer     |
29000 | 9000 | kafka-manager     |
29020 | 9020 | kafdrop     |
28010 | 8010 | zoonavigator-web     |
29010 | 9010 | zoonavigator-api     |
38080 | 8080 | nifi     |
38081 | 8080 | zeppelin, zeppelin-spark     |
1883 |	1883 | activemq (mqtt)    |
5672 |	5672 | activemq (amqp)    |
8161 |	8161 | activemq (ui)    |
27017 | 27017 | mongodb |
61613 | 61613 | activemq (stomp)    |
61614 | 61614 | activemq (ws)    |
61616 | 61616 | activemq (jms)    |

## Services accessible on Analytics Platform
The following service are available as part of the Analytics platform. 

Please make sure that you add a entry to your `/etc/hosts` file with the alias `analyticsplatform` and pointing to the IP address of the docker host.

Type | Service | Url
------|------- | -------------
Development | StreamSets Data Collector | <http://analyticsplatform:18630>
Development | Apache NiFi | <http://analyticsplatform:38080/nifi>
Development | Zeppelin  | <http://analyticsplatform:38081>
Runtime | Rest Proxy API  | <http://analyticsplatform:8086>
Runtime | Oracle REST Database Service | <http://analyticsplatform:8888/ords>
Governance | Schema Registry Rest API  | <http://analyticsplatform:8089>
Governance | Schema Registry UI  | <http://analyticsplatform:28002>
Management | Kafka Connect UI | <http://analyticsplatform:28001>
Management | Kafka Manager  | <http://analyticsplatform:29000>
Management | Kafdrop  | <http://analyticsplatform:29020>
Management | Kadmin  | <http://analyticsplatform:28080>
Management | Zoonavigator  | <http://analyticsplatform:28010>
Management | Spark UI  | <http://analyticsplatform:8080>
Management | Hue  | <http://analyticsplatform:8888>
Management | ActiveMQ  | <http://analyticsplatform:8161>
Management | Adminer (RDBMS)  | <http://analyticsplatform:28081>
Management | Axon Server Dashboard | <http://anayticsplatform:8024>
