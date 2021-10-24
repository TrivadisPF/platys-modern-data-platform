# Confluent Control Center

Confluent Control Center is a web-based tool for managing and monitoring Apache Kafka®. Control Center provides a user interface that allows developers and operators to get a quick overview of cluster health, observe and control messages, topics, and Schema Registry, and to develop and run ksqlDB queries.

**[Website](https://docs.confluent.io/platform/current/control-center/index.html)** | **[Documentation](https://docs.confluent.io/platform/current/control-center/index.html)** 

## How to enable?

```bash
platys init --enable-services KAFKA_CCC
platys gen
```

## How to use?

Navigate to <http://${PUBLIC_IP}:9021>