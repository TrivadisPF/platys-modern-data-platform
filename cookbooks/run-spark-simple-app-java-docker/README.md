# Run Java Spark Application using Docker

This recipe will show how you can build a Docker image with your Java Spark Application, which submits the application against the Spark Cluster of the dataplatform when running the container. 

* Platform services needed: `SPARK`

## Building the Container with the Spark Application

The Spark application we are going to use is available in this [GitHub project](https://github.com/TrivadisPF/spark-simple-app). It already contains the following Dockerfile for creating the container:

```docker
FROM trivadis/spark-java-template:2.4.7-hadoop2.8

MAINTAINER XXX YYY <xxx.yyy@gmail.com>

ENV SPARK_APPLICATION_JAR_NAME spark-java-sample-1.0-SNAPSHOT.jar
ENV SPARK_APPLICATION_MAIN_CLASS com.trivadis.sample.spark.SimpleApp
ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
```

Clone the project from GitHub:

```bash
git clone https://github.com/TrivadisPF/spark-simple-app.git
```

Build the docker image using the following command (replace `<repository>` by your own):

```bash
docker build -t <repository>/spark-simple-app-java .
```

when finished, you should see the following output:

```
Successfully built d6c75bb0796b
Successfully tagged <repository>/spark-simple-app-java:latest
```

## Run the Spark Application

You can now run the docker image using the following command (replace the `<network-name>` with the name of the network the dataplatform is running with. You can list the networks currently in use with `docker network list`. The network usually uses the name of the folder where the `docker-compose.yml` resides):

```
docker run -ti -e ENABLE_INIT_DAEMON=false -e CORE_CONF_fs_defaultFS=file:///tmp --network <network-name> trivadis/spark-simple-app-java
```