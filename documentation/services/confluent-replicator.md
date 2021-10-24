# Confluent Replicator

Confluent Replicator allows you to easily and reliably replicate topics from one Kafka cluster to another. In addition to copying the messages, Replicator will create topics as needed preserving the topic configuration in the source cluster. 

**[Website](https://docs.confluent.io/platform/current/multi-dc-deployments/replicator/index.html)** | **[Documentation](https://docs.confluent.io/platform/current/multi-dc-deployments/replicator/index.html)** 

## How to enable?

```bash
platys init --enable-services KAFKA_REPLICATOR
platys gen
```

## How to use?

