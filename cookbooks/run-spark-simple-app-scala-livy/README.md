# Run Scala Spark Application using Apache Livy

This recipe will show how to submit a Scala Spark application against the Spark Cluster of the data platform using the `spark-submit` script.

* Platform services needed: `SPARK,MINIO,AWSCLI,LIVY`
* `DATAPLATFORM_HOME` environment variable needs to be set to the folder where the dataplatform resides (the `docker-compose.yml`)

## Preparing the Scala Spark Application

The Spark application we are going to use is available in this [GitHub project](https://github.com/TrivadisPF/spark-simple-app). 

You can 

1. download the pre-built JAR from GitHub or
2. build it on your own using `maven` or `sbt`

### 1) Download pre-build application

Download the pre-build JAR into the `data-transfer/app` folder of the platys dataplatform. 

```bash
wget https://github.com/TrivadisPF/spark-simple-app/releases/download/spark-2.4.7/spark-scala-sample-1.0-SNAPSHOT.jar -O $DATAPLATFORM_HOME/data-transfer/app/spark-scala-sample-1.0-SNAPSHOT.jar
```

### 2) Build the Spark application

Clone the project with the application from GitHub:

```bash
git clone https://github.com/TrivadisPF/spark-simple-app.git
```

Build the Spark Scala application using Maven:

```bash
cd spark-simple-app/scala/spark-scala-app
mvn package
```

Copy the generated artefact `spark-java-sample-1.0-SNAPSHOT.jar` in the `target` folder into the `data-transfer/app` folder of the platys dataplatform. 

```bash
cp target/spark-scala-sample-1.0-SNAPSHOT.jar $DATAPLATFORM_HOME/data-transfer/app
```

## Upload the Spark application to MinIO S3

Create the `app-bucket`

```bash
docker exec -ti awscli s3cmd mb s3://app-bucket
```

and upload the Spark Application (jar) from the `data-transfer/app` folder to MinIO `app-bucket`:

```bash
docker exec -ti -w /data-transfer/app/ awscli s3cmd put spark-scala-sample-1.0-SNAPSHOT.jar s3://app-bucket/spark/ 
```

## Submit the Spark Application through Apache Livy

A Spark application can be submitted using [Apache Livy](https://livy.apache.org/) service. It is part of the dataplatform.  

```
export LIVY_HOST=${PUBLIC_IP}:8998

curl -v -H 'Content-Type: application/json' -X POST -d '{ "file":"s3a://app-bucket/spark/spark-scala-sample-1.0-SNAPSHOT.jar", "className":"com.trivadis.sample.spark.SimpleApp", "args":[], "conf": {"spark.jars.packages": "", "spark.hadoop.fs.s3a.endpoint": "http://minio:9000", "spark.hadoop.fs.s3a.access.key":"V42FCGRVMK24JJ8DHUYG", "spark.hadoop.fs.s3a.secret.key":"bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza", "spark.hadoop.fs.s3a.path.style.access":"true", "spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem" } }' "http://$LIVY_HOST/batches"
```

Navigate to the Livy UI on <http://dataplatform:8998/ui#> to view the status of the batch session. 

## Monitor the status of the running Spark Application 

