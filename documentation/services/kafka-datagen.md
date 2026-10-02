# Kafka Datagen

Kafka Datagen generates and produces messages to Kafka topics using user-provided Avro schema files or JSON templates. It is built on Quarkus and supports both `avro` and `json` output formats.

**[Documentation](https://hub.docker.com/r/spoud/kafka-datagen)** 

## How to enable?

```bash
platys init --enable-services KAFKA,KAFKA_DATAGEN
platys gen
```

## How to use it?

### Minimal configuration (JSON format)

```yaml
KAFKA_DATAGEN_enable: true
KAFKA_DATAGEN_topic: 'my-topic'
KAFKA_DATAGEN_schema_file: 'my-schema.json'
KAFKA_DATAGEN_schema_keyfield: 'id'
KAFKA_DATAGEN_format: 'json'
```

Place the schema file in `conf/kafka-datagen/` before running `platys gen`. The file is volume-mapped into the container at `/config/`.

### Avro format (requires Schema Registry)

```yaml
KAFKA_DATAGEN_enable: true
KAFKA_DATAGEN_topic: 'my-topic'
KAFKA_DATAGEN_schema_file: 'my-schema.avro'
KAFKA_DATAGEN_schema_keyfield: 'id'
KAFKA_DATAGEN_format: 'avro'
SCHEMA_REGISTRY_enable: true
```

When `KAFKA_DATAGEN_format` is set to `avro`, the service automatically uses the Confluent Avro serializer and wires the Schema Registry URL.

### Control throughput and limits

Additional environment variables can be set via the `KAFKA_DATAGEN_*` parameters or by editing the generated `docker-compose.yml` directly:

| Variable | Default | Description |
|---|---|---|
| `RATE` | `10` | Messages produced per second |
| `MAX_RECORDS` | `0` | Maximum records to produce (0 = unlimited) |
| `POISON_PILL_ENABLED` | `false` | Inject a poison pill message periodically |
| `LATE_EVENTS_PERCENTAGE` | `0` | Percentage of late events to inject |

## Schema file format

Schema files go in `conf/kafka-datagen/` and are referenced by filename only (not the full path), e.g.:

```yaml
KAFKA_DATAGEN_schema_file: 'clickstream_users_schema.avro'
```

Refer to the [spoud/kafka-datagen GitHub](https://github.com/spoud/kafka-datagen) for schema file examples and the full list of supported configuration properties.
