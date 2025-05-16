# Working with Solace and Kafka


## Producing Message to Solace over MQTT

```bash
docker run -it --rm --network demo-platform efrecon/mqtt-client sub -h solace-pubsub -p 1883 -t "truck/+/position" -v
```

```bash
docker run --network demo-platform trivadis/iot-truck-simulator '-s' 'MQTT' '-h' 'solace-pubsub' '-p' '1883' '-f' 'CSV'
```

```bash
echo "creating MQTT Source Connector"

curl -X "POST" "$DOCKER_HOST_IP:8083/connectors" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "mqtt-truck-position-source",
  "config": {
    "connector.class": "com.solace.connector.kafka.connect.source.SolaceSourceConnector",
    "tasks.max": "1",
    "sol.host": "tcp://solace-pubsub:55555",
    "sol.username": "admin",
    "sol.password": "abc123!",
    "sol.vpn_name": "default",
    "sol.topics": "truck/*/position",
    "sol.message_processor_class": "com.solace.connector.kafka.connect.source.msgprocessors.SolSampleSimpleMessageProcessor",
    "kafka.topic": "truck_position",
    "value.converter": "org.apache.kafka.connect.converters.ByteArrayConverter",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter"
  }
}'
```



## Working with Kafka Proxy


`/data-transfer/producer.properties`

```
enable.idempotence=false


## A sample config file for testing the Solace Kafka Proxy with Kafka Console Producer app

## The username and password used here will be passed transparently by the Proxy
## to the Solace broker, and used to login to the Proxy's Message VPN.


sasl.mechanism=PLAIN
# Configure SASL_SSL if SSL encryption is enabled, otherwise configure SASL_PLAINTEXT
security.protocol=SASL_PLAINTEXT

sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
  username="user" \
  password="abc123!";

#sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required \
#  username="default" \
#  password="default";
```


```bash
docker exec -ti kafka-1 kafka-console-producer --bootstrap-server 192.168.1.102:59092 --topic test_19 --producer.config /data-transfer/producer.properties
```