## Configuration

The list of variables that can be configured for the service generator can be found in the [`generator-config/vars/default-values.yml`](./generator-config/vars/default-values.yml)


Config        |  Default | Since |  Description
------------- | ---------| ------|-----------
**_Apache Zookeeper_** |  |  |
`ZOOKEEPER_enabled`   | `false` | 1.0.0 | [Apache Zookeeper](https://zookeeper.apache.org/) is a coordination service used by Apache Kafka and Apache Atlas services. It is automatically enabled if using either of the two.
`ZOOKEEPER_nodes`   | `1` | 1.0.0 |number of Zookeeper nodes
`ZOOKEEPER_navigator_enabled`   | `false` | 1.1.0 | Zookeeper Navigator is a UI for managing and viewing zookeeper cluster. 
**_Apache Kafka Broker_** |  | | 
`KAFKA_enabled`   | `false` | 1.0.0 | Use Kafka 
`KAFKA_volume_map_data`   | `false` | 1.0.0 | Volume map data folder into the Kafka broker
`KAFKA_nodes`   | `3` | 1.0.0 | number of Kafka Broker nodes to use
`KAFKA_delete_topic_enable`   | `false` | 1.0.0 | allow deletion of Kafka topics
`KAFKA_auto_create_topics_enable`  | `false` | 1.0.0 | allow automatic creation of Kafka topics
**_Confluent Schema Registry_** |  | | 
`KAFKA_schema_registry_enabled`  | `false` | 1.0.0 | Generate Confluent Schema Registry service
`KAFKA_schema_registry_nodes`  | `false` | 1.0.0 | number of Confluent Schema Registry nodes
`KAFKA_schema_registry_use_zookeeper_election`  | `false` | 1.0.0 | use Zookeeper for election of "master" Schema Registry node
`KAFKA_schema_registry_replication_factor`  | `1` | 1.0.0 | replication factor to use for the `_schemas` topic
**_Apache Kafka Connect_** |  | | 
`KAFKA_connect_enabled`  | `false` | 1.0.0 | Generate Kafka Connect service
`KAFKA_connect_nodes`   | `2` | 1.0.0 | number of Kafka Connect nodes
**_ksqlDB_** |  | | 
`KAFKA_ksqldb_enabled`  | `false` | 1.0.0 | Generate ksqlDB service
`KAFKA_ksqldb_nodes`   | `2` | 1.0.0 | number of ksqlDB nodes
**_Confluent REST and MQTT Proxy_** |  | 
`KAFKA_restproxy_enabled`  | `false` | 1.0.0 | Generate Confluent REST Proxy service
`KAFKA_mqttproxy_enabled`  | `false` | 1.0.0 | Generate Confluent MQTT Proxy service
**_Kafka UIs_** |  | | 
`KAFKA_schema_registry_ui_enabled`  | `false` | 1.0.0 | Generate Landoop Schema-Registry UI service
`KAFKA_connect_ui_enabled`  | `false` | 1.0.0 | Generate Landoop Connect UI service
`KAFKA_manager_enabled`  | `false` | 1.0.0 | Generate Kafka Manger service
`KAFKA_kafdrop_enabled`  | `false` | 1.0.0 | [Kafdrop](https://github.com/obsidiandynamics/kafdrop) is a Kafka UI service, which can be used to administer and managed a Kafka cluster. 
`KAFKA_kadmin_enabled`  | `false` | 1.0.0 | Generate KAdmin service
`KAFKA_kafkahq_enabled`  | `false` | 1.0.0 | Generate KafkaHQ service
`KAFKA_burrow_enabled`  | `false` | 1.0.0 | Generate Burrow service
**_Apache Hadoop_** |  | | 
`HADOOP_enabled`  | `false` | 1.0.0 | Generate Hadoop services
`HADOOP_datanodes`  | `2	` | 1.0.0 | number of Hadoop Datanodes
**_Apache Spark_** |  |  |
`SPARK_enabled`  | `false` | 1.0.0 | Generate Spark services
`SPARK_workers`  | `2` | 1.0.0 | number of Spark Worker nodes
`SPARK_history_enabled`  | `false` | 1.0.0 | Generate Spark History Server
`SPARK_thrift_enabled`  | `false` | 1.0.0 | Generate Spark Thrift Server
`SPARK_livy_enabled`  | `false` | 1.0.0 | Generate Spark Livy Server
**_Apache Hive_** |  |  |
`HIVE_enabled`  | `false` | 1.0.0 | Generate Hive service
**_Apache Atlas & Amundsen_** |  |  |
`ATLAS_enabled`  | `false` | 1.0.0 | Generate Atlas service
`AMUNDSEN_enabled`  | `falsee` | 1.0.0 | Generate Amundsen service
**_Apache Hue_** |  |  |
`HUE_enabled`  | `false` | 1.0.0 | Generate Hue UI service
**_StreamSets DataCollector_** |  | 
`STREAMSETS_enabled`  | `false` | 1.0.0 | Generate StreamSets service
`STREAMSETS_EDGE_enabled`  | `false` | 1.0.0 | Generate StreamSets Edge service
**_Apache NiFi_** |  |  |
`NIFI_enabled`  | `false` | 1.1.0 | Generate Apache NiFi service
**_Apache Zeppelin_** |  | 
`ZEPPELIN_enabled`  | `false` | 1.0.0 | Generate Apache Zeppelin service
**_Jupyter_** |  |  |
`JUPYTER_minimal_enabled`  | `false` | 1.1.0 | Generate Jupyter Minimal Notebook service
`JUPYTER_r_enabled`  | `false` | 1.1.0 | Generate Jupyter R Notebook service
`JUPYTER_scipy_enabled`  | `false` | 1.1.0 | Generate Jupyter Scipy Notebook service
`JUPYTER_tensorflow_enabled`  | `false` | 1.1.0 | Generate Jupyter Tensorflow Notebook service
`JUPYTER_datascience_enabled`  | `false` | 1.1.0 | Generate Jupyter Datascience Notebook service
`JUPYTER_all_spark_enabled`  | `false` | 1.1.0 | Generate Jupyter All Spark Notebook service
`JUPYTER_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Jupyter service
**_Grafana_** |  |  |
`GRAFANA_enabled`  | `false` | 1.0.0 | Generate Grafana service
**_Redis_** |  |  |
`REDIS_enabled`  | `false` | 1.0.0 | Generate Redis service
**_Apache Cassandra_** |  | 
`CASSANDRA_enabled`  | `false` | 1.0.0 | Generate Elasticsearch service
**_MongoDB_** |  |  |
`MONGODB_enabled`  | `false` | 1.0.0 | Generate MongoDB service
**_Apache Solr_** |  |  |
`SOLR_enabled`  | `false` | 1.0.0 | Generate Solr service
**_Elasticsearch & Kibana_** |  | 
`ELASTICSEARCH_enabled`  | `false` | 1.0.0 | Generate Elasticsearch service
`KIBANA_enabled`  | `false` | 1.0.0 | Generate Kibana service
**_Neo4J_** |  |  |
`NEO4J_enabled`  | `false` | 1.0.0 | Generate Neo4J service
**_Tile38_** |  |  |
`TILE38_enabled`  | `false` | 1.0.0 | Generate Tile38 service
**_RDBMS_** |  |  |
`MYSQL_enabled`  | `false` | 1.0.0 | Generate MySQL service
`SQLSERVER_enabled`  | `false` | 1.0.0 | Generate SQL Server service
`POSTGRESQL_enabled`  | `false` | 1.0.0 | Generate PostgreSQL service
`ADMINER_enabled`  | `false` | 1.0.0 | Generate Adminer RDBMS Admin UI service
**_Event Store_** |  |  |
`AXON_enabled`  | `false` | 1.0.0 | Generate Axon Server service
**_MQTT_** |  |  |
`MQTT_enabled`  | `false` | 1.0.0 | Generate MQTT service, either using Mosquitto or HiveMQ
`MOSQUITTO_enabled`  | `false` | 1.0.0 | Generate Mosquitto service
`MOSQUITTO_nodes `  | `1` | 1.1.0 | number of Mosquitto nodes
`MOSQUITTO_volume_map_data `  | `false` | 1.1.0 | Volume map data folder into the Mosquitto broker
`HIVEMQ_enabled`  | `false` | 1.0.0 | Generate HiveMQ service
`MQTT_UI_enabled`  | `false` | 1.0.0 | Generate MQTT UI service
**_ActiveMQ_** |  |  |
`ACTIVEMQ_enabled`  | `false` | 1.0.0 | Generate ActiveMQ service
**_FTP_** |  |  |
`FTP_enabled`  | `false` | 1.0.0 | Generate FTP service
**_Object Storage_** |  |  |
`MINIO_enabled`  | `false` | 1.0.0 | Generate Minio service
`AWSCLI_enabled`  | `false` | 1.0.0 | Generate AWSCli service
**_Container_** |  |  |
`PORTAINER_enabled`  | `false` | 1.0.0 | Generate Portainer Container UI service


