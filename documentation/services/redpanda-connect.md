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

## Execution modes

Redpanda Connect can run in one of two modes, controlled by `REDPANDA_CONNECT_mode`:

- **`standard`** (default) — runs a single pipeline from `conf/redpanda-connect/connect.yaml` (mounted at `/connect.yaml`).
- **`streams`** — runs in [streams mode](https://docs.redpanda.com/redpanda-connect/guides/streams_mode/about/), loading one stream per YAML file in `conf/redpanda-connect/streams/` (mounted at `/streams`). Each file becomes a separate stream named after the file.

```yaml
# single pipeline (default)
REDPANDA_CONNECT_enable: true
REDPANDA_CONNECT_mode: standard

# multiple streams
REDPANDA_CONNECT_enable: true
REDPANDA_CONNECT_mode: streams
```

Set `REDPANDA_CONNECT_watch_config_enabled: true` to watch the config file(s) for changes and reload automatically (adds the `--watcher` flag). This works in both `standard` and `streams` mode:

```yaml
REDPANDA_CONNECT_enable: true
REDPANDA_CONNECT_mode: standard
REDPANDA_CONNECT_watch_config_enabled: true
```

## Configuration

In `standard` mode the stream processor is driven by a single config file at `conf/redpanda-connect/connect.yaml`, which is mounted into the container at `/connect.yaml`. In `streams` mode, add one YAML file per stream under `conf/redpanda-connect/streams/`. Edit the relevant file(s) to define your `input`, `pipeline`, and `output`, then re-run `platys gen`.

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
