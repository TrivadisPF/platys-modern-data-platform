---
technoglogies:      trino,minio
version:				1.11.0
validated-at:			20.3.2021
---

# Querying data in Minio (S3) from Trino (formerly PrestoSQL)

This tutorial will show how to query Minio with Hive and Trino. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled 

```
platys init --enable-services TRINO,HIVE_METASTORE,MINIO,AWSCLI,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.11.0
```

add the following property to `config.yml`

```
TRINO_edition: 'oss'
```

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

## Create Data in Minio

create the bucket

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

and upload some data

```
docker exec -ti awscli s3cmd put /data-transfer/flight-data/airports.json s3://flight-bucket/landing/airports/airports.json

docker exec -ti awscli s3cmd put /data-transfer/flight-data/plane-data.json s3://flight-bucket/landing/plane/plane-data.json
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