---
technoglogies:      trino,postgresql
version:				1.11.0
validated-at:			20.3.2021
---

# Querying data in Postgresql from Trino (formerly PrestoSQL)

This tutorial will show how to query Postgresql table from Trino. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled 

```
platys init --enable-services TRINO,POSTGRESQL,ADMINER,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.11.0
```

add the follwing property to `config.yml`

```
TRINO_edition: 'oss'
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Create Table in Postgresql

```
docker exec -ti postgresql psql -d demodb -U demo
```

```
CREATE SCHEMA flight_data;

DROP TABLE flight_data.airport_t;

CREATE TABLE flight_data.airport_t
(
  iata character varying(50) NOT NULL,
  airport character varying(50),
  city character varying(50),
  state character varying(50),
  country character varying(50),
  lat float,
  long float,
  CONSTRAINT airport_pk PRIMARY KEY (iata)
);
```

```
COPY flight_data.airport_t(iata,airport,city,state,country,lat,long) 
FROM '/data-transfer/flight-data/airports.csv' DELIMITER ',' CSV HEADER;
```

```
SELECT * FROM flight_data.airport_t LIMIT 20;
```

## Query Table from Trino

Next let's query the data from Trino. Connect to the Trino CLI using

```
docker exec -it trino-cli trino --server trino-1:8080
```

Now on the Presto command prompt, switch to the right database. 

```
use postgresql.flight_data;
```

Let's see that there is one table available:

```
show tables;
```

We can see the `airport_t` table we created in the Hive Metastore before

```
presto:default> show tables;
     Table
---------------
 airport_t
(1 row)
```

```
SELECT * FROM airport_t;
```

```
SELECT country, count(*)
FROM airport_t
GROUP BY country;
```
