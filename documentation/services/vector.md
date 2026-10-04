# Vector

Vector is a high-performance, end-to-end observability data pipeline that collects, transforms, and routes logs, metrics, and traces to any destination.

**[Website](https://vector.dev/)** | **[Documentation](https://vector.dev/docs/)** | **[GitHub](https://github.com/vectordotdev/vector)**

## How to enable?

```bash
platys init --enable-services VECTOR
platys gen
```

## How to use it?

The Vector API is available at <http://dataplatform:9598>.

The health endpoint used by the Docker healthcheck is at <http://dataplatform:9598/health>.

### Configuration

Edit `conf/vector/vector.yaml` before running `platys gen`. The file is volume-mapped into the container at `/etc/vector/vector.yaml`.

The default configuration enables the Vector API on port `9598` and includes commented-out examples for common sources and sinks.

### Example: tail log files → Loki

```yaml
sources:
  app_logs:
    type: file
    include:
      - /var/log/app/*.log

sinks:
  loki_out:
    type: loki
    inputs: ["app_logs"]
    endpoint: "http://loki:3100"
    labels:
      source: vector
```

### Example: metrics → Mimir (Prometheus remote write)

```yaml
sinks:
  mimir_out:
    type: prometheus_remote_write
    inputs: ["your_metrics_source"]
    endpoint: "http://mimir:9009/api/v1/push"
```

### Persist state across restarts

```yaml
VECTOR_volume_map_data: true
```

This maps `./container-volume/vector` into the container at `/var/lib/vector` for buffering and checkpointing.
