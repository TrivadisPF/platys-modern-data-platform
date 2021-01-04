# Querying data in Postgresql from Presto

This tutorial will show how to query Minio with Hive and Presto. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      POSTGRESQL_enable: true
      PRESTO_enable: true
      HUE_enable: true
```

Now generate and start the data platform. 

## Create Table in Postgresql

```
docker exec -ti postgresql psql -d sample -U sample
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

## Query Table from Presto

Next let's query the data from Presto. Connect to the Presto CLI using

```
docker exec -it presto-1 presto-cli
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


```
SELECT ao.airport, ao.city, ad.airport, ad.city, f.*
FROM minio.flight_data.flights_t  AS f
LEFT JOIN postgresql.flight_data.airport_t AS ao
ON (f.origin = ao.iata)
LEFT JOIN postgresql.flight_data.airport_t AS ad
ON (f.dest = ad.iata);
```
