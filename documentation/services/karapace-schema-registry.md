# Karapace Schema Registry

Karapace is an open-source Confluent-compatible Schema Registry implementation by Aiven. It stores Avro, JSON Schema, and Protobuf schemas in a Kafka topic (`_schemas`) and exposes the Confluent Schema Registry REST API, making it a drop-in replacement.

## Ports

| External Port | Internal Port | Description              |
|:-------------:|:-------------:|--------------------------|
| 8081          | 8081          | Schema Registry REST API |

## Enable in config.yml

```yaml
SCHEMA_REGISTRY_enable: true
SCHEMA_REGISTRY_flavour: karapace
```

## Accessing the Schema Registry

- **REST API**: <http://dataplatform:8081>

List registered subjects:

```bash
curl http://dataplatform:8081/subjects
```

## Key Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `SCHEMA_REGISTRY_karapace_compatibility` | `BACKWARD` | Schema compatibility level |
| `SCHEMA_REGISTRY_karapace_group_id` | `karapace-schema-registry` | Kafka consumer group ID |
| `SCHEMA_REGISTRY_karapace_log_level` | `INFO` | Log level |
| `SCHEMA_REGISTRY_karapace_master_election_strategy` | `highest` | Primary node election strategy |
