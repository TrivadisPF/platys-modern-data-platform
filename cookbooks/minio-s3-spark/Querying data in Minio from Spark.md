# Accessing Minio Data from Spark

This tutorial will show how to access Minio with Apache Spark

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      SPARK_enable: true
```

Now generate and start the data platform. 

## Create Data in Minio

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

```
docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/airports.json s3://flight-bucket/landing/airports/airports.json

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/plane-data.json s3://flight-bucket/landing/planes/plane-data.json
```


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

## Access data from Spark

Next let's access the data in Minio using Apache Spark

```
docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem
```

Now on in the Spark shell use data frame to read the data

```
val planeDf = spark.read.json("s3a://flight-bucket/landing/plane/plane-data.json")
```

Let's see that there is one table available:

```
planeDf.show();
```

## Delta Lake and Spark

docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem --packages io.delta:delta-core_2.11:0.5.0,org.apache.spark:spark-avro_2.11:2.4.5



```
spark.sessionState.catalog
```



```
docker run --network docker-compose_default \
           --volume /tmp/my_msgs.txt:/data/my_msgs.txt \
           confluentinc/cp-kafkacat \
           kafkacat -b kafka-1:19092 \
                    -t my_msgs \
                    -P -l /data/my_msgs.txt
```



CREATE EXTERNAL TABLE data_t ( sysenv string
                             , store string
                             , day string
                             , hour string
                             , destinationURL string
                             , nof_page_requests integer ) 
STORED BY 'io.delta.hive.DeltaStorageHandler'
LOCATION 's3a://raw-bucket/pagecount/';



drop table data2_t;
CREATE EXTERNAL TABLE data2_t ( sysenv string
                             , store string
                             , day string
                             , hour string
                             , destinationURL string
                             , nof_page_requests string ) 
STORED AS parquet
LOCATION 's3a://raw-bucket/pagecount5/'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

