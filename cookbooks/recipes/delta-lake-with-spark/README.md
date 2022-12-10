---
technoglogies:      spark,delta-lake
version:				1.16.0
validated-at:			10.12.2022
---

# Spark with Delta Lake

This recipe will show how to use a Spark cluster together with the [Delta Lake](http://delta.io) storage framework. We will be using the Python and SQL API.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,ZEPPELIN,MINIO,AWSCLI,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.16.0
```

Before we can generate the platform, we need to extend the `config.yml`:

First let's specify the Spark Base version to use

```
      SPARK_base_version: 3.1
```

now add the delta jar to `SPARK_jars_packages`

```
      SPARK_jars_packages: 'io.delta:delta-core_2.12:1.0.1'
```

Make sure that you use the right version according to [the compatibility table in the Delta Lake documentation](https://docs.delta.io/latest/releases.html). We are using `1.0.1` because of using Spark `3.1.x`.

Now let's add the two configuration settings for Delta Lake:

```
      SPARK_sql_extensions: 'io.delta.sql.DeltaSparkSessionExtension'
      SPARK_sql_catalog_spark_catalog: 'org.apache.spark.sql.delta.catalog.DeltaCatalog'
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform.

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Prepare some data in Object storage

Create the flight bucket:

```bash
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

Now upload the airports to the bucket

```bash
docker exec -ti awscli s3cmd put /data-transfer/flight-data/airports.csv s3://flight-bucket/raw/airports/airports.csv
```


## Working with Delta Lake from Zeppelin

Navigate to Zeppelin <http://dataplatform:28080> and login as user `admin` with password `abc123!`.

Create a new notebook and add and execute the following commands:

Import necessary modules 

```python
%pyspark
from delta.tables import *
from pyspark.sql.types import *
```

Load the raw Airport data in the CSV format into a data frame

```python
%pyspark
airportsRawDF = spark.read.csv("s3a://flight-bucket/raw/airports", 
        sep=",", inferSchema="true", header="true")
airportsRawDF.show(5)
```

create a new delta table

```python
%pyspark
deltaTableDest = "s3a://flight-bucket/delta/airports"
airportsRawDF.write.format("delta").save(deltaTableDest)
```

Use the `CREATE TABLE` to register the delta table in SQL 

```sql
%sql
CREATE TABLE airports_t
USING DELTA
LOCATION 's3a://flight-bucket/delta/airports'
```

Use the delta table in a SQL statement

```sql
%sql
SELECT * FROM airports_t;
```

