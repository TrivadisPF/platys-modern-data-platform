---
technologies:       iceberg,spark,minio
version:				1.19.0
validated-at:			13.11.2025
---

# Using Spark, Trino with Iceberg and Polaris Catalog


## Initialize Platys

```yaml
      SPARK_enable: true

      SPARK_table_format_type: iceberg
      
      
      HIVE_METASTORE_enable: true
      
      JUPYTER_enable: true
      JUPYTER_edition: 'all-spark'
      JUPYTER_python_packages: 'pyspark==3.5.3 boto3 lakefs_client lakefs jupyter_contrib_nbextensions tabulate papermill jupysql arrow pyarrow pandas grpcio-status'
      JUPYTER_token: 'abc123!'
      
      POSTGRESQL_enable: true
      POSTGRESQL_database: POLARIS
      
      TRINO_enable: true
      
      MINIO_enable: true
      MINIO_buckets: 'warehouse-bucket,lakefs-demo-bucket'
      
      LAKEFS_enable: true
      
      POLARIS_enable: true
      POLARIS_persistence_type: 'relational-jdbc'
      POLARIS_storage_location: 's3a://warehouse-bucket'
      
      NIMTABLE_enable: true
```

## Polaris

```sql
SHOW CATALOGS;
SHOW SCHEMAS FROM iceberg_polaris;
SHOW TABLES FROM iceberg_polaris.information_schema;
DESCRIBE iceberg_polaris.information_schema.tables;
```

```
CREATE SCHEMA iceberg_polaris.tpch;
CREATE TABLE iceberg_polaris.tpch.test_polaris AS SELECT 1 x;
SELECT * FROM iceberg_polaris.tpch.test_polaris;
```

### Rest API

```
curl -s http://172.20.10.2:28284/api/catalog/v1/oauth/tokens \
   --user admin:abc123! \
   -d 'grant_type=client_credentials' \
   -d 'scope=PRINCIPAL_ROLE:ALL'
```

```bash
export POLARIS_TOKEN=<token>
```

```bash
curl -v http://172.20.10.2:28284/api/management/v1/catalogs/polaris_catalog \
     -H "Authorization: Bearer $POLARIS_TOKEN"
```

## Spark SQL

```bash
docker exec -it spark-master spark-sql
```

### Create a table

```sql
CREATE NAMESPACE IF NOT EXISTS polaris.sparksql;

CREATE EXTERNAL TABLE polaris.sparksql.person (id bigint, first_name string, last_name string) USING iceberg;
```

### Write data to the table

```sql
INSERT INTO polaris.sparksql.person VALUES (1, 'peter', 'muster'), (2, 'scott', 'tiger'), (3, 'amanda', 'jenkins');
```

### Read data from table

```sql
SELECT * FROM polaris.sparksql.person;
```

### Update data in the table

```sql
CREATE EXTERNAL TABLE polaris.sparksql.person_upd (id bigint, first_name string, last_name string) USING iceberg;
INSERT INTO polaris.sparksql.person_upd VALUES (1, 'PETER', 'MUSTER'), (4, 'Liam', 'Keller');

MERGE INTO polaris.sparksql.person t 
USING (SELECT * FROM polaris.sparksql.person_upd) u 
ON t.id = u.id
WHEN MATCHED THEN 
	UPDATE SET *
WHEN NOT MATCHED 
	THEN INSERT *;
```

```sql
SELECT * FROM polaris.sparksql.person;
```

## Pyspark

```bash
docker exec -it spark-master pyspark
```

### Create a table

```python
from pyspark.sql.types import StructType, StructField, LongType, StringType, IntegerType

spark.sql("CREATE DATABASE IF NOT EXISTS polaris.pyspark")

# Define the schema for the person table
schema = StructType([
    StructField("person_id", LongType(), True),
    StructField("first_name", StringType(), True),
    StructField("last_name", StringType(), True),
    StructField("age", IntegerType(), True),
    StructField("city", StringType(), True)
])

# Create an empty DataFrame with that schema
df = spark.createDataFrame([], schema)

# Create the Iceberg table
df.writeTo("polaris.pyspark.person").create()
```

### Write data to the table

```python
schema = spark.table("polaris.pyspark.person").schema
data = [
    (1, "Alice", "Müller", 30, "Berlin"),
    (2, "Bob", "Smith", 28, "Zurich"),
    (3, "Charlie", "Dubois", 35, "Paris"),
    (4, "Diana", "Rossi", 26, "Rome")
]
df = spark.createDataFrame(data, schema)

df.writeTo("polaris.pyspark.person").append()
```

### Read data from table

```python
df = spark.table("polaris.pyspark.person").show()
```

or 

```python
spark.read.format("iceberg").load("polaris.pyspark.person").show()
```

### Update data in the table

```python
schema = spark.table("polaris.pyspark.person").schema

upd_data = [
    (1, "Alice", "Müller", 31, "Berlin"),
    (2, "Bob", "Smith", 29, "Zurich"),
    (5, "Scott", "Tiger", 57, "Redwood")
  ]
upd_df = spark.createDataFrame(upd_data, schema)
upd_df.createOrReplaceTempView("upd_person")

spark.sql("""
	MERGE INTO polaris.pyspark.person AS t
	USING upd_person AS s
	ON t.person_id = s.person_id
	WHEN MATCHED 
		THEN UPDATE SET *
	WHEN NOT MATCHED 
		THEN INSERT *
""")
```

```python
spark.read.format("iceberg").load("polaris.pyspark.person").show()
```

## Trino

use trino to query the data

```bash
docker exec -ti trino-1 trino
```

```sql
select * from iceberg_polaris.sparksql.person;
```

### Time Travel

```sql
select * from iceberg_polaris.sparksql.person for version as of 6051743454399845937;

select * from iceberg_polaris.sparksql.person for timestamp as of timestamp '2025-10-26 21:02:30 Europe/Zurich';
```

## Nimtable

Login with user `admin` and password `admin`.

Click on *+ Create Catalog** and fill out the following fields

* **Catalog Tempalte / Input Format**: `REST + S3`
* **Catalog Name**: `polaris`
* **Catalog Type**: `rest`
* **URI**: `http://polaris:8181/api/catalog`
* **Warehouse**: `polaris_catalog`
* **s3.endpoint**: `http://minio-1:9000`
* **s3.access-key-id**: `admin`
* **s3.secret-access-key**: `abc123abc123!`

Click twice on **+ Add Property** and add

* **scope**: `PRINCIPAL_ROLE:ALL`
* **secret**: `admin:abc123!` 