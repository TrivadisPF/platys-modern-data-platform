# Using MQTT Proxy

This recipe will show how to use the [Confluent MQTT proxy](https://docs.confluent.io/platform/current/kafka-mqtt/intro.html) to enable MQTT clients to use the MQTT 3.1.1 protocol to publish data directly to Apache Kafka. We will be using the IoT Vehicle simulator, which supports publishing data to MQTT.

**Note:** Be aware that the [Confluent MQTT proxy](https://docs.confluent.io/platform/current/kafka-mqtt/intro.html) is part of the Confluent Enterprise Platform and can only be used in production with a valid subscription. Without a license, the Kafka-MQTT can be used for a 30-day trial period.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services KAFKA,KAFKA_MQTTPROXY,KAFKACAT -s trivadis/platys-modern-data-platform -w 1.10.0
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Configure the MQTT Proxy

Before we can use the MQTT Proxy, we have to add a mapping from the MQTT topic hierarchy to a single Kafka Topic. 

In the `config.yml` add the `KAFKA_MQTTPROXY_topic_regex_list` property:

```yaml
      # ===== Confluent MQTT Proxy ========
      #
      KAFKA_MQTTPROXY_enable: true
      KAFKA_MQTTPROXY_topic_regex_list: vehicle_position:.*position
```

Here we specify, that every MQTT topic ending with `position` should be mapped to the `vehicle_position` Kafka topic.

Regenerate and restart the platform

```bash
platys gen

docker-compose up -d
```

## Use the MQTT Proxy

Before we can use the MQTT Proxy, we have to create the Kafka Topic

```bash
docker exec -ti kafka-1 kafka-topics --create --zookeeper zookeeper-1:2181 --topic vehicle_position --replication-factor 3 --partitions 8
```

Let's start a consumer on the topic using [`kafkacat`](https://github.com/edenhill/kafkacat)

```bash
docker exec -ti kafkacat kafkacat -t vehicle_position -b kafka-1:19092
```

Now let's use the proxy by staring the `iot-truck-simulator` program

```bash
docker run trivadis/iot-truck-simulator '-s' 'MQTT' '-h' $DOCKER_HOST_IP '-p' '1882' '-f' 'JSON'
```

After a short while you should see the data arriving in the `vehicle_position` topic.