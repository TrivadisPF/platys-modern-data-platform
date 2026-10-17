# Redpanda Connect

Redpanda Connect (formerly Benthos) is a high-performance, declarative stream processor. It connects a wide range of sources and sinks with built-in mapping, enrichment, and transformation, all configured through a single YAML file.

**[Website](https://www.redpanda.com/connect)** | **[Documentation](https://docs.redpanda.com/redpanda-connect/about/)** | **[GitHub](https://github.com/redpanda-data/connect)**

## Ports

| External Port | Internal Port | Description                   |
|:-------------:|:-------------:|-------------------------------|
| 4195          | 4195          | HTTP health check / metrics   |

## Enable in config.yml

```yaml
REDPANDA_CONNECT_enable: true
```

## Configuration

The stream processor is driven by a single config file at `conf/redpanda-connect/connect.yaml`, which is mounted into the container at `/connect.yaml`. Edit it to define your `input`, `pipeline`, and `output`, then re-run `platys gen`.

When Kafka is enabled in the stack, the broker list is injected into the container via the `KAFKA_BROKERS` environment variable. Reference it in the config like so:

```yaml
input:
  kafka_franz:
    seed_brokers: [ "${KAFKA_BROKERS}" ]
    topics: [ "my-input-topic" ]
    consumer_group: redpanda-connect
```

## Accessing Redpanda Connect

- **Health / metrics**: <http://dataplatform:4195>
