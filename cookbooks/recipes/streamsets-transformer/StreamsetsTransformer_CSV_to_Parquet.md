# Using StreamSets Transformer to transform CSV to Parquet & Delta Lake

This tutorial will show how to use StreamSets Transformer to read CSV files and transform it to Parquet, removing all the Null years. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      SPARK_TRANSFORMER_enable: true
```

Now generate and start the data platform. 

## Create Data in Minio

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

```
docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_4_1.csv s3://flight-bucket/raw/flights/flights_2018_4_1.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_4_2.csv s3://flight-bucket/raw/flights/flights_2018_4_2.csv


docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/airports.csv s3://flight-bucket/raw/airports/airports.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/carriers.csv s3://flight-bucket/raw/carriers/carriers.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/plane-data.csv s3://flight-bucket/raw/plane-data/plane-data.csv
```

## StreamSets Transformer

Navigate to <http://dataplatform:19630>

Add an **S3** origin
 
 * Amazon S3 Tab:
   * **Security**: `AWS Keys`
   * **Access Key ID**: `V42FCGRVMK24JJ8DHUYG`
   * **Secret Access Key**: `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza`
   * **Bucket**: `s3a://flight-bucket/raw/flights/`
   * **Object Name Pattern**: `flights*.csv`
 * Advanced Tab:
   * **Additional Configuration**:
     * `fs.s3a.endpoint` : `http://minio:9000`
     * `fs.s3a.path.style.access` : `true`
 * Data Format Tab:
   * **DataFormat**: `Delimited`
   * **Includes Header**: `false` (unchecked)

Add a **Field Renamer** processor

```
[
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c0",
		"replacement": "year"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c1",
		"replacement": "month"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c2",
		"replacement": "dayOfMonth"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c3",
		"replacement": "dayOfWeek"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c4",
		"replacement": "depTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c5",
		"replacement": "crsDepTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c6",
		"replacement": "arrTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c7",
		"replacement": "crsArrTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c8",
		"replacement": "uniqueCarrier"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c9",
		"replacement": "flightNum"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c10",
		"replacement": "tailNum"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c11",
		"replacement": "actualElapsedTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c12",
		"replacement": "crsElapsedTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c13",
		"replacement": "airTime"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c14",
		"replacement": "arrDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c15",
		"replacement": "depDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c16",
		"replacement": "origin"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c17",
		"replacement": "dest"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c18",
		"replacement": "distance"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c19",
		"replacement": "taxiIn"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c20",
		"replacement": "taxiOut"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c21",
		"replacement": "cancelled"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c22",
		"replacement": "cancellationCode"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c23",
		"replacement": "diverted"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c24",
		"replacement": "carrierDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c25",
		"replacement": "weatherDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c26",
		"replacement": "nasDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c27",
		"replacement": "securityDelay"
	},
	{
		"renameType": "SIMPLE_REPLACE",
		"caseInsensitive": false,
		"field": "_c28",
		"replacement": "lateAircraftDelay"
	}			
]
```

Add a **Stream Selector** processor

  * **Condition**: `year is not NULL`

Add a **S3** destination

 * Amazon S3 Tab:
   * **Security**: `AWS Keys`
   * **Access Key ID**: `V42FCGRVMK24JJ8DHUYG`
   * **Secret Access Key**: `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza`
   * **Bucket**: `s3a://flight-bucket/refined/flights/`
 * Advanced Tab:
   * **Additional Configuration**:
     * `fs.s3a.endpoint` : `http://minio:9000`
     * `fs.s3a.path.style.access` : `true`
 * Data Format Tab:
   * **DataFormat**: `Parquet`

Add additional **Delta Lake** destination

 * Delta Lake Tab:
   * **Table Directory Path**: `s3a://flight-bucket/refined/delta/flights/`
   * **Write Mode**: `Append data`
   * **Partition Columns**: `year` + `month`
 * Storage Tab:
   * **Storage System**: `Amazon S3` 
   * **Credential Mode**: `AWS Keys` 
   * **Access Key ID**: `V42FCGRVMK24JJ8DHUYG`
   * **Secret Access Key**: `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza`
 * Advanced Tab:
   * **Create Managed Table**: `true` 
   * **Table Name**: `flights` 
   * **Additional Configuration**:
     * `fs.s3a.endpoint` : `http://minio:9000`
     * `fs.s3a.path.style.access` : `true`

## Test with new Files

```
docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_5_1.csv s3://flight-bucket/raw/flights/flights_2018_5_1.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_5_2.csv s3://flight-bucket/raw/flights/flights_2018_5_2.csv

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/flights_2018_5_3.csv s3://flight-bucket/raw/flights/flights_2018_5_3.csv
```


## View Raw Data with Spark

```
docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem --packages io.delta:delta-core_2.11:0.5.0
```


```
val flightsDf = spark.read.format("delta").load("s3a://flight-bucket/refined/delta/flights/")
```

```
flightsDf.printSchema
```

```
flightsDf.show
```


## Airports to Refined

docker exec -ti awscli s3cmd put /data-transfer/samples/flight-data/airports.csv s3://flight-bucket/raw/airports/airports-upd.csv

