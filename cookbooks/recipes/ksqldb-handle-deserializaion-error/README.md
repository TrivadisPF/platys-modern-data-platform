---
technoglogies:      ksqldb,kafka
version:				1.16.0
validated-at:			1.10.2022
---

# Handle Serialization Errors in ksqlDB

This recipe will show how to find serialization errors that cause some events from a Kafka topic to not be written into a ksqlDB stream or table.

The example code shown in this cookbook recipe is taken from the Confluent tutorial ["How to handle deserialization errors"](https://developer.confluent.io/tutorials/handling-deserialization-errors/ksql.html).

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,KAFKA_KSQLDB -s trivadis/platys-modern-data-platform -w 1.16.0
```

start the platform

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Create the input topic with a stream

To start off the implementation of this scenario, you need to create a stream that represent sensors. This stream will contain a field called ENABLED to indicate the status of the sensor. While this stream acts upon data stored in a topic called `SENSORS_RAW`, we will create derived stream called `SENSORS` to actually handle the sensors. This stream simply copies the data from the previous stream, ensuring that the ID field is used as the key.

Connect to ksqldb cli

```bash
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```

and create the two streams

```sql
CREATE STREAM SENSORS_RAW (id VARCHAR, timestamp VARCHAR, enabled BOOLEAN)
    WITH (KAFKA_TOPIC = 'SENSORS_RAW',
          VALUE_FORMAT = 'JSON',
          TIMESTAMP = 'TIMESTAMP',
          TIMESTAMP_FORMAT = 'yyyy-MM-dd HH:mm:ss',
          PARTITIONS = 1);

CREATE STREAM SENSORS AS
    SELECT
        ID, TIMESTAMP, ENABLED
    FROM SENSORS_RAW
    PARTITION BY ID;

```

##  Produce events to the input topic 

Before we move forward with the implementation, we need to produce records to the `SENSORS_RAW` topic, that as explained earlier, is the underlying topic behind the `SENSORS` stream. Let’s use the console producer to create some records.

```bash
docker exec -i kafka-1 /usr/bin/kafka-console-producer --bootstrap-server kafka-1:19092 --topic SENSORS_RAW
```

Type in one line at a time and press enter to send it. Each line represents a sensor with the required data. Note that for testing purposes, we are providing two records with data in the right format (notably the first two records) and one record with an error. The record with the error contains the field `ENABLED` specified as string instead of a boolean. 

```json
{"id": "e7f45046-ad13-404c-995e-1eca16742801", "timestamp": "2020-01-15 02:20:30", "enabled": true}
{"id": "835226cf-caf6-4c91-a046-359f1d3a6e2e", "timestamp": "2020-01-15 02:25:30", "enabled": true}
{"id": "1a076a64-4a84-40cb-a2e8-2190f3b37465", "timestamp": "2020-01-15 02:30:30", "enabled": "true"}
```

## Checking for deserialization errors 

Create a new client session for KSQL using the following command:

```bash
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```

We know that we produced three records to the stream but only two of them were actually correct. In order to check if these two records were properly written into the stream, run the pull query (without the `EMIT CHANGES` clause) below

```sql
SELECT
    ID,
    TIMESTAMP,
    ENABLED
FROM SENSORS;
```

and the output should look similar to:

```
+--------------------------------------------------------+--------------------------------------------------------+--------------------------------------------------------+
|ID                                                      |TIMESTAMP                                               |ENABLED                                                 |
+--------------------------------------------------------+--------------------------------------------------------+--------------------------------------------------------+
|e7f45046-ad13-404c-995e-1eca16742801                    |2020-01-15 02:20:30                                     |true                                                    |
|e7f45046-ad13-404c-995e-1eca16742801                    |2020-01-15 02:20:30                                     |true                                                    |
|e7f45046-ad13-404c-995e-1eca16742801                    |2020-01-15 02:20:30                                     |true                                                    |
Query Completed
Query terminated
```

We know that at least one of the records produced had an error, because we specified the field ENABLED as a string instead of a boolean. 

With the [KSQL Processing Log](https://docs.ksqldb.io/en/latest/reference/processing-log) feature enabled, you can query a stream called KSQL_PROCESSING_LOG to check for deserialization errors.

The query below is extracting some of the data available in the processing log. As the ksqldb-server is configured so that the processing log includes the payload of the message, we can also use the encode method to convert the record from `base64` encoded into a human readable `utf8` encoding:

```sql
SELECT
    message->deserializationError->errorMessage,
    message->deserializationError->`topic`,
    encode(message->deserializationError->RECORDB64, 'base64', 'utf8') AS MSG,
    message->deserializationError->cause
  FROM KSQL_PROCESSING_LOG;
```

this query should produce the following output

```
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
|ERRORMESSAGE                             |topic                                    |MSG                                      |CAUSE                                    |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
|Failed to deserialize value from topic: S|SENSORS_RAW                              |{"id": "1a076a64-4a84-40cb-a2e8-2190f3b37|[Can't convert type. sourceType: TextNode|
|ENSORS_RAW. Can't convert type. sourceTyp|                                         |465", "timestamp": "2020-01-15 02:30:30",|, requiredType: BOOLEAN, path: $.ENABLED,|
|e: TextNode, requiredType: BOOLEAN, path:|                                         | "enabled": "true"}                      | Can't convert type. sourceType: TextNode|
| $.ENABLED                               |                                         |                                         |, requiredType: BOOLEAN, path: .ENABLED, |
Query Completed
Query terminated
```



