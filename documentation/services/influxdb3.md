# InfluxDB v3 Core

InfluxDB is an open source time series database. It has everything you need from a time series platform in a single binary – a multi-tenanted time series database, UI and dashboarding tools, background processing and monitoring agent. All this makes deployment and setup a breeze and easier to secure. 

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


