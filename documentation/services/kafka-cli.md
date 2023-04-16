# Apache Kafka CLI

Apache Kafka is an open-source distributed event streaming platform used by thousands of companies for high-performance data pipelines, streaming analytics, data integration, and mission-critical applications. 

This is a container for providing the Kafka CLI without a broker running. It's main use is together with an external Kafka cluster.

**[Website](http://kafka.apache.org)** | **[Documentation](https://kafka.apache.org/documentation)** | **[GitHub](https://github.com/apache/kafka)**

## How to enable?

```
platys init --enable-services KAFKA_CLI
platys gen
```

## How to use?

Connecting to the container for using the CLI's

```bash
docker exec -ti kafka-cli bash
```

Using the `kafka-topics` command to list topics

```bash
docker exec -ti kafka-cli kafka-topics --bootstrap-sever kafka-1:29092 --list
```

