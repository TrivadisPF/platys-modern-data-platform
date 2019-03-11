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

Build the Oracle REST Data Service docker image 

```
./buildDockerImage.sh -v 18.3.0 -e -i
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

## Kafka MQTT Broker

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
```