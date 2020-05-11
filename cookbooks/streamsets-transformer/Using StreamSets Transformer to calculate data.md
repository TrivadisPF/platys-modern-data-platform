# Using StreamSets Transformer to aggregate data

This tutorial will show how to use StreamSets Transformer to aggregate data in raw files in Delta Lake to new files in Delta Lake. 

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      HIVE_METASTORE_enable: true
      MINIO_enable: true
      AWSCLI_enable: true
      SPARK_TRANSFORMER_enable: true
```

Now generate and start the data platform. 

## StreamSets Transformer

Navigate to <http://dataplatform:19630>

Add an **S3** origin
 
 * Amazon S3 Tab:
   * **Security**: `AWS Keys`
   * **Access Key ID**: `V42FCGRVMK24JJ8DHUYG`
   * **Secret Access Key**: `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza`
   * **Bucket**: `s3a://flight-bucket/landing/flights/`
   * **Object Name Pattern**: `flights*.csv`
 * Advanced Tab:
   * **Additional Configuration**:
     * `fs.s3a.endpoint` : `http://minio:9000`
     * `fs.s3a.path.style.access` : `true`
 * Data Format Tab:
   * **DataFormat**: `Delimited`
   * **Includes Header**: `false` (unchecked)


Add a **Stream Selector** processor

  * **Condition**: `year is not NULL`

Add a **S3** destination

 * Amazon S3 Tab:
   * **Security**: `AWS Keys`
   * **Access Key ID**: `V42FCGRVMK24JJ8DHUYG`
   * **Secret Access Key**: `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza`
   * **Bucket**: `s3a://flight-bucket/raw/flights/`
 * Advanced Tab:
   * **Additional Configuration**:
     * `fs.s3a.endpoint` : `http://minio:9000`
     * `fs.s3a.path.style.access` : `true`
 * Data Format Tab:
   * **DataFormat**: `Parquet`


## Test with Spark

```
docker exec -it spark-master spark-shell  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem --packages io.delta:delta-core_2.11:0.5.0
```


	```
val flightsDf = spark.read.format("delta").load("s3a://flight-bucket/usage-optimized/delta/flightCounts/")
```

```
flightsDf.printSchema
```

```
flightsDf.show
```