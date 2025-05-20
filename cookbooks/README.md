# Modern Data Platform Cookbooks  - v1.18.1
Inhere we are documenting cookbooks on how to use the platform:

 * **Airflow**
   * [Schedule and Run Simple Python Application with Airflow](./recipes/airflow-schedule-python-app/README.md) - `1.16.0`

 * **Ofelia**
   * [Schedule and execute commands in Docker containers using Ofelia](./recipes/scheduling-commands-on-docker-containers-with-ofelia/README.md) - `1.18.0` 

 * **Trino (Formerly Presto SQL)**
   * [Trino, Spark and Delta Lake (Spark 2.4.7 & Delta Lake 0.6.1)](./recipes/delta-lake-and-trino-spark2.4/README.md) - `1.11.0`
   * [Trino, Spark and Delta Lake (Spark 3.0.1 & Delta Lake 0.7.0)](./recipes/delta-lake-and-trino-spark3.0/README.md) - `1.11.0`
   * [Querying S3 data (MinIO) using MinIO](./recipes/querying-minio-with-trino/README.md) - `1.11.0`
   * [Querying Azure Data Lake Storage Gen2 data (ADLS) from Trino](./recipes/querying-adls-with-trino/README.md) - `1.15.0`
   * [Querying data in Postgresql from Trino](./recipes/querying-postgresql-with-trino/README.md) - `1.11.0`
   * [Querying data in Kafka from Trino (formerly PrestoSQL)](./recipes/querying-kafka-with-trino/README.md) - `1.14.0`
   * [Querying HDFS data using Trino](./recipes/querying-hdfs-with-presto/README.md) - `1.11.0`
   * [Trino Security](./recipes/trino-security/README.md) - `1.16.0`

 * **MinIO**
   * [Serving a static Web application from MinIO](./recipes/serving-static-html-app-from-minio/README.md)

 * **LakeFS**
   * [Git for Data with LakeFS](./recipes/git-for-data-with-lakefs/README.md)

 * **MQTT**
   * [Using Confluent MQTT Proxy](./recipes/using-mqtt-proxy/README.md)
   * [Using HiveMQ with Kafka Extensions](./recipes/using-hivemq-with-kafka-extension/README.md) - `1.12.0`

 * **Spark**
   * [Run Java Spark Application using `spark-submit`](./recipes/run-spark-simple-app-java-submit/README.md)
   * [Run Java Spark Application using Docker](./recipes/run-spark-simple-app-java-docker/README.md)
   * [Run Scala Spark Application using `spark-submit`](./recipes/run-spark-simple-app-scala-submit/README.md)
   * [Run Scala Spark Application using Docker](./recipes/run-spark-simple-app-scala-docker/README.md)
   * [Run Python Spark Application using `spark-submit`](./recipes/run-spark-simple-app-python-submit/README.md)
   * [Run Python Spark Application using Docker](./recipes/run-spark-simple-app-python-docker/README.md)   
   * [Spark and Hive Metastore](./recipes/spark-and-hive-metastore/README.md) - `1.15.0`
   * [Spark with internal S3 (using on minIO)](./recipes/spark-with-internal-s3/README.md)
   * [Spark with external S3](./recipes/spark-with-external-s3/README.md)
   * [Spark with PostgreSQL](./recipes/spark-with-postgresql/README.md) - `1.15.0`

 * **Delta Lake Table Format**
   * [Spark with Delta Lake](./recipes/delta-lake-with-spark/README.md) - `1.16.0`

 * **Iceberg Table Format**
   * [Spark with Iceberg](./recipes/iceberg-with-spark/README.md) - `1.16.0`

 * **Hadoop HDFS**
   * [Querying HDFS data using Presto](./recipes/querying-hdfs-with-presto/README.md)
   * [Using HDFS data with Spark Data Frame](./recipes/using-hdfs-with-spark/README.md)

 * **Livy**
   * [Submit Spark Application over Livy](./recipes/run-spark-simple-app-scala-livy/README.md)

 * **Apache NiFi**
   * [NiFi ExecuteScript Processor with Python](./recipes/nifi-execute-processor-with-python/README.md) - `1.16.0`
   * [NiFi Registry with Git Flow Persistence Provider](./recipes/nifi-registry-with-git/README.md) - `1.16.0`

 * **StreamSets Data Collector**
   * [Consume a binary file and send it as Kafka message](./recipes/streamsets-binary-file-to-kafka/README.md)
   * [Using Dev Simulator Origin to simulate streaming data](./recipes/using-dev-simulator-origin/README.md) - `1.12.0`
   * [Loading StreamSets Pipeline(s) upon start of container](./recipes/streamsets-loading-pipelines/README.md) - `1.14.0`

 * **StreamSets DataOps Platform**
   * [Creating a self-managed StreamSets DataOps Environment using Platys](./recipes/streamsets-dataops-creating-environment/README.md) - `1.14.0`

 * **StreamSets Transformer**
   * [Using StreamSets Transformer to transform CSV to Parquet & Delta Lake](./recipes/streamsets-transformer-transform-csv-to-deltalake/README.md) - `1.16.0`    

 * **Kafka**
   * [Simulated Multi-DC Setup on one machine](./recipes/simulated-multi-dc-setup/README.md) - `1.14.0`  
   * [Automate management of Kafka topics using Jikkou](./recipes/jikkou-automate-kafka-topics-management/README.md) - `1.17.0`
   * [Azure Event Hub as external Kafka](./recipes/azure-event-hub-as-external-kafka/README.md) - `1.16.0`
   * [SASL/SCRAM Authentication with Zookeeper](./recipes/kafka-sasl-scram-authentication-zk/README.md) - `1.17.0`
   * [SASL/SCRAM Authentication with KRaft](./recipes/kafka-sasl-scram-authentication-kraft/README.md) - `1.17.0`
   * [SASL/PLAIN Authentication](./recipes/kafka-sasl-plain-authentication/README.md) - `1.17.0`

 * **Confluent Enterprise Platform**
   * [Using Confluent Enterprise Tiered Storage](./recipes/confluent-tiered-storage/README.md) - `1.13.0`

 * **ksqlDB**
   * [Connecting through ksqlDB CLI](./recipes/connecting-through-ksqldb-cli/README.md)    
   * [Custom UDF and ksqlDB](./recipes/custom-udf-and-ksqldb/README.md)    
   * [Handle Serialization Errors in ksqlDB](./recipes/ksqldb-handle-deserializaion-error/README.md)    

 * **Kafka Connect**
   * [Using additional Kafka Connect Connector](./recipes/using-additional-kafka-connect-connector/README.md)
   * [Using a Kafka Connect Connector not in Confluent Hub](./recipes/using-kafka-connector-not-in-confluent-hub/README.md) - `1.14.0`

 * **Apicurio Registry**
   * [Apicurio Registry with SQL Storage (PostgreSQL)](./recipes/apicurio-with-database-storage/README.md) - `1.14.0`

 * **Oracle RDBMS**
   * [Using private (Trivadis) Oracle EE image](./recipes/using-private-oracle-ee-image/README.md) - `1.13.0`    
   * [Using public Oracle XE image](./recipes/using-public-oracle-xe-image/README.md) - `1.16.0`    

 * **Neo4J**
   * [Working with Neo4J](./recipes/working-with-neo4j/README.md) - `1.15.0`  
   * [Neo4J and yFiles graphs for Jupyter](./recipes/neo4j-jupyter-yfiles/README.md) - `1.16.0`   

 * **Tipboard**
   * [ Working with Tipboard and Kafka](./recipes/tipboard-and-kafka/README.md) - `1.14.0`    

 * **Architecture Decision Records (ADR)**
   * [Creating and visualizing ADRs with log4brains](./recipes/creating-adr-with-log4brains/README.md) - `1.12.0`    

 * **Jupyter**
   * [Using Jupyter notebook with Spark and Avro](./recipes/jupyter-spark/README.md) - `1.16.0` 
   * [Using JupyterHub](./recipes/using-jupyter-hub/README.md) - `1.16.0` 

 * **Dataverse**
   * [Dataverse with Minio (S3) storage](./recipes/dataverse-with-minio/README.md) - `1.17.0` 

 * **MLflow**
   * [Using MLflow from Jupyter](./recipes/using-mflow-from-jupyter/README.md) - `1.16.0` 

 * **Docker Logging**
   * [Collecting Docker Logs with Loki](./recipes/collecting-docker-logs-with-loki/README.md) - `1.17.0` 

