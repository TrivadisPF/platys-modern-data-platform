# kcat (formerly known as Kafkacat)

Generic command line non-JVM Apache Kafka producer and consumer.

**[Website](https://github.com/edenhill/kcat)** | **[Documentation](https://github.com/edenhill/kcat)** | **[GitHub](https://github.com/edenhill/kcat)**

## How to enable?

```
platys init --enable-services KCAT
platys gen
```

## How to use it?

against non-secure cluster (`PLAINTEXT`)

```bash
docker exec -ti kcat kcat -b <broker> -t <topic>
```

against secure cluster

```bash
docker exec -ti kcat kcat -b <broker> -t <topic>
			-X security.protocol=SASL_PLAINTEXT
			-X sasl.mechanism=SCRAM-SHA-512
			-X sasl.username=client
			-X sasl.password=client-secret
```

### Consume with Consumer Group

```bash
docker exec -ti kcat kcat -G mygroup mytopic -b kafka-1:19092  -c 1 -o end
```
