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

## MQTT Broker

### Mosquitto
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
### HiveMQ

```
  mqtt-2:
    image: hivemq/hivemq3
    hostname: mqtt-2
    container_name: mqtt-2
    ports: 
      - "1882:1883"
      - "48080:8080"
    restart: always
```
### HiveMQ Web Client
 
```
  mqtt-ui:
    image: vergissberlin/hivemq-mqtt-web-client
    hostname: mqtt-ui
    container_name: mqtt-ui
    restart: always
    ports:
      - '28082:80'
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

## Confluent Control Center

``` 
  control-center:
    image: confluentinc/cp-enterprise-control-center:5.2.1
    hostname: control-center
    container_name: control-center
    depends_on:
      - zookeeper-1
      - broker-1
      - schema-registry
      - connect-1
    ports:
      - "29021:9021"
    environment:
      CONTROL_CENTER_BOOTSTRAP_SERVERS: 'broker-1:9092,broker-2:9093'
      CONTROL_CENTER_ZOOKEEPER_CONNECT: 'zookeeper-1:2181'
      CONTROL_CENTER_CONNECT_CLUSTER: 'connect-1:8083'
      CONTROL_CENTER_KSQL_URL: "http://ksql-server-1:8088"
      CONTROL_CENTER_KSQL_ADVERTISED_URL: "http://ksql-server-1:8088"
      CONTROL_CENTER_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      CONTROL_CENTER_REPLICATION_FACTOR: 1
      CONTROL_CENTER_INTERNAL_TOPICS_PARTITIONS: 1
      CONTROL_CENTER_MONITORING_INTERCEPTOR_TOPIC_PARTITIONS: 1
      CONFLUENT_METRICS_TOPIC_REPLICATION: 1
      PORT: 9021
    restart: always
``` 

## Apache Ranger
```     
  ranger-admin:
    image: wbaa/rokku-dev-apache-ranger:0.0.17
    container_name: ranger-admin
    stdin_open: true
    tty: true
    depends_on:
      - "postgres-server"
      - "ceph"
    ports:
      - "6080:6080"

  ceph:
    image: ceph/daemon:v3.0.5-stable-3.0-luminous-centos-7
    container_name: ceph
    environment:
      - CEPH_DEMO_UID=ceph-admin
      - CEPH_DEMO_ACCESS_KEY=accesskey
      - CEPH_DEMO_SECRET_KEY=secretkey
      - CEPH_DEMO_BUCKET=demobucket
      - RGW_NAME=localhost
      - RGW_CIVETWEB_PORT=8010
      - NETWORK_AUTO_DETECT=4
      - RESTAPI_LOG_LEVEL=debug
    ports:
      - 8010:8010
      - 35000:5000
    command: demo

  postgres-server:
    image: wbaa/rokku-dev-apache-ranger-postgres:0.0.17
    container_name: postgres-server
``` 

## Solr

Source: <https://github.com/docker-solr/docker-solr-examples/blob/master/docker-compose/docker-compose.yml>

``` 
  solr:
    image: solr:8.0.0
    container_name: solr
    environment:
      - ZK_HOST=zookeeper-1:2181
#    volumes:
#      - data:/opt/solr/server/solr/mycores
    ports:
      - "8983:8983"
    restart: always
