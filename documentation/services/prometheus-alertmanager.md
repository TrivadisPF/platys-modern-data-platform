# Prometheus Alertmanager

Handles alerts sent by client applications such as the Prometheus server. It takes care of deduplicating, grouping, and routing them to the correct receiver integration such as email, PagerDuty, or OpsGenie. It also takes care of silencing and inhibition of alerts.

**[Website](https://prometheus.io/)** | **[Documentation](https://prometheus.io/docs/alerting/latest/alertmanager/)** | **[GitHub](https://github.com/prometheus/alertmanager)**

## How to enable?

```
platys init --enable-services PROMETHEUS,PROMETHEUS_ALERTMANAGER	
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28328>