# Testing Modern Data Analytics Stack on Docker

This document describes an end-to-end test of the Modern Data Analytics Stack running on multiple docker containers. 

## Register Avro Schema against Confluent Schema Registry

Navigate to the 

```
cd test-case/metadata/avro
```

```
mvn schema-registry:register
```

```
curl http://192.168.1.10:8089/subjects
```

<http://analyticsplatform:28002/#/>

## Creating a Kafka Topic

Next let's create the Kafka topics for the transaction data. 

Connect to one of the Kafka brokers

```
docker exec -ti broker-1 bash
```

and execute the `kafka-topics` command.

```
kafka-topics --create --zookeeper zookeeper-1:2181 --topic transaction-v1 --replication-factor 3 --partitions 8
```

## Ingesting Data using StreamSets Data Collector

In a browser navigate to: <http://analyticsplatform:18630>

Import the following two dataflows:

* `/streamsets/DevGen_to_Kafka.json` - generates some transaction messages and produces them into the Kafka topic `transaction-v1` 
* `/streamsets/Kafka_to_HDFS.json` - consumes messages from the topic `transaction-v1` and writes them into HDFS into the folder `/user/hive/demo/person`

First start the DevGen_to_Kafka pipeline and check that messages arrive in the `transaction-v1` topic. Next also start the Kafka_to_HDFS pipeline.

Check that after a while data is arriving in HDFS.

```
docker exec -ti namenode hadoop fs -ls /user/hive/demo/person
```

## Creating a table in Hive

First we have to make the Avro Schema available to Hive. 

Navigate to the folder and 

```
cd metadata/avro/src/main/avro
```

Upload the Avro Schema to HDFS

```
docker cp Transaction-v1.avsc namenode:.
docker exec -ti namenode hadoop fs -copyFromLocal Transaction-v1.avsc /user/hive/demo
```

```
docker exec -ti namenode hadoop fs -ls /user/hive/demo
```

Now connect to Hive 

```
docker exec -ti hive-server hive
```

and create the table

```
CREATE DATABASE demo;
USE demo;

DROP TABLE person;

CREATE EXTERNAL TABLE person 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION "/user/hive/demo/person"
TBLPROPERTIES ('avro.schema.url'='hdfs://namenode:8020/user/hive/demo/Transaction-v1.avsc');
```

```
SELECT count(*) FROM person;
```

```
SELECT * FROM person
LIMIT 10;
```

## Using spark-sql cli to Read from the table "person"

Connect to the spark master

```
docker exec -ti spark-master bash
```

start the spark-sql

```
/spark/bin/spark-sql
```

and select from `person`

```
SELECT COUNT(*) FROM demo.person;
```

```
SELECT * FROM demo.person 
LIMIT 10;
```

You should get back the same result as above, proving that Spark connects to the Hive Metastore.

## Using spark-shell to Read from the table "person"

Connect to the spark master

```
docker exec -ti spark-master bash
```

start the spark-shell

```
/spark/bin/spark-shell
```

```
spark.sql("SELECT * FROM demo.person").show(10)
```
You should get back the same result as above, proving that Spark connects to the Hive Metastore.

## Using Apache Zeppelin to Read from the table "person"

In a browser window, navigate to <http://analyticsplatform:38081>

Create a new notebook and execute the following statement

```
spark.sql("SELECT * FROM demo.person").show(10)
```

You should get back the same result as above, proving that Spark in Zeppelin connects to the Hive Metastore.

We can also use spark-avro to read the data directly from the file, without going through Hive. 

First add the dependency on spark-avro to the Spark Interpreter (this is no longer be necessary when using Spark 2.4).

```
com.databricks:spark-avro_2.11:4.0.0 
```

Now execute the following snippet to load the data into a data frame

```
import com.databricks.spark.avro._

val df = spark.read.avro("hdfs://namenode:8020/user/hive/demo/person")
```

now with the dataframe we can ask to print the schema

```
df.printSchema
```

and again show the data

```
df.count
```


