# Spark with external S3

This recipe will show how to use a Spark cluster in the platform and connect it to an external S3 service, [AWS S3](https://aws.amazon.com/s3/) in this example, but it could also be for example an S3 appliance. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services SPARK,AWSCLI,ZEPPELIN,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.9.0
```

Before we can generated the platform, we need to extend the `config.yml` with the following section, right after the `private_docker_repository_name` property:

```
      private_docker_repository_name: 'trivadis'
      
      # ========================================================================
      # External Services
      # ========================================================================

      external:
        KAFKA_enable: false 
        KAFKA_bootstrap_servers: 
        KAFKA_username:
        KAFKA_password:

        SCHEMA_REGISTRY_enable: false
        SCHEMA_REGISTRY_url:

        S3_enable: true
        S3_endpoint: 
        S3_default_region: eu-central-1        
        S3_path_style_access: false
```

Set the `S3_enable` property to `true` and the `S3_default_region` property to your preferred location, leave the other settings as is.

Before we can start the platform, we have to specify the AWS credentials for S3 with the two environment variables `PLATYS_AWS_ACCESS_KEY` and `PLATYS_AWS_SECRET_ACCESS_KEY`. The simples way is to create an `.env` file with this content:

```
PLATYS_AWS_ACCESS_KEY=<put your access key here>
PLATYS_AWS_SECRET_ACCESS_KEY=<put your access secret here
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
docker exec -ti awscli aws s3 mb s3://gschmutz-flight-bucket
```

And then load the data (provisioned by the data container enabled with the `PROVISIONING_DATA_enable` flag). Again replace the `gschmutz` prefix before executing it:

```
docker exec -ti awscli aws s3 cp /data-transfer/flight-data/airports.csv s3://gschmutz-flight-bucket/raw/airports/airports.csv
```

## Work with data from external S3 with Spark

Navigate to Zeppelin <http://dataplatform:28080> and login as user `admin` with password `changeme`.

Create a new notebook and in a cell enter the following Spark code using the Python API. Replace again the `gschmutz` prefix in the bucket name:

```python
%pyspark
from pyspark.sql.types import *

airportsRawDF = spark.read.csv("s3a://gschmutz-flight-bucket/raw/airports", 
    	sep=",", inferSchema="true", header="true")
airportsRawDF.show(5)
```


