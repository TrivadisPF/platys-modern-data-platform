---
technoglogies:      kafka,prometheus,grafana
version:				1.17.0
validated-at:			17.12.2023
---

# Monitoring Kafka stack with Prometheus and Grafna

This recipe will show how to monitor a Kafka stack with Prometheus and Grafana.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,AKHQ,JIKKOU,SCHEMA_REGISTRY,KAFKA_CONNECT,KAFKA_LAG_EXPORTER,PROMETHEUS,GRAFANA -s trivadis/platys-modern-data-platform -w 1.17.0
```

Edit the `config.yml` and add the following property below the header section

```bash
      platys:
          platform-name: 'demo-platform'
          platform-stack: 'trivadis/platys-modern-data-platform'
          platform-stack-version: '1.17.0'
          structure: 'flat'
          
     # enable jmx monitoring with prometheus
     jmx_monitoring_with_prometheus_enable: true
```

and add these connectors to kafka connect

```bash
      KAFKA_CONNECT_connectors: 'jcustenborder/kafka-connect-json-schema:0.2.5,cjmatta/kafka-connect-sse:1.0'
```


Now generate and start the platform

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker compose up -d
```

## Create the necessary topic

```bash
docker exec -ti kafka-1 kafka-topics --create --bootstrap-server kafka-1:19092 --topic wikipedia.parsed --partitions 6 --replication-factor 3
```

## Start Wikipedia Connector

```bash
#!/bin/bash

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "wikipedia-sse",
  "config": {
    "connector.class": "com.github.cjmatta.kafka.connect.sse.ServerSentEventsSourceConnector",
    "sse.uri": "https://stream.wikimedia.org/v2/stream/recentchange",
    "topic": "wikipedia.parsed",
    "transforms": "extractData, parseJSON",
    "transforms.extractData.type": "org.apache.kafka.connect.transforms.ExtractField\$Value",
    "transforms.extractData.field": "data",
    "transforms.parseJSON.type": "com.github.jcustenborder.kafka.connect.json.FromJson\$Value",
    "transforms.parseJSON.json.exclude.locations": "#/properties/log_params,#/properties/\$schema,#/\$schema",
    "transforms.parseJSON.json.schema.location": "Url",
    "transforms.parseJSON.json.schema.url": "https://raw.githubusercontent.com/wikimedia/mediawiki-event-schemas/master/jsonschema/mediawiki/recentchange/1.0.0.json",
    "transforms.parseJSON.json.schema.validation.enabled": "false",
    "producer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry-1:8081",
    "tasks.max": "1"
  }
}
EOF
)

docker-compose exec kafka-connect-1 curl -X POST -H "${HEADER}" --data "${DATA}" http://kafka-connect-1:8083/connectors
```

## Start Kafka Stream Application

Create a `docker-compose.override.yml` file and add the following service

```bash
version: "2.3"
services:
  streams-demo:
    image: cnfldemos/cp-demo-kstreams:0.0.11
    restart: always
    hostname: streams-demo
    container_name: streams-demo
    volumes:
      - ./scripts/kafka/jmx-exporter/:/usr/share/jmx-exporter
    environment:
      KAFKA_BOOTSTRAP_SERVERS: kafka-1:19092
      KAFKA_SCHEMA_REGISTRY_URL: http://schema-registry-1:8081
      KAFKA_REPLICATION_FACTOR: 2
      JAVA_OPTS: -javaagent:/usr/share/jmx-exporter/jmx_prometheus_javaagent-0.20.0.jar=1234:/usr/share/jmx-exporter/kafka_streams.yml
```      

start the additional service 

```bash
docker compose up -d
```

### ksqldb

```sql
CREATE STREAM wikipedia WITH (kafka_topic='wikipedia.parsed', value_format='AVRO');
CREATE STREAM wikipedianobot AS SELECT *, (length->new - length->old) AS BYTECHANGE FROM wikipedia WHERE bot = false AND length IS NOT NULL AND length->new IS NOT NULL AND length->old IS NOT NULL;
CREATE STREAM wikipediabot AS SELECT *, (length->new - length->old) AS BYTECHANGE FROM wikipedia WHERE bot = true AND length IS NOT NULL AND length->new IS NOT NULL AND length->old IS NOT NULL;
CREATE TABLE wikipedia_count_gt_1 WITH (key_format='JSON') AS SELECT user, meta->uri AS URI, count(*) AS COUNT FROM wikipedia WINDOW TUMBLING (size 300 second) WHERE meta->domain = 'commons.wikimedia.org' GROUP BY user, meta->uri HAVING count(*) > 1;
```