# InfluxDB v3 Core

InfluxDB Core is a database built to collect, process, transform, and store event and time series data. It is ideal for use cases that require real-time ingest and fast query response times to build user interfaces, monitoring, and automation solutions.

**[Website](https://www.influxdata.com/)** | **[Documentation](https://docs.influxdata.com/influxdb3/core/)** | **[GitHub](https://github.com/influxdata/influxdb)**

## How to enable?

```
platys init --enable-services INFLUXDB3
platys gen
```

Create admin token

```bash
docker exec -it influxdb3 influxdb3 create token --admin
```

## How to use it?


