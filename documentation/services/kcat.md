# kcat (formerly known as Kafkacat)

Generic command line non-JVM Apache Kafka producer and consumer.

**[Website](https://github.com/edenhill/kcat)** | **[Documentation](https://github.com/edenhill/kcat)** | **[GitHub](https://github.com/edenhill/kcat)**

## How to enable?

```
platys init --enable-services KCAT
platys gen
```

## How to use it?

```
docker exec -ti kcat kcat
```

### Consume with Consumer Group

```bah
docker exec -ti kcat kcat -G mygroup mytopic -b kafka-1:19092  -c 1 -o end
```
