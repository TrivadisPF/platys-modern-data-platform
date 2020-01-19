# Platform Stack: `modern-data-platform`

This Platform Stack defines the set of services for a Modern Data Platform, such as

* Kafka
* Spark
* Hadoop Ecosystem
* StreamSets & NiFi
* Zeppelin & Jupyter
* NoSQL

and many others. 

## Which services can I use? 

The following services are provisioned as part of the Modern Data Platform: 

 * Zookeeper
   * Apache Zookeeper
   * Zoonavigator (Mgmt UI)
 * Kafka (Confluent Platform)
   * Kafka Broker 1 -3
   * Confluent Schema Registry 1 - 2
   * Kafka Connect 1-2
   * Confluent Rest Proxy 1 
   * ksqlDB Server 1-2
   * Kafka REST Proxy
   * Confluent MQTT Proxy
   * Schema Registry UI
   * Kafka Connect UI
   * Kafka Manager (Mgmt UI)
   * Kafka Drop (Mgmt UI)
   * Kafka Admin (Mgmt UI)
   * Kafka HQ (Mgmt UI)
   * Burrow (Offset Monitoring)
 * Hadoop / YARN
   * Hadoop Namenode 
   * Hadoop Datanode 1-2
   * YARN Resourcemanager
   * YARN Nodemanager
   * YARN Historyserver
   * Hadoop Client
 * Spark
   * Spark Master
   * Spark Worker 1-3
   * Spark History Server
   * Spark Thrift Server
   * Livy
 * Hive
   * Hive Service
   * Hive Metastore on PostgreSQL
 * Governance
   * Atlas
   * Amundsen
 * Data Engineering Tools
   * Hue
   * Streamsets Data Collector
   * Apache NiFi
 * Data Science Tools 
   * Apache Zeppelin
   * Jupyter (with Spark)
 * Data Visualization
   * Grafana 
 * NoSQL
   * Redis
   * Redis Commander (UI)
   * Cassandra
   * Cassandra Web (UI)
   * MongoDB
   * MongoExpress (UI)
   * Admin Mongo (UI)
   * Solr
   * Elasticsearch
   * Dejavu (Elasticsearch UI)
   * Cerebro (Elasticsearch UI) 
   * ElasticHQ (Elasticsearch UI)
   * Kibana (UI)
   * Neo4J
   * Influx DB Tick Stack (Telegraf, Influxdb 1.x, Chronograf, Kapacitor)
   * Influx DB 2.x
   * Tile38
 * RDBMS
   * MySQL
   * SQLServer
   * PostreSQL
   * TimescaleDB
   * Adminer (UI) 
 * Event Store
   * Axon Server
 * Integration 
   * Mosquitto MQTT Broker
   * HiveMQ MQTT Broker
   * MQTT UI
   * Apache ActiveMQ
   * FTP
   * Filezilla (FTP UI)  

For new services to be added, please either create an [GitHub issue](https://github.com/TrivadisPF/modern-data-analytics-stack/issues/new) or create a Pull Request.

## Changes 
See [What's new?](../documentation/changes.md) for a more detailled list of changes.

