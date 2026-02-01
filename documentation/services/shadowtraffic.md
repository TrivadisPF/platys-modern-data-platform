# ShadowTraffic

ShadowTraffic is a product that helps you rapidly simulate production traffic to your backend—primarily to Apache Kafka, Postgres, S3, webhooks, and a few others.

**[Website](https://shadowtraffic.io/)** | **[Documentation](https://docs.shadowtraffic.io/)**

## How to enable?

```bash
platys init --enable-services SHADOW_TRAFFIC
platys gen
```

## How to use it?

Place a config into the `./scripts/shadowtraffic` folder. By default 

You can use the following environment variables in the config file:

* `KAFKA_BOOTSTRAP_SERVERS` - for the Kafka bootstrap server
* `KAFKA_CONFLUENT_SCHEMA_REGISTRY_URL` - the URL of the schema registry

you can then use them as shown in be snippet below for the Kafka bootstrap server:

```json
    "connections": {
        "kafka": {
            "kind": "kafka",
            "producerConfigs": {
                "bootstrap.servers": {
                    "_gen": "env",
                    "var": "KAFKA_BOOTSTRAP_SERVERS"
                },
                "key.serializer": "io.shadowtraffic.kafka.serdes.JsonSerializer",
                "value.serializer": "io.shadowtraffic.kafka.serdes.JsonSerializer"
            }
        }
    }
```