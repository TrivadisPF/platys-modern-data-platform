# `modern-data-platform` - What's new?

## What's new in 1.2.0 (preview)

The Modern Analytical Data Platform Stack version 1.2.0 contains the following new services and enhancements:

### New Services

* Streamsets Data Collector Edge
* Streamsets Transformer
* Apache NiFi
* various Jupyter services
* Node RED
* Influx Data Tick Stack (influxdb, chronograf, kapacitor)
* Influx DB 2.0-alpha

### Enhancements

* rename all properties from `XXXX_enabled` to `XXXX_enable` 
* rename all properties from 'XXXX_yyyy_enabled` to 'XXXX_YYYY_enabled` to clearly distinguish between product/service and the properties 
* Rename `connect-n` service to `kafka-connect-n` to be more clear
* Rename `broker-n` service to `kafka-n` to be more clear
* Upgrade to Confluent Platform 5.4.0
* Add [concept of edition](service-design.md) for Kafka and Jupyter services

