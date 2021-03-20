---
technoglogies:      trino,minio,spark,delta-lake
version:				1.11.0
validated-at:			20.3.2021
---

# Trino (formerly PrestoSQL), Spark and Delta Lake (Spark 2.4.7 & Delta Lake 0.6.1)

This recipe will show how to access a [Delta Lake](http://delta.io) table with Trino.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services SPARK,HIVE_METASTORE,MINIO,AWSCLI,TRINO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.11.0
```

add the follwing property to `config.yml`

```
TRINO_edition: 'oss'
```

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

## Configure additional Spark packages

Before we can Spark with Delta Lake, we have to add the dependencies to the delta-core and spark-avro packages.

In the `config.yml` add the `SPARK_jars_packages` property:

```yaml
      #
      # ===== Apache Spark ========
      #
      SPARK_enable: true
      SPARK_jars_packages: 'io.delta:delta-core_2.11:0.6.1,org.apache.spark:spark-avro_2.11:2.4.7'
```

Regenerate and restart the platform

```bash
platys gen

docker-compose up -d
```

## Create Data in MinIO

Let's upload some data into MinIO, the S3 compatible data store running as part of the data platform.

First create the bucket

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

And then load the data (provisioned by the data container enabled with the PROVISIONING_DATA_enable flag)

```
docker exec -ti -w /data-transfer/flight-data/flights-small/ awscli s3cmd put flights_2008_4_1.csv flights_2008_4_2.csv flights_2008_5_1.csv s3://flight-bucket/raw/flights/ && 
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/airports.csv s3://flight-bucket/raw/airports/ && 
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/carriers.csv s3://flight-bucket/raw/carriers/ &&
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/plane-data.csv  s3://flight-bucket/raw/plane-data
```

## Prepare the Delta Lake table using Spark

Now let's create a Delta Lake table from the data loaded above using Spark. 

Open a spark-shell

```bash
docker exec -it spark-master spark-shell  --conf spark.sql.extensions="io.delta.sql.DeltaSparkSessionExtension" --conf spark.sql.catalog.spark_catalog="org.apache.spark.sql.delta.catalog.DeltaCatalog"
```

Define the schema (the data we load is in CSV format)

```scala
import org.apache.spark.sql.types._

val flightsSchema = StructType(Array(
  StructField("year", IntegerType, true),
  StructField("month", IntegerType, true),
  StructField("dayOfMonth", IntegerType, true),
  StructField("dayOfWeek", IntegerType, true),
  StructField("depTime", IntegerType, true),
  StructField("crsDepTime", IntegerType, true),
  StructField("arrTime", IntegerType, true),
  StructField("crsArrTime", IntegerType, true),
  StructField("uniqueCarrier", StringType, true),
  StructField("flightNum", StringType, true),
  StructField("tailNum", StringType, true),
  StructField("actualElapsedTime", IntegerType, true),
  StructField("crsElapsedTime", IntegerType, true),
  StructField("airTime", IntegerType, true),
  StructField("arrDelay", IntegerType, true),
  StructField("depDelay", IntegerType, true),
  StructField("origin", StringType, true),
  StructField("dest", StringType, true),
  StructField("distance", IntegerType, true),
  StructField("taxiIn", IntegerType, true),
  StructField("taxiOut", IntegerType, true),
  StructField("cancelled", StringType, true),
  StructField("cancellationCode", StringType, true),
  StructField("diverted", StringType, true),
  StructField("carrierDelay", StringType, true),
  StructField("weatherDelay", StringType, true),
  StructField("nasDelay", StringType, true),
  StructField("securityDelay", StringType, true),
  StructField("lateAircraftDelay", StringType, true)
  )
)
```

Load the data from MinIO S3 into a Spark DataFrame using the `flightsSchema` defined above

```scala
val flightsDf = spark.read.format("csv").option("delimiter",",").option("header", "false").schema(flightsSchema).load("s3a://flight-bucket/raw/flights/flights_2008_5_1.csv")
```

Write the DataFrame to a delta table in MinIO S3

```scala
flightsDf.write.format("delta").mode("append").partitionBy("year","month").save("s3a://flight-bucket/refined/delta-trino/flights")
```

## Create a Manifest for Trino

To use the delta table from Trino, a [manifest file has to be generated](https://docs.delta.io/latest/presto-integration.html):

```scala
import io.delta.tables._

val deltaTable = DeltaTable.forPath(spark,"s3a://flight-bucket/refined/delta-trino/flights")
deltaTable.generate("symlink_format_manifest")
```

## Create the Hive table in Meta Store

Start the `hive` CLI

```bash
docker exec -ti hive-metastore hive
```

create a database and the table wrapping the delta table created before

```sql
CREATE DATABASE flight_data;
USE flight_data;

DROP TABLE flights_t;
CREATE EXTERNAL TABLE flights_t ( dayOfMonth integer
                             , dayOfWeek integer
                             , depTime integer
                             , crsDepTime integer
                             , arrTime integer
                             , crsArrTime integer
                             , uniqueCarrier string
                             , flightNum string
                             , tailNum string
                             , actualElapsedTime integer
                             , crsElapsedTime integer
                             , airTime integer
                             , arrDelay integer
                             , depDelay integer
                             , origin string
                             , dest string
                             , distance integer) 
PARTITIONED BY (year integer, month integer)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'                       
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.SymlinkTextInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3a://flight-bucket/refined/delta-trino/flights/_symlink_format_manifest/'
TBLPROPERTIES ("parquet.compression"="SNAPPY");
```

As the delta table is partitioned, we need to run `MSCK REPAIR TABLE` to force the metastore (connected to trino) to discover the partitions

```sql
MSCK REPAIR TABLE flights_t;
```

## Query from Trino

Start the Trino CLI

```bash
docker exec -ti trino-cli trino --server trino-1:8080 --catalog minio
```

and switch to the `flight_data` database inside the `minio` catalog.

```sql
use minio.flight_data;
```

Let's show the tables

```sql
show tables;
```

and perform various SELECTs on the `flights_t` table

```sql
SELECT * FROM flights_t;
```

```sql
SELECT count(*) FROM flights_t;
```

```sql
SELECT origin, dest, count(*) 
FROM flights_t
GROUP BY origin, dest;
```






