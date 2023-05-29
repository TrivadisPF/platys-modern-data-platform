---
technologies:       spark,iceberg
version:				1.16.0
validated-at:			20.02.2023
---

# Spark with Apache Iceberg

This recipe will show how to use a Spark cluster together with the [Apache Iceberg](https://iceberg.apache.org) table format. We will be using the Python and SQL API.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,ZEPPELIN,MINIO,AWSCLI,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.16.0
```

Before we can generate the platform, we need to extend the `config.yml`:

Specify the table format to use as Iceberg.

```
      SPARK_table_format_type: 'iceberg'
```

Platys automatically makes sure that the right version according to [Using Iceberg in Spark 3](https://iceberg.apache.org/docs/latest/getting-started/#using-iceberg-in-spark-3) is used.

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

## Working with Iceberg from Zeppelin

Navigate to Zeppelin <http://dataplatform:28080> and login as user `admin` with password `abc123!`.

Create a new notebook and add and execute the following commands:

Import necessary modules 

```python
%pyspark
from pyspark.sql.types import DoubleType, FloatType, LongType, StructType,StructField, StringType
```

Load the raw Airport data in the CSV format into a data frame

```python
%pyspark
airportsRawDF = spark.read.csv("s3a://flight-bucket/raw/airports", 
        sep=",", inferSchema="true", header="true")
airportsRawDF.show(5)
```

add 

```python
%pyspark
airportsRawDF.withColumnRenamed('lat','latitude').withColumnRenamed('long','longitude').createOrReplaceTempView("airports_raw")
```

create a new Iceberg table, using the `CREATE TABLE` Spark SQL statement 

```sql
%sql
CREATE TABLE iceberg.db.airports_t (iata string
									, airport string
									, city string
									, state string
									, country string
									, latitude double
									, longitude double)
USING ICEBERG;
```
Use the iceberg table in a SQL statement

```sql
%sql
SELECT * FROM iceberg.db.airports_t;
```

Append the raw data loaded before to the Iceberg table.

```python
%pyspark
airportsRawDF.withColumnRenamed('lat','latitude').withColumnRenamed('long','longitude').writeTo("iceberg.db.airports_t").append()
```

We have to rename the columns to fit with the structure of the table. 

Now select the data again to check the update

```sql
%sql
SELECT * FROM airports_t;
```

We could have achieved the same using the following SQL INSERT statement

```sql
%sql
INSERT INTO iceberg.db.airports_t 
SELECT iata, airport, city, state, country, latitude, longitude FROM airports_raw;
```

Instead of just appending data, we can also use a SQL MERGE to merge data from a source table into the target Iceberg table

```sql
%sql
MERGE INTO iceberg.db.airports_t t USING (SELECT * FROM airports_raw) u ON u.iata = t.iata
WHEN MATCHED THEN
    UPDATE SET t.airport = u.airport, t.city = u.city, t.state = u.state, t.country = u.country, t.latitude = u.latitude, t.longitude = u.longitude
WHEN NOT MATCHED
    THEN INSERT *
```    
