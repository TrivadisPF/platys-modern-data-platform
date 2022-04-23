---
technoglogies:    	spark, hive-metastore
version:			1.15.0
validated-at:		22.04.2022
---


# Spark and Hive Metastore

This recipe will show how to use Hive Metastore with Spark.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,HIVE_METASTORE,MINIO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.15.0
```

Add the following properties to the generated `config.yml` file:

```
	  SPARK_catalog: hive

    SPARK_base_version: 3.2
```

Now generate and start the data platform.

```
platys gen

docker-compose up -d
```

## Create a table in Hive Metastore

Connect to Hive Metastore Service and create a table:

```
docker exec -ti hive-metastore hive
```

on the command line, create the following table

```
CREATE TABLE demo_sales
(id BIGINT, qty BIGINT, name STRING)
COMMENT 'Demo: Connecting Spark SQL to Hive Metastore'
PARTITIONED BY (rx_mth_cd STRING COMMENT 'Prescription Date YYYYMM aggregated')
STORED AS PARQUET;
```

## Connect to Spark Shell to view the table

Connect to the `spark-shell` CLI

```
docker exec -ti spark-master spark-shell
```

Check that the catalog is set to `hive`

```
spark.conf.get("spark.sql.catalogImplementation")
```

List the tables currently in the catalog

```
spark.catalog.listTables.show
```

and you should get the following output

```
scala> spark.catalog.listTables.show
+----------+--------+--------------------+---------+-----------+
|      name|database|         description|tableType|isTemporary|
+----------+--------+--------------------+---------+-----------+
|demo_sales| default|Demo: Connecting ...|  MANAGED|      false|
+----------+--------+--------------------+---------+-----------+
```


## Connect to Spark SQL to view the table

Connect to the `spark-sql` CLI

```
docker exec -ti spark-master spark-sql
```

Show the tables currently in the catalog

```
show tables;
```

and you should get the following output

```
spark-sql> show tables;
20/09/14 09:10:07 INFO codegen.CodeGenerator: Code generated in 271.351739 ms
default	demo_sales	false
Time taken: 2.763 seconds, Fetched 1 row(s)
```
