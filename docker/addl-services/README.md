# Additional Services for the Advanced Data Platform


## Oracle RDMBS
Oracle is not available as pre-built images on Docker Hub. Instead you have to built a container on your own using the Dockerfiles Oracle provides on GitHub. 


### Express Edition 18.4.0

In a terminal window, navigate to the `18.4.0` folder

```
cd dockerfiles/18.4.0
```

Now build the Oracle XE docker image 

```
./buildDockerImage.sh -v 18.4.0 -x -i
```

Run a standalone container instance using the following command

```
docker run --name xe \
		-p 1521:1521 -p 5500:5500 \
		-e ORACLE_PWD=manager \
		-e ORACLE_CHARACTERSET=AL32UTF8 \
		-v ./work/docker/db_setup_scripts:/opt/oracle/scripts/setup \
		oracle/database:18.4.0-xe
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.4.0-xe
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

### Standard Edition 18.3.0

In a terminal window, navigate to the `18.3.0` folder

```
cd dockerfiles/18.3.0
```

Now build the Oracle Standard Edition docker image 

```
./buildDockerImage.sh -v 18.3.0 -s -i
```

Run a standalone container instance using the following command

```
docker run --name orcl \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-e ORACLE_PWD=manager \
-e ORACLE_CHARACTERSET=AL32UTF8 \
oracle/database:18.3.0-se2
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.3.0-se2
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_SID: ORCLCDB
      ORACLE_PDB: ORCLPDB1
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

### Enterprise Edition 18.3.0

In a terminal window, navigate to the `18.3.0` folder

```
cd dockerfiles/18.3.0
```

Now build the Oracle Enterprise Edition docker image  

```
./buildDockerImage.sh -v 18.3.0 -e -i
```

Run a standalone container instance using the following command

```
docker run --name orcl \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-e ORACLE_PWD=manager \
-e ORACLE_CHARACTERSET=AL32UTF8 \
-v ${PWD}/db_setup_scripts:/opt/oracle/scripts/setup \
oracle/database:18.3.0-ee
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.3.0-ee
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_SID: ORCLCDB
      ORACLE_PDB: ORCLPDB1
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

## Oracle REST Data Services on Docker

Support available here: <https://github.com/oracle/docker-images/tree/master/OracleRestDataServices>

First you have to build the `OracleJava` docker image. Download the latest server-jre-8uNNN-linux-x64.tar.gz and build it

```
./build.sh
```

Then in the `OracleRestDatabaseService` folder build the Oracle REST Data Service docker image 

```
./buildDockerImage.sh -i
```

Run a standalone instance using the following command

```
docker run --name <container name> \
--network=<name of your created network> \
-p 8888:8888 \
-e ORACLE_HOST=oracle-db \
-e ORACLE_PORT=1521 \
-e ORACLE_SERVICE=XEPDB1 \
-e ORACLE_PWD=manager \
-e ORDS_PWD=manager \
-v [<host mount point>:]/opt/oracle/ords/config/ords \
oracle/restdataservices:18.4.0
```

Or add it as a service to a docker-compose configuration

```
  oracle-rest-1:
    image: oracle/restdataservices:18.4.0
    container_name: oracle-rest-1
    ports:
      - "8888:8888"
    environment:
      ORACLE_HOST: oracle-db
      ORACLE_PORT: 1521
      ORACLE_SERVICE: XEPDB1
      ORACLE_PWD: manager
      ORDS_PWD: manager
    restart: always
```

## Mosquitto MQTT Broker(1 - 2)

``` 
  mosquitto-1:
    image: eclipse-mosquitto:latest
    hostname: mosquitto-1
    ports: 
      - "1883:1883"
      - "9001:9001"
    volumes:
      - ./mosquitto-1.conf:/mosquitto/config/mosquitto.conf
    restart: always
```

``` 
  mosquitto-2:
    image: eclipse-mosquitto:latest
    hostname: mosquitto-2
    ports: 
      - "1884:1883"
      - "9002:9001"
    volumes:
      - ./mosquitto-.conf:/mosquitto/config/mosquitto.conf
    restart: always
```

## Kafka MQTT Proxy

``` 
  kafka-mqtt-1:
    image: confluentinc/cp-kafka-mqtt:5.1.2
    hostname: kafka-mqtt-1
    ports:
      - "1882:1882"
    environment:
      KAFKA_MQTT_TOPIC_REGEX_LIST: 'truck_position:.*position,truck_engine:.*engine'
      KAFKA_MQTT_LISTENERS: 0.0.0.0:1882
      KAFKA_MQTT_BOOTSTRAP_SERVERS: PLAINTEXT://broker-1:9092,broker-2:9093
      KAFKA_MQTT_CONFLUENT_TOPIC_REPLICATIN_FACTOR: 1
    restart: always
```

## Axon Server

``` 
  axon-server:
    image: axoniq/axonserver:4.1 
    container_name: axon-server  
    hostname: axon-server
    ports:
      - 8024:8024
      - 8124:8124
    environment:
      - AXONSERVER_HOSTNAME=axon-server
      - AXONSERVER_EVENTSTORE=/eventstore
      - AXONSERVER_CONTROLDB=/controldb
      - AXONSERVER_HTTP_PORT=8024
      - AXONSERVER_GRPC_PORT=8124
    restart: always
```

## Pre-Provisiong Kafka Topics
``` 
  kafka-setup:
    image: confluentinc/cp-kafka:5.1.2
    hostname: kafka-setup
    container_name: kafka-setup
    depends_on:
      - broker
      - schema-registry
    volumes:
      - $PWD/connectors:/tmp/connectors
      - $PWD/dashboard:/tmp/dashboard
    command: "bash -c 'echo Waiting for Kafka to be ready... && \
                       cub kafka-ready -b broker:9092 1 20 && \
                       kafka-topics --create --if-not-exists --zookeeper zookeeper:2181 --partitions 1 --replication-factor 1 --topic orders && \
                       kafka-topics --create --if-not-exists --zookeeper zookeeper:2181 --partitions 1 --replication-factor 1 --topic order-validations && \
                       echo Waiting 60 seconds for Connect to be ready... && \
                       sleep 60 && \
                       curl -i -X POST -H Accept:application/json -H Content-Type:application/json http://connect:8083/connectors/ -d @/tmp/connectors/connector_elasticsearch_docker.config && \
                       curl -i -X POST -H Accept:application/json -H Content-Type:application/json http://connect:8083/connectors/ -d @/tmp/connectors/connector_jdbc_customers_docker.config && \
                       echo Waiting 90 seconds for Elasticsearch and Kibana to be ready... && \
                       sleep 90 && \
                       /tmp/dashboard/docker-combined.sh'"
    environment:
      # The following settings are listed here only to satisfy the image's requirements.
      # We override the image's `command` anyways, hence this container will not start a broker.
      KAFKA_BROKER_ID: ignored
      KAFKA_ZOOKEEPER_CONNECT: ignored
``` 
