---
technoglogies:      kafka-connect,kafka
version:				1.14.0
validated-at:			27.2.2022
---

# Using a Kafka Connect Connector not in Confluent Hub

This recipe will show how to use a Kafka Connect connector JAR which is not available in [Confluent Hub](https://www.confluent.io/hub). Popular connector not available there are the ones offered as the [Stream Reactor](https://github.com/lensesio/stream-reactor) project.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,KAFKA_CONNECT -s trivadis/platys-modern-data-platform -w 1.13.0
```

start the platform

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Download the Connector

Navigate into the kafka-connect folder

```bash
cd plugins/kafka-connect/connectors
```

and download the a conector JAR from the Landoop Stream-Reactor Project project (here we are using the MQTT connector, but it works in the same way for any other connector)

```bash
wget https://github.com/Landoop/stream-reactor/releases/download/2.1.3/kafka-connect-mqtt-2.1.3-2.5.0-all.tar.gz
```

Once it is successfully downloaded, uncompress it using this tar command and remove the file.

```bash
mkdir kafka-connect-mqtt-2.-2.1.0-all && tar xvf kafka-connect-mqtt-1.2.3-2.1.0-all.tar.gz -C kafka-connect-mqtt-1.2.3-2.1.0-all
rm kafka-connect-mqtt-1.2.3-2.1.0-all.tar.gz
```

Now let's restart Kafka connect in order to pick up the new connector.

```bash
cd ../..
docker-compose restart kafka-connect-1 kafka-connect-2
```

The connector has now been added to the Kafka cluster. You can confirm that by watching the log file of the two containers:

```
docker-compose logs -f kafka-connect-1 kafka-connect-2
```