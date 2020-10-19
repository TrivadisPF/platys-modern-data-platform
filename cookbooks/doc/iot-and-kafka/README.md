# IoT Data and Kafka

This tutorial will show how to ingest IoT Data into Kafka and from there into Object Storage (Minio) using Kafka. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      KAFKA_enable: true
      STREAMSETS_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
```

Now generate and start the data platform. 


## Create a Topic in Kafka

Create the `sensor-reading` topic by either

1. Use the `kafka-topics` command in `kafka-1` to create the topic

```
docker exec -ti kafka-1 kafka-topics --create --zookeeper zookeeper-1:2181 --topic sensor-reading --replication-factor 1 --partitions 8
```

2. use the AKHQ utility (set `AKHQ_enable` to `true`) by browsing to <http://dataplatform:28107>.

## Run the IoT Simulator

Now let's run the simulator. It is available as the docker image `trivadis/iot-simulator`. 

There are three different ways to do it:

1. run docker container by connecting to the docker-compose network (replace `docker-compose-default` by your network)

```
docker run --network docker-compose_default trivadis/iot-simulator  trivadis/iot-simulator -dt KAFKA -u kafka-1:19092 -cl https://raw.githubusercontent.com/gschmutz/IotSimulator/master/config/sensor-reading-sample.json
```

2. run docker container by connecting over the public IP 

```
docker run trivadis/iot-simulator -dt KAFKA -u ${PUBLIC_IP}:9092 -cl https://raw.githubusercontent.com/gschmutz/IotSimulator/master/config/sensor-reading-sample.json
```

3. run docker container as part of the platform by adding it to  `docker-compose.override.yml` and then run a `docker-compose up -d iot-simulator`

  ```
  version: "3.0"

  services:
    iot-simulator:
      container_name: iot-simulator
      hostname: iot-simulator
      image: trivadis/iot-simulator 
      command: "-dt KAFKA -u kafka-1:19092 -cl https://raw.githubusercontent.com/gschmutz/IotSimulator/master/config/sensor-reading-sample.json"
      restart: unless-stopped
```


## Check for the messages in Kafka

You can use various tools for checking for the messages in Kafka

1. use `kafkacat` from the command line on the docker host (if installed) 

  ```
kafkacat -b ${PUBlIC_IP} -t sensor-reading
```

2. use dockerized `kafkacat` (replace `docker-compose-default` by your network)

  ```
docker run --tty \
      --network docker-compose_default \
      confluentinc/cp-kafkacat \
      kafkacat -b kafka-1:19092 -t sensor-reading
```
 
