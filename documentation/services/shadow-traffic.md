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

if `KAFKA_enable is` set to `true` (internal or external)

* `KAFKA_BOOTSTRAP_SERVERS` - for the Kafka bootstrap server

if `SCHEMA_REGISTRY_enable` is set to `true` (internal or external)

* `KAFKA_SCHEMA_REGISTRY_URL` - the URL of the schema registry

if `POSTGRESQL_enable` is set to `true` (internal or external)

* `POSTGRESQL_HOST` - the host of the postgresql db
* `POSTGRESQL_PORT` - the port of the postgresql db
* `POSTGRESQL_DATABASE` - the default database
* `POSTGRESQL_USER` -  the user
* `POSTGRESQL_PASSWORD` - the password

if `MINIO_enable` or external `S3_enable` is set to `true`

* `S3_ENDPOINT` - the endpoint of the S3 service
* `S3_PATH_STYLE_ACCESS` - use path style access style
* `AWS_REGION` - the region, will be automatically used by Shadowtraffic
* `AWS_ACCESS_KEY_ID` - the access key id, will be automatically used by Shadowtraffic
* `AWS_SECRET_ACCESS_KEY`- the secret access key id, will be automatically used by Shadowtraffic

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
        },
        "postgres": {
            "kind": "postgres",
            "tablePolicy": "dropAndCreate",
            "connectionConfigs": {
                "host": {
                    "_gen": "env",
                    "var": "POSTGRESQL_HOST"
                },
                "port": {
                    "_gen": "env",
                    "var": "POSTGRESQL_PORT",
                    "as": "integer"
                },
                "db":{
                    "_gen": "env",
                    "var": "POSTGRESQL_DATABASE"
                },
                "username": {
                    "_gen": "env",
                    "var": "POSTGRESQL_USER"
                },
                "password": {
                    "_gen": "env",
                    "var": "POSTGRESQL_PASSWORD"
                }
            }
        }
        
        
    }
```