---
technoglogies:      mqtt,hivemq,kafka
version:				1.12.0
validated-at:			22.5.2021
---

# Using HiveMQ with Kafka Extensions

This tutorial will show how to use HiveMQ together with the Kafka extension.

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled 

```
platys init --enable-services KAFKA,HIVEMQ4 -s trivadis/platys-modern-data-platform -w 1.12.0
```

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

## Configure Hive Extension

`kafka-configuration.xml`

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<kafka-configuration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                     xsi:noNamespaceSchemaLocation="kafka-extension.xsd">

    <kafka-clusters>
        <kafka-cluster>
            <id>cluster01</id>
            <bootstrap-servers>kafka-1:19092</bootstrap-servers>
        </kafka-cluster>

    </kafka-clusters>

    <mqtt-to-kafka-mappings>
        <mqtt-to-kafka-mapping>
            <id>mapping01</id>
            <cluster-id>cluster01</cluster-id>
            <mqtt-topic-filters>
                <mqtt-topic-filter>test</mqtt-topic-filter>
            </mqtt-topic-filters>
            <kafka-topic>kafka-topic</kafka-topic>
        </mqtt-to-kafka-mapping>
    </mqtt-to-kafka-mappings>

    <kafka-to-mqtt-mappings>
        <kafka-to-mqtt-mapping>
            <id>mapping02</id>
            <cluster-id>cluster01</cluster-id>
            <kafka-topics>
                <kafka-topic>test</kafka-topic>
                <kafka-topic-pattern>test-(.)*</kafka-topic-pattern>
            </kafka-topics>
        </kafka-to-mqtt-mapping>
    </kafka-to-mqtt-mappings>

</kafka-configuration>
```



------


## Create a table in Hive

On the docker host, start the Hive CLI 

```
docker exec -ti hive-metastore hive
```

and create a new database `flight_db` and in that database a table `plane_t`:

```
create database flight_db;
use flight_db;

CREATE EXTERNAL TABLE plane_t (tailnum string
									, type string
									, manufacturer string									, issue_date string
									, model string
									, status string
									, aircraft_type string
									, engine_type string
									, year string									 )
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3a://flight-bucket/landing/plane';
```


## Query Table from Trino

Next let's query the data from Trino. Connect to the Trino CLI using

```
docker exec -it trino-cli trino --server trino-1:8080
```

Now on the Trino command prompt, switch to the right database. 

```
use minio.flight_db;
```

Let's see that there is one table available:

```
show tables;
```

We can see the `plane_t` table we created in the Hive Metastore before

```
presto:default> show tables;
     Table
---------------
 plane_t
(1 row)
```

```
SELECT * FROM plane_t;
```

```
SELECT year, count(*)
FROM plane_t
GROUP BY year;
```