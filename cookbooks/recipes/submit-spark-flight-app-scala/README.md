# Submit Simple Scala Spark Application

This recipe will show how to submit a simple spark application against the Spark Cluster of the data platform. The application reads data from Minio S3 in CSV and transforms it to Parquet. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,MINIO,AWSCLI,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.8.0
```

Now set an environment variable to the home folder of the dataplatform and generate and start the data platform. 

```
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Upload Raw Input Data to MinIO S3 Buckets

Let's upload some data into MinIO, the S3 compatible data store running as part of the data platform.

First create the flight and app bucket

```
docker exec -ti awscli s3cmd mb s3://flight-bucket
```

And then load the data (provisioned by the data container enabled with the `PROVISIONING_DATA_enable` flag)

```
docker exec -ti -w /data-transfer/flight-data/flights-small/ awscli s3cmd put flights_2008_4_1.csv flights_2008_4_2.csv flights_2008_5_1.csv s3://flight-bucket/raw/flights/ && 
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/airports.csv s3://flight-bucket/raw/airports/ && 
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/carriers.csv s3://flight-bucket/raw/carriers/ &&
  docker exec -ti awscli s3cmd put /data-transfer/flight-data/plane-data.csv  s3://flight-bucket/raw/plane-data
```

## Build the application using Maven

Navigate to the `test-artefacts/spark-simple-app` folder and build the application using Maven:

```
cd ./test-artefacts/spark-simple-app`

mvn package
```

Copy the generated artefact `digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar` in the `target` folder to the `data-transfer/app` folder of the platys dataplatform. 

```
cp ./target/digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar ${DATAPLATFORM_HOME}/data-transfer/app
```

## Upload the Spark application to MinIO S3

Create the `app-bucket`

```
docker exec -ti awscli s3cmd mb s3://app-bucket
```

and upload the Spark Application (jar) from the `data-transfer/app` folder to MinIO `app-bucket`:

```
docker exec -ti -w /data-transfer/app/ awscli s3cmd put digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar s3://app-bucket/spark/ 
```

## Submit the Spark Application

A Spark application can be submitted using the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) script. It is located in the Spark's `bin` directory and available in the `spark-master` container.   

We can either submit using the local file in the `data-transfer/app` folder:

```
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar
```

or using the jar we have uploaded to the MinIO S3 bucket:

```
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 --class com.trivadis.sample.spark.SampleApp --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true s3a://app-bucket/spark/digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar
```






