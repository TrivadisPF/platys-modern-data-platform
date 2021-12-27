# Grafana Promtail

Promtail is an agent which ships the contents of local logs to a private Grafana Loki instance or Grafana Cloud. It is usually deployed to every machine that has applications needed to be monitored.

**[Website](https://grafana.com/oss/loki/)** | **[Documentation](https://grafana.com/docs/loki/latest/clients/promtail/)** | **[GitHub](https://github.com/grafana/loki#loki-like-prometheus-but-for-logs)**

## How to enable?

```
platys init --enable-services PROMTAIL
platys gen
```

