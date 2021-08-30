# Kafka Broker

**[Website](http://kafka.apache.org)** | **[Documentation](https://kafka.apache.org/documentation)** | **[GitHub](https://github.com/apache/kafka)**

```
platys init --enable-services KAFKA
platys gen
```

## Using Kafka CLI

```
docker exec -ti kafka-1 bash
```

```
kafka-topics --bootstrap-sever kafka-1:29092 --list
```

