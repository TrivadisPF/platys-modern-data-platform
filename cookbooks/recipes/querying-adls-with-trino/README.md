---
technoglogies:      trino,minio,adls,azure
version:				1.15.0
validated-at:			14.7.2022
---

# Querying data in Azure Data Lake Storage Gen2 from Trino (formerly PrestoSQL)

This tutorial will show how to query Azure Data Lake Storage Gen2 (ADLS) with Hive and Trino. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled 

```
platys init --enable-services TRINO,HIVE_METASTORE,AZURECLI,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.15.0
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

## Create Data in Azure Data Lake Storage




first login using

```bash
docker exec -ti azurecli az login
```

Navigate to the website as requested and enter the code provided by the login command and authenticate yourself to Azure. 

Now create the container

```
docker exec -ti azurecli az storage fs create -n flight-data --account-name gusstorage --auth-mode login
```

create some folders

```bash
docker exec -ti azurecli az storage fs directory create -n /landing/airports/ -f flight-data --account-name gusstorage 

docker exec -ti azurecli az storage fs directory create -n /landing/plane/ -f flight-data --account-name gusstorage 
```

and upload some data

```bash
docker exec -ti azurecli az storage fs file upload -s "data-transfer/flight-data/airports.json" -p /landing/airports/airports.json -f flight-data --account-name gusstorage

docker exec -ti azurecli az storage fs file upload -s "data-transfer/flight-data/plane-data.json" -p /landing/plane/plane-data.json -f flight-data --account-name gusstorage
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
LOCATION 'abfs://flight-data@gusstorage.dfs.core.windows.net/landing/plane';
```


## Query Table from Trino

Next let's query the data from Trino. Connect to the Trino CLI using

```
docker exec -it trino-cli trino --server trino-1:8080
```

Now on the Trino command prompt, switch to the right database. 

```
use adls.flight_db;
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