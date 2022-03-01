# Confluent MQTT Proxy

MQTT Proxy provides a scalable and lightweight interface that allows MQTT clients to produce messages to Apache Kafka® directly, in a Kafka-native way that avoids redundant replication and increased lag.

**[Website](https://docs.confluent.io/platform/current/kafka-mqtt/index.html)** | **[Documentation](https://docs.confluent.io/platform/current/kafka-mqtt/index.html)** 


## How to enable?

```
platys init --enable-services KAFKA,KAFKA_MQTTPROXY
platys gen
```

