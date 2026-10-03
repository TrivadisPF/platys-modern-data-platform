# Grafana Mimir

Grafana Mimir is an open-source, horizontally scalable, highly available, multi-tenant, long-term storage for Prometheus metrics.

**[Website](https://grafana.com/oss/mimir/)** | **[Documentation](https://grafana.com/docs/mimir/latest/)** | **[GitHub](https://github.com/grafana/mimir)**

## How to enable?

```bash
platys init --enable-services MIMIR
platys gen
```

## How to use it?

Navigate to <http://dataplatform:9104>

The Mimir API is available at <http://dataplatform:9104>.

### Send metrics from Prometheus

Add a `remote_write` block to your Prometheus configuration (`conf/prometheus/prometheus-config/prometheus.yml`) to ship metrics to Mimir:

```yaml
remote_write:
  - url: http://mimir:9009/api/v1/push
```

### Query metrics via Grafana

Add Mimir as a Prometheus-compatible data source in Grafana using the URL:

```
http://mimir:9009/prometheus
```

### Configuration

The default configuration (`conf/mimir/mimir.yaml`) runs Mimir in monolithic mode (`--target=all`) with a filesystem backend — suitable for local development and testing. For production use, switch to an object-storage backend (S3/MinIO) and run components separately.

To use a different deployment target, set `MIMIR_target` in `config.yml`:

```yaml
MIMIR_target: 'all'   # monolithic — all components in one process
```

### Persist data across restarts

```yaml
MIMIR_volume_map_data: true
```

This maps `./container-volume/mimir` into the container at `/data`.
