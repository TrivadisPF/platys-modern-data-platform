# Querying data in Postgresql from Apache Drill

This tutorial will show how to query Postgresql from Apache Drill. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      POSTGRESQL_enable: true
      DRILL_enable: true
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
FROM '/data-transfer/samples/flight-data/airports.csv' DELIMITER ',' CSV HEADER;
```

## Query Table from Drill

Next let's query the data from Drill. Connect to the Drill UI using a browser: <http://dataplatform:8047>

Create a new Storage Plugin, name it `postgresql` and this configuration

```
{
  "type": "jdbc",
  "driver": "org.postgresql.Driver",
  "url": "jdbc:postgresql://postgresql/sample",
  "username": "sample",
  "password": "sample",
  "caseInsensitiveTableNames": false,
  "enabled": true
}
```

```
show databases
```

Now you can select from the table

```
select * from posgresql.flight_data.airport_t
```


```
SELECT country, count(*)
FROM posgresql.flight_data.airport_t
GROUP BY country;
```