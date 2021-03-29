# Spark with internal S3 (using on minIO)

This recipe will show how to use a Spark cluster in the platform and connect it to the internal MinIO S3 service.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,AWSCLI,ZEPPELIN,MINIO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.9.1
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Upload Raw Input Data to S3 Buckets

Let's upload some data into S3. You can either use the official [AWS S3 console](https://s3.console.aws.amazon.com/s3) or use the `awscli` service of the platform. 

First create a new bucket. Because you are using the public S3 service, you have to use a globally unique name for the bucket. So in order for it to work you have to replace the prefix `gschmutz` by a prefix "unique to you":

```
docker exec -ti awscli s3cmd mb s3://gschmutz-flight-bucket
```

And then load the data (provisioned by the data container enabled with the `PROVISIONING_DATA_enable` flag). Again replace the `gschmutz` prefix before executing it:

```
docker exec -ti awscli s3cmd put /data-transfer/flight-data/airports.csv s3://gschmutz-flight-bucket/raw/airports/airports.csv
```

## Work with data from external S3 with Spark

Navigate to Zeppelin <http://dataplatform:28080> and login as user `admin` with password `abc123!`.

Create a new notebook and in a cell enter the following Spark code using the Python API. Replace again the `gschmutz` prefix in the bucket name:

```python
%pyspark
from pyspark.sql.types import *

airportsRawDF = spark.read.csv("s3a://gschmutz-flight-bucket/raw/airports", 
    	sep=",", inferSchema="true", header="true")
airportsRawDF.show(5)
```

You can do the same using the Spark Scala API, replace again the `gschmutz` prefix in the bucket name:

```scala
val airportsRawDF = spark.read.options(Map("inferSchema"->"true", "delimiter"->",", "header"->"true"))
						.csv("s3a://gschmutz-flight-bucket/raw/airports")
airportsRawDF.show(5)
````