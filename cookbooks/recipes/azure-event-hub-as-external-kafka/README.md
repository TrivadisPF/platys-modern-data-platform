---
technologies:       azure,event-hub,kafka
version:				1.17.0
validated-at:			16.10.2023
---

# Azure Event Hub as external Kafka

This recipe will show how to use Azure Event Hub as an external Kafka cluster. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
export DATAPLATFORM_HOME=${PWD}
platys init --enable-services KAFKA_CONNECT,AKHQ -s trivadis/platys-modern-data-platform -w 1.17.0
```

Edit the `config.yml` 

bash
```
      external:
        KAFKA_enable: true
        KAFKA_bootstrap_servers: XXXXXX.servicebus.windows.net:9093
        KAFKA_security_protocol: SASL_SSL
        KAFKA_sasl_mechanism: PLAIN
        KAFKA_sasl_username: $$ConnectionString
        KAFKA_login_module: org.apache.kafka.common.security.plain.PlainLoginModule
```

For the password to not end up in the `docker-compose.yml` file, we have to add it as an environment variable:

Create a `.env` file 

```
nano .env
```

and add the following environment variable to specify the password 

```bash
PLATYS_KAFKA_PASSWORD=Endpoint=sb://xxxxxxx.servicebus.windows.net/;SharedAccessKeyName=XXXXXXXXXXX;SharedAccessKey=XXXXXXXXXXXXXXXX
```

Save the file and generate and start the data platform.

```bash
platys gen
docker-compose up -d
```

## Use the Platform

Navigate to AKHQ to manage the Event Hub: <http://dataplatform:28107>

To use the Kafka CLI's

```bash
docker exec -ti kafka-cli kafka-topics --bootstrap-server XXXXXX.servicebus.windows.net:9093 --command-config config.properties --list
```