``` 

## Pre-Provisioning Kafka Topics
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


## Pre-Provisioning Streamsets Pipelines

``` 
  streamsets-setup:
    image: tutum/curl
    hostname: streamsets-setup
    container_name: streamsets-setup
    depends_on:
      - streamsets
    volumes:
      - ./streamsets-pipelines:/import
    command:
      - bash 
      - -c 
      - |
        echo "Waiting for Streamsets to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} http://streamsets:18630/rest/v1/pipelines/status) -ne 200 ] ; do 
          echo -e $$(date) " Streamsets state: " $$(curl -s -o /dev/null -w %{http_code} http://streamsets:18630/rest/v1/pipelines/status) " (waiting for 200)"
          sleep 5 
        done
        nc -vz streamsets 18630
        echo -e "\n--\n+> Creating Streamsets Pipelines"
        curl -XPOST -u admin:admin -v -H 'Content-Type: multipart/form-data' -H 'X-Requested-By: My Import Process' -F file=@/import/pipelines-V1.0.zip http://streamsets:18630/rest/v1/pipelines/import
        sleep infinity
        
``` 
## Pre-Provisioning Kafka Connect

```
  connect:
    image: confluentinc/cp-kafka-connect:5.3.0
    hostname: connect
    container_name: connect
    depends_on:
      - zookeeper
      - broker
      - schema-registry
    ports:
      - "8083:8083"
    volumes:
      - ./kafka-connect-jdbc-sink-hafen-vm.json:/opt/kafka-connect-jdbc-sink-hafen-vm.json:Z
    environment:
      CONNECT_BOOTSTRAP_SERVERS: 'broker:29092'
      CONNECT_REST_ADVERTISED_HOST_NAME: connect
      CONNECT_REST_PORT: 8083
      CONNECT_GROUP_ID: compose-connect-group
      CONNECT_CONFIG_STORAGE_TOPIC: docker-connect-configs
      CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_OFFSET_FLUSH_INTERVAL_MS: 10000
      CONNECT_OFFSET_STORAGE_TOPIC: docker-connect-offsets
      CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_STATUS_STORAGE_TOPIC: docker-connect-status
      CONNECT_STATUS_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_KEY_CONVERTER: org.apache.kafka.connect.storage.StringConverter
      CONNECT_VALUE_CONVERTER: io.confluent.connect.avro.AvroConverter
      CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: http://schema-registry:8081
      CONNECT_INTERNAL_KEY_CONVERTER: "org.apache.kafka.connect.json.JsonConverter"
      CONNECT_INTERNAL_VALUE_CONVERTER: "org.apache.kafka.connect.json.JsonConverter"
      CONNECT_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      # Assumes image is based on confluentinc/kafka-connect-datagen:latest which is pulling 5.1.1 Connect image
      CLASSPATH: /usr/share/java/monitoring-interceptors/monitoring-interceptors-5.3.0.jar
      CONNECT_PRODUCER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"
      CONNECT_CONSUMER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"
      CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components"
      CONNECT_LOG4J_ROOT_LOGLEVEL: WARN
      CONNECT_LOG4J_LOGGERS: org.apache.zookeeper=ERROR,org.I0Itec.zkclient=ERROR,org.reflections=ERROR
    command:
      - bash 
      - -c 
      - |
        /etc/confluent/docker/run & 
        echo "Waiting for Kafka Connect to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} http://connect:8083/connectors) -ne 200 ] ; do 
          echo -e $$(date) " Kafka Connect listener HTTP state: " $$(curl -s -o /dev/null -w %{http_code} http://connect:8083/connectors) " (waiting for 200)"
          sleep 5 
        done
        nc -vz connect 8083
        echo -e "\n--\n+> Creating Kafka Connect TimescaleDB sink"
        curl -X POST -H "Content-Type: application/json" -d @/opt/kafka-connect-jdbc-sink-hafen-vm.json http://connect:8083/connectors
        sleep infinity
```


## Pre-Provisioning Schema-Registry

```
  schema-registry-setup:
    image: blacktop/httpie
    hostname: schema-registry-setup
    container_name: schema-registry-setup
    volumes:
      - ./avro-schemas:/import:Z
    entrypoint: /bin/sh
    command:
      - -c 
      - |
        echo "Waiting for Schema-Registry to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} http://schema-registry:8081/subjects) -ne 200 ] ; do 
          echo -e $$(date) " Schema-Registry state: " $$(curl -s -o /dev/null -w %{http_code} http://schema-registry:8081/subjects) " (waiting for 200)"
          sleep 5 
        done
        nc -vz schema-registry 8081
        echo -e "\n--\n+> Registering Avro Schemas"
        
        http -v --ignore-stdin POST http://schema-registry:8081/subjects/Barge/versions Accept:application/vnd.schemaregistry.v1+json schema=@/import/Barge-v1.avsc        

        sleep infinity
    restart: always
```
