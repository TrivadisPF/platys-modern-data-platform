# Telegraf

Telegraf is a plugin-driven server agent for collecting & reporting metrics, and is the first piece of the TICK stack. Telegraf has plugins to source a variety of metrics directly from the system it’s running on, pull metrics from third party APIs, or even listen for metrics via a statsd and Kafka consumer services. It also has output plugins to send metrics to a variety of other datastores, services, and message queues, including InfluxDB, Graphite, OpenTSDB, Datadog, Librato, Kafka, MQTT, NSQ, and many others.

**[Website](https://www.influxdata.com/time-series-platform/telegraf/)** | **[Documentation](https://docs.influxdata.com/telegraf/latest/)** | **[GitHub](https://github.com/influxdata/telegraf)**

## How to enable?

```
platys init --enable-services INFLUXDB, INFLUXDB_TELEGRAF
platys gen
```
