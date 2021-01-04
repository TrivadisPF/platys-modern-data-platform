## Confluent MQTT Proxy

In this recipe we will see how we can use the [Confluent MQTT Proxy](https://docs.confluent.io/current/kafka-mqtt/index.html) to talk to a Kafka cluster using the MQTT protocol. 

## Initialise data platform

First [initialize a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA_MQTTPROXY,KAFKA -s trivadis/platys-modern-data-platform -w 1.8.0
```
Add the following entry to the `config.yml` right after the `KAFKA_MQTTPROXY_enable` property:

```
KAFKA_MQTTPROXY_topic_regex_list: 'vehicle_position:.*position'
```

Now generate and start the data platform. 

```
platys gen

docker-compose up -d
```

Create the 2 topics in Kafka:

```
docker exec -it kafka-1 kafka-topics --zookeeper zookeeper-1:2181 --create --topic vehicle_position --partitions 8 --replication-factor 3
docker exec -it kafka-1 kafka-topics --zookeeper zookeeper-1:2181 --create --topic vehicle_engine --partitions 8 --replication-factor 3
```

## Send data to MQTT Proxy

We will be using the vehicle position simulator to send IoT position message to MQTT:
```
docker run trivadis/iot-truck-simulator '-s' 'MQTT' '-h' $DOCKER_HOST_IP '-p' '1882' '-f' 'CSV' '-p' 'SPLIT'
```

## Check that the messages arrive in Kafka

Confluent MQTT Proxy

