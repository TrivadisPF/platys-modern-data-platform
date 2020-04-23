# Presto and Delta Lake

This tutorial will show how to access Delta Lake table from with Presto.

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      SPARK_enable: true
      PRESTO_enable: true
```

Now generate and start the data platform. 

## Create Data in Minio

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

```
docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_4_1.csv s3://flight-bucket/raw/flights/flights_2018_4_1.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_4_2.csv s3://flight-bucket/raw/flights/flights_2018_4_2.csv


docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/airports.csv s3://flight-bucket/raw/airports/airports.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/carriers.csv s3://flight-bucket/raw/carriers/carriers.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/plane-data.csv s3://flight-bucket/raw/plane-data/plane-data.csv
```

## Prepare the Delta Lake table

```
docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem --packages io.delta:delta-core_2.11:0.5.0,org.apache.spark:spark-avro_2.11:2.4.5
```

,TaxiIn,TaxiOut,Cancelled,CancellationCode,Diverted,CarrierDelay,WeatherDelay,NASDelay,SecurityDelay,LateAircraftDelay
2007,1,1,1,1232,1225,1341,1340,WN,2891,N351,69,75,54,1,7,SMF,ONT,389,4,11,0,,0,0,0,0,0,0

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

```
val flightsDf = spark.read.format("csv")
  .option("delimiter",",")
  .option("header", "false")
  .schema(flightsSchema)
  .load("s3a://flight-bucket/raw/flights/flights_2018_5_1.csv")
```

```
flightsDf.write.format("delta").mode("append").partitionBy("year","month").save("s3a://flight-bucket/refined/delta-presto/flights")
```

## Create a Manifest

```
import io.delta.tables._

val deltaTable = DeltaTable.forPath(spark,"s3a://flight-bucket/refined/delta-presto/flights")
deltaTable.generate("symlink_format_manifest")
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

SELECT * FROM flights_t;
```


## Query from Presto


```
docker exec -ti presto-1 presto-cli
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






