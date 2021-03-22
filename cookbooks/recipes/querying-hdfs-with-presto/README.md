---
technoglogies:      trino,hdfs
version:				1.11.0
validated-at:			20.3.2021
---

# Querying HDFS data using Presto

This recipe will show how to upload data to HDFS.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services HADOOP,HIVE_METASTORE,TRINO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.11.0
```

add the follwing property to `config.yml`

```
TRINO_edition: 'oss'
```

Now generate and start the data platform. 

```
platys gen

docker-compose up -d
```

## Uploading to HDFS 

First create a folder

```
docker exec -ti namenode hadoop fs -mkdir -p /user/flight-data/flights &&
	docker exec -ti namenode hadoop fs -mkdir -p /user/flight-data/airports &&
	docker exec -ti namenode hadoop fs -mkdir -p /user/flight-data/carriers &&
	docker exec -ti namenode hadoop fs -mkdir -p /user/flight-data/plane-data
```

```
docker exec -ti namenode hadoop fs -copyFromLocal /data-transfer/flight-data/flights-small/flights_2008_4_1.csv /data-transfer/flight-data/flights-small/flights_2008_4_2.csv /data-transfer/flight-data/flights-small/flights_2008_5_1.csv /user/flight-data/flights &&
  docker exec -ti namenode hadoop fs -copyFromLocal  /data-transfer/flight-data/airports.csv  /user/flight-data/airports &&
  docker exec -ti namenode hadoop fs -copyFromLocal  /data-transfer/flight-data/carriers.csv /user/flight-data/carriers/ &&
  docker exec -ti namenode hadoop fs -copyFromLocal  /data-transfer/flight-data/plane-data.csv  /user/flight-data/plane-data
```
 
```
docker exec -ti namenode hadoop fs -ls -R /user/flight-data/
```

```
docker@ubuntu:~/platys-spark-test$ docker exec -ti namenode hadoop fs -ls -R /user/flight-data/
drwxr-xr-x   - root supergroup          0 2020-09-14 11:06 /user/flight-data/airports
-rw-r--r--   3 root supergroup     244438 2020-09-14 11:06 /user/flight-data/airports/airports.csv
drwxr-xr-x   - root supergroup          0 2020-09-14 11:06 /user/flight-data/carriers
-rw-r--r--   3 root supergroup      43758 2020-09-14 11:06 /user/flight-data/carriers/carriers.csv
drwxr-xr-x   - root supergroup          0 2020-09-14 11:06 /user/flight-data/flights
-rw-r--r--   3 root supergroup     980792 2020-09-14 11:06 /user/flight-data/flights/flights_2008_4_1.csv
-rw-r--r--   3 root supergroup     981534 2020-09-14 11:06 /user/flight-data/flights/flights_2008_4_2.csv
-rw-r--r--   3 root supergroup     998020 2020-09-14 11:06 /user/flight-data/flights/flights_2008_5_1.csv
drwxr-xr-x   - root supergroup          0 2020-09-14 11:06 /user/flight-data/plane-data
-rw-r--r--   3 root supergroup     428558 2020-09-14 11:06 /user/flight-data/plane-data/plane-data.csv
```

## Creating Table in Hive Metastore 

```
docker exec -ti hive-metastore hive
```

Create the database and switch to the database

```
CREATE DATABASE flight_data;
USE flight_data;
```


Create the Hive Table

```
DROP TABLE IF EXISTS flights_t;
CREATE EXTERNAL TABLE flights_t (year integer
									 , month integer
								    , day_of_month integer
								    , day_of_week integer
								    , dep_time integer
								    , crs_dep_time integer
								    , arr_time integer
								    , crs_arr_time integer
								    , unique_carrier string
								    , flight_num string
								    , tail_num string
								    , actual_elapsed_time integer
								    , crs_elapsed_time integer
								    , air_time integer
								    , arr_delay integer
								    , dep_delay integer
								    , origin string
								    , dest string
								    , distance integer
								    , taxi_in integer
								    , taxi_out integer
								    , cancelled string
								    , cancellation_code string
								    , diverted integer
								    , carrier_delay integer
								    , weather_delay integer
								    , nas_deleay integer
								    , security_delay integer
								    , late_aircraft_delay integer) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 'hdfs://namenode:9000/user/flight-data/flights';                             
```

You can perform a simple select without any other clauses (aggregation, where) using the Hive Metastore service:

```
SELECT * FROM flights_t;
```

## Query from Trino


```
docker exec -ti trino-cli trino --server trino-1:8080 --catalog hdfs
```

```
use hdfs.flight_data;

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




