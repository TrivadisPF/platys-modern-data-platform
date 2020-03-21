# Querying data in Minio (S3) from Hive and Presto

This tutorial will show how to query Minio with Hive and Presto. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      PRESTO_enable: true
      HUE_enable: true
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


## Query Table from Presto

Next let's query the data from Presto. Connect to the Presto CLI using

```
docker exec -it presto presto-cli
```

Now on the Presto command prompt, switch to the right database. 

```
use minio.test_db;
```

Let's see that there is one table available:

```
show tables;
```

We can see the `movies_t` table we created in the Hive Metastore before

```
presto:default> show tables;
     Table
---------------
 truck_mileage
(1 row)
```

```
SELECT * FROM movies_t;
```