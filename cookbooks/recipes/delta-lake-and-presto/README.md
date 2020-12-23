# Presto, Spark and Delta Lake (Spark 2.4.6 & Delta Lake 0.6.0)

This recipe will show how to access a [Delta Lake](http://delta.io) table with Presto.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,HIVE_METASTORE,MINIO,AWSCLI,PRESTO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.8.0
```

Now generate and start the data platform. 

```
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

```
docker exec -it spark-master spark-shell  --conf spark.sql.extensions="io.delta.sql.DeltaSparkSessionExtension" --conf spark.sql.catalog.spark_catalog="org.apache.spark.sql.delta.catalog.DeltaCatalog" --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem --packages io.delta:delta-core_2.11:0.6.0,org.apache.spark:spark-avro_2.11:2.4.6
```

Define the schema (the data we load is in CSV format)

```
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

```
val flightsDf = spark.read.format("csv")
  .option("delimiter",",")
  .option("header", "false")
  .schema(flightsSchema)
  .load("s3a://flight-bucket/raw/flights/flights_2008_5_1.csv")
```

Write the DataFrame to a delta table in MinIO S3

```
flightsDf.write.format("delta").mode("append").partitionBy("year","month").save("s3a://flight-bucket/refined/delta-presto/flights")
```

## Create a Manifest for Presto

To use the delta table from Presto, a [manifest file has to be generated](https://docs.delta.io/latest/presto-integration.html):

```
import io.delta.tables._

val deltaTable = DeltaTable.forPath(spark,"s3a://flight-bucket/refined/delta-presto/flights")
deltaTable.generate("symlink_format_manifest")
```

alternatively, since Delta Lake 0.7.0 this can also be done using the `GENERATE` SparkSQL command

```
spark.sql("GENERATE symlink_format_manifest FOR TABLE delta.`s3a://flight-bucket/refined/delta-presto/flights`")
```

## Create the Hive table in Meta Store

```
docker exec -ti hive-metastore hive
```

```
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
LOCATION 's3a://flight-bucket/refined/delta-presto/flights/_symlink_format_manifest/'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

MSCK REPAIR TABLE flights_t;
```


## Query from Presto


```
docker exec -ti presto-cli presto --server presto-1:8080 --catalog minio
```


```
use minio.flight_data;

show tables;
```

```
SELECT * FROM flights_t;
```

```
SELECT count(*) FROM flights_t;
```

```
SELECT origin, dest, count(*) 
FROM flights_t
GROUP BY origin, dest;
```






