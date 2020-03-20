# `modern-data-platform` - What's new?

## What's new in 1.3.0

The Modern Analytical Data Platform Stack version 1.3.0 contains the following new services and enhancements:

### New Services

* Apache Airflow
* Apache Sqoop (previously part of `hadoop-client` service)
* Code-Server (VS Code IDE in Browser) 

### Enhancements / Changes

* Hadoop images changed to the ones from Big Data Europe
* Service Kafka Manger is now CMAK (due to the name change at Yahoo GitHub)
* KafkaHQ has been renamed to AKHQ by the developer and we now use this image

## What's new in 1.2.0

The Modern Analytical Data Platform Stack version 1.2.0 contains the following new services and enhancements:

### New Services

* Confluent Enterprise as an Edition for Kafka
* Streamsets Data Collector Edge
* Streamsets Transformer
* Apache NiFi
* various Jupyter services
* Node RED
* Influx Data Tick Stack (influxdb, chronograf, kapacitor)
* Influx DB 2.0-alpha

### Enhancements / Changes

* refactor some ports back to original ports
* rename all properties from `XXXX_enabled` to `XXXX_enable` 
* rename all properties from 'XXXX_yyyy_enabled` to 'XXXX_YYYY_enabled` to clearly distinguish between product/service and the properties 
* Rename `connect-n` service to `kafka-connect-n` to be more clear
* Rename `broker-n` service to `kafka-n` to be more clear
* Upgrade to Confluent Platform 5.4.0
* Add [concept of edition](service-design.md) for Kafka and Jupyter services

