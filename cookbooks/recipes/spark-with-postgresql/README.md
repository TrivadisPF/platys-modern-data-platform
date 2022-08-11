---
technoglogies:      spark,postgresql
version:				1.15.0
validated-at:			23.4.2022
---

# Spark with PostgreSQL

This recipe will show how to use a Spark cluster in the platform and connect it to a PostgreSQL relational database.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,POSTGRESQL,ZEPPELIN,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.15.0
```

Before we can generate the platform, we need to extend the `config.yml`. There are two options

**1. use the `SPARK_jars_packages` property to specify a maven coordinate**

add the following property to `config.yml`

```
    SPARK_jars_packages: 'org.postgresql:postgresql:42.3.4'
```

**2. use the `SPARK_jars` property to point to jar provided in `./plugins/spark/jars`**

download the Jar file from the maven repository to `./plugins/spark/jars`

```bash
cd $DATAPLATFORM_HOME
cd ./plugins/spark/jars
wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.3.4/postgresql-42.3.4.jar -O postgresql-42.3.4.jar
```

now add the following property to `config.yml`

```
    SPARK_jars: '/extra-jars/postgresql:42.3.4.jar'
```


Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform.

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Create Table in Postgresql

```bash
docker exec -ti postgresql psql -d demodb -U demo
```

```sql
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

```sql
COPY flight_data.airport_t(iata,airport,city,state,country,lat,long)
FROM '/data-transfer/flight-data/airports.csv' DELIMITER ',' CSV HEADER;
```

## Work with data from PostgreSQL

Navigate to Zeppelin <http://dataplatform:28080> and login as user `admin` with password `abc123!`.

Create a new notebook and in a cell enter the following Spark code using the Python API. Replace again the `gschmutz` prefix in the bucket name:

```scala
val opts = Map(
  "url" -> "jdbc:postgresql://postgresql/demodb?user=demo&password=abc123!",
  "driver" -> "org.postgresql.Driver",
  "dbtable" -> "flight_data.airport_t")
val df = spark
  .read
  .format("jdbc")
  .options(opts)
  .load
```

```
df.show
```
