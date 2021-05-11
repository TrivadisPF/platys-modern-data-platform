# Modern Data Platform Cookbooks

Inhere we are documenting cookbooks on how to use the platform:

 * **Airflow**
   * Schedule and Run Simple Scala Spark Application

 * **Trino (Formerly Presto SQL)**
   * [Trino, Spark and Delta Lake (Spark 2.4.7 & Delta Lake 0.6.1)](./recipes/delta-lake-and-trino-spark2.4/) - `1.11.0`
   * [Trino, Spark and Delta Lake (Spark 3.0.1 & Delta Lake 0.7.0)](./recipes/delta-lake-and-trino-spark3.0/) - `1.11.0`
   * [Querying S3 data (MinIO) using MinIO](./recipes/querying-minio-with-trino/) - `1.11.0`
   * [Querying PostgreSQL data (MinIO) using MinIO](./recipes/querying-postgresql-with-trino/) - `1.11.0`
   * [Querying Kafka data using Trino](./recipes/querying-kafka-with-trino/) - `1.11.0` 
   * [Querying HDFS data using Trino](./recipes/querying-hdfs-with-presto/) - `1.11.0`
   * Joining data between RDBMS and MinIO

 * **MQTT**
   * [Using Confluent MQTT Proxy](./recipes/using-mqtt-proxy/)

 * **Spark**
   * [Run Java Spark Application using `spark-submit`](./recipes/run-spark-simple-app-java-submit)
   * [Run Java Spark Application using Docker](./recipes/run-spark-simple-app-java-docker)
   * [Run Scala Spark Application using `spark-submit`](./recipes/run-spark-simple-app-scala-submit)
   * [Run Scala Spark Application using Docker](./recipes/run-spark-simple-app-scala-docker)
   * [Run Python Spark Application using `spark-submit`](./recipes/run-spark-simple-app-python-submit)
   * [Run Python Spark Application using Docker](./recipes/run-spark-simple-app-python-docker)   
   * [Spark and Hive Metastore](./recipes/spark-and-hive-metastore/)
   * [Spark with internal S3 (using on minIO)](./recipes/spark-with-internal-s3)
   * [Spark with external S3](./recipes/spark-with-external-s3)
   * [Spark with PostgreSQL](./recipes/spark-with-postgresql) - `1.11.0`

 * **Hadoop HDFS**
   * [Querying HDFS data using Presto](./recipes/querying-hdfs-with-presto/)
   * [Using HDFS data with Spark Data Frame](./recipes/using-hdfs-with-spark/)
 
 * **Livy**
   * [Submit Spark Application over Livy](./recipes/run-spark-simple-app-scala-livy)

 * **StreamSets Data Collector**
   * [Consume a binary file and send it as Kafka message](./recipes/streamsets-binary-file-to-kafka) 
   * [Using Dev Simulator Origin to simulate streaming data](./recipes/using-dev-simulator-origin) - `1.12.0` 

 * **ksqlDB**
   * [Connecting through ksqlDB CLI](./recipes/connecting-through-ksqldb-cli)    
   * [Custom UDF and ksqlDB](./recipes/custom-udf-and-ksqldb)    

 * **Kafka Connect**
   * [Using additional Kafka Connect Connector](./recipes/using-additional-kafka-connect-connector)    

 * **Oracle RDMBS**
   * [Using public Oracle XE image](./recipes/using-public-oracle-xe-image) - `1.12.0`    
    

 * **Architecture Decision Records (ADR)**
   * [Creating and visualizing ADRs with log4brains](./recipes/creating-adr-with-log4brains) - `1.12.0`    
