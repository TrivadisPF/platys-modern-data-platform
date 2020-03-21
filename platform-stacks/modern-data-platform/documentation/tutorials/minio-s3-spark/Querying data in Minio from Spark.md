# Accessing Minio Data from Spark

This tutorial will show how to access Minio with Apache Spark

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      SPARK_enable: true
```

Now generate and start the data platform. 

## Create Data in Minio

```
docker exec -ti awscli s3cmd mb s3://test-bucket
```

```
docker exec -ti awscli s3cmd put /data-transfer/samples/movies.json s3://test-bucket/landing/movies.json
```

## Create a table in Hive

On the docker host, start the Hive CLI 

```
docker exec -ti hive-metastore hive
```

and create a new database `test_db` and in that database a table `movies_t`:

```
create database test_db;
use test_db;


CREATE EXTERNAL TABLE movies_t (movieId integer
									, title string
									, genres string									 )
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3a://test-bucket/landing/';
```


## Access data from Spark

Next let's access the data in Minio using Apache Spark

```
docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem
```

Now on the Presto command prompt, switch to the right database. 

```
val moviesDf = spark.read.json("s3a://test-bucket/landing/movies.json")
```

Let's see that there is one table available:

```
moveiesDf.show();
```

## Access data from Apache Zeppelin


