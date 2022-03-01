# OpenTelemetry Collector

The OpenTelemetry Collector offers a vendor-agnostic implementation on how to receive, process and export telemetry data. In addition, it removes the need to run, operate and maintain multiple agents/collectors in order to support open-source telemetry data formats (e.g. Jaeger, Prometheus, etc.) sending to multiple open-source or commercial back-ends.

**[Website](https://opentelemetry.io/)** | **[Documentation](https://opentelemetry.io/docs/collector/)** | **[GitHub](https://github.com/open-telemetry/opentelemetry-collector)**

## How to enable?

```
platys init --enable-services OTEL_COLLECTOR
platys gen
```

## How to use it?

OLTP receiver is listening on Port `4317` and recives data via gRPC or HTTP using [OTLP](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/protocol/otlp.md) format.

```
"-javaagent:/tmp/opentelemetry-javaagent.jar -Dotel.exporter.otlp.endpoint=otel-collector:4317"    
```

