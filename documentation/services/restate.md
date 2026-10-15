# Restate

Restate is a durable execution engine that makes building resilient distributed applications simple. It provides durable functions, workflows, and event-driven patterns with built-in retries, persistence, and exactly-once semantics — without requiring external workflow orchestrators or message brokers.

## Ports

| External Port | Internal Port | Description        |
|:-------------:|:-------------:|--------------------|
| 28216         | 8080          | Ingress port (service calls) |
| 28217         | 9070          | Admin API          |
| 28218         | 9071          | Metrics            |

## Enable in config.yml

```yaml
RESTATE_enable: true
```

## Accessing Restate

- **Admin API**: <http://dataplatform:28217>
- **Ingress** (for calling registered services): <http://dataplatform:28216>
- **Metrics**: <http://dataplatform:28218/metrics>

## Registering a Service

Once Restate is running, register your service endpoint via the Admin API:

```bash
curl -X POST http://dataplatform:28216/deployments \
  -H 'Content-Type: application/json' \
  -d '{"uri": "http://host.docker.internal:<your-service-port>"}'
```

The `host.docker.internal` alias is pre-configured so Restate can reach services running on the Docker host.
