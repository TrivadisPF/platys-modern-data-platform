## Configuration v1.1.0

This is the documentation of the configuration settings which can be overwritten using a custom YAML file. All the defaults are defined in [`generator-config/vars/default-values.yml`](./generator-config/vars/default-values.yml).

There are configuration settings for enabling/disabling a given service. They are named `XXXXX_enable` where XXXXX is the name of the service (he used to be named `XXXXX_enabled` in version 1.0.0).
For each service there might be some other settings, such as controlling the number of nodes to start the service with, whether the service should map a data volume into the container or controlling some other proprietary configuration properties of the service itself.


Config        |  Default | Since |  Description
------------- | ---------| ------|-----------
**_Apache Zookeeper_** |  |  |
`ZOOKEEPER_enable`   | `false` | 1.0.0 | [Apache Zookeeper](https://zookeeper.apache.org/) is a coordination service used by Apache Kafka and Apache Atlas services. It is automatically enabled if using either of the two.
`ZOOKEEPER_nodes`   | `1` | 1.0.0 |number of Zookeeper nodes
`ZOOKEEPER_navigator_enable`   | `false` | 1.1.0 | Zookeeper Navigator is a UI for managing and viewing zookeeper cluster. 
**_Apache Kafka Broker_** |  | | 
`KAFKA_enable`   | `false` | 1.0.0 | Use Kafka 
`KAFKA_volume_map_data`   | `false` | 1.0.0 | Volume map data folder into the Kafka broker
`KAFKA_nodes`   | `3` | 1.0.0 | number of Kafka Broker nodes to use
`KAFKA_delete_topic_enable`   | `false` | 1.0.0 | allow deletion of Kafka topics
`KAFKA_auto_create_topics_enable`  | `false` | 1.0.0 | allow automatic creation of Kafka topics
**_Confluent Schema Registry_** |  | | 
`KAFKA_schema_registry_enable`  | `false` | 1.0.0 | Generate Confluent Schema Registry service
`KAFKA_schema_registry_nodes`  | `false` | 1.0.0 | number of Confluent Schema Registry nodes
`KAFKA_schema_registry_use_zookeeper_election`  | `false` | 1.0.0 | use Zookeeper for election of "master" Schema Registry node
`KAFKA_schema_registry_replication_factor`  | `1` | 1.0.0 | replication factor to use for the `_schemas` topic
**_Apache Kafka Connect_** |  | | 
`KAFKA_connect_enable`  | `false` | 1.0.0 | Generate Kafka Connect service
`KAFKA_connect_nodes`   | `2` | 1.0.0 | number of Kafka Connect nodes
**_ksqlDB_** |  | | 
`KAFKA_ksqldb_enable`  | `false` | 1.0.0 | Generate ksqlDB service
`KAFKA_ksqldb_nodes`   | `2` | 1.0.0 | number of ksqlDB nodes
**_Confluent REST and MQTT Proxy_** |  | 
`KAFKA_restproxy_enable`  | `false` | 1.0.0 | Generate Confluent REST Proxy service
`KAFKA_mqttproxy_enable`  | `false` | 1.0.0 | Generate Confluent MQTT Proxy service
**_Kafka UIs_** |  | | 
`KAFKA_schema_registry_ui_enable`  | `false` | 1.0.0 | Generate Landoop Schema-Registry UI service
`KAFKA_connect_ui_enable`  | `false` | 1.0.0 | Generate Landoop Connect UI service
`KAFKA_manager_enable`  | `false` | 1.0.0 | Generate Kafka Manger service
`KAFKA_kafdrop_enable`  | `false` | 1.0.0 | [Kafdrop](https://github.com/obsidiandynamics/kafdrop) is a Kafka UI service, which can be used to administer and managed a Kafka cluster. 
`KAFKA_kadmin_enable`  | `false` | 1.0.0 | Generate KAdmin service
`KAFKA_kafkahq_enable`  | `false` | 1.0.0 | Generate KafkaHQ service
`KAFKA_burrow_enable`  | `false` | 1.0.0 | Generate Burrow service
**_Apache Hadoop_** |  | | 
`HADOOP_enable`  | `false` | 1.0.0 | Generate Hadoop services
`HADOOP_datanodes`  | `2	` | 1.0.0 | number of Hadoop Datanodes
**_Apache Spark_** |  |  |
`SPARK_enable`  | `false` | 1.0.0 | Generate Spark services
`SPARK_workers`  | `2` | 1.0.0 | number of Spark Worker nodes
`SPARK_history_enable`  | `false` | 1.0.0 | Generate Spark History Server
`SPARK_thrift_enable`  | `false` | 1.0.0 | Generate Spark Thrift Server
**_Apache Livy_** |  |  |
`LIVY_enable`  | `false` | 1.1.0 | Generate Spark Livy Server
**_Apache Hive_** |  |  |
`HIVE_enable`  | `false` | 1.0.0 | Generate Hive service
**_Apache Atlas & Amundsen_** |  |  |
`ATLAS_enable`  | `false` | 1.0.0 | Generate Atlas service
`AMUNDSEN_enable`  | `falsee` | 1.0.0 | Generate Amundsen service
**_Apache Hue_** |  |  |
`HUE_enable`  | `false` | 1.0.0 | Generate Hue UI service
**_StreamSets DataCollector_** |  | 
`STREAMSETS_enable`  | `false` | 1.0.0 | Generate StreamSets service
`STREAMSETS_EDGE_enable`  | `false` | 1.0.0 | Generate StreamSets Edge service
**_Apache NiFi_** |  |  |
`NIFI_enable`  | `false` | 1.1.0 | Generate Apache NiFi service
**_Node-RED_** |  |  |
`NODERED_enable`  | `false` | 1.1.0 | Generate Node-RED service
`NODERED_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Node-RED service
**_Apache Zeppelin_** |  | 
`ZEPPELIN_enable`  | `false` | 1.0.0 | Generate Apache Zeppelin service
**_Jupyter_** |  |  |
`JUPYTER_enable`  | `true` | 1.1.0 | Global Jupyter flag, if set to false, it will overwrite all of the specific JUPYTER_xxxx_enable flags 
`JUPYTER_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Jupyter service
`JUPYTER_minimal_enable`  | `false` | 1.1.0 | Generate Jupyter Minimal Notebook service
`JUPYTER_r_enable`  | `false` | 1.1.0 | Generate Jupyter R Notebook service
`JUPYTER_scipy_enable`  | `false` | 1.1.0 | Generate Jupyter Scipy Notebook service
`JUPYTER_tensorflow_enable`  | `false` | 1.1.0 | Generate Jupyter Tensorflow Notebook service
`JUPYTER_datascience_enable`  | `false` | 1.1.0 | Generate Jupyter Datascience Notebook service
`JUPYTER_all_spark_enable`  | `false` | 1.1.0 | Generate Jupyter All Spark Notebook service
**_Grafana_** |  |  |
`GRAFANA_enable`  | `false` | 1.0.0 | Generate Grafana service
**_Redis_** |  |  |
`REDIS_enable`  | `false` | 1.0.0 | Generate Redis service
**_Apache Cassandra_** |  | 
`CASSANDRA_enable`  | `false` | 1.0.0 | Generate Elasticsearch service
**_MongoDB_** |  |  |
`MONGODB_enable`  | `false` | 1.0.0 | Generate MongoDB service
**_Apache Solr_** |  |  |
`SOLR_enable`  | `false` | 1.0.0 | Generate Solr service
**_Elasticsearch & Kibana_** |  | 
`ELASTICSEARCH_enable`  | `false` | 1.0.0 | Generate Elasticsearch service
`KIBANA_enable`  | `false` | 1.0.0 | Generate Kibana service
**_Neo4J_** |  |  |
`NEO4J_enable`  | `false` | 1.0.0 | Generate Neo4J service
**Influx Data** |  |  |
`INFLUXDB_enable`  | `false` | 1.1.0 | Generate InfluxDB service
`INFLUXDB_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the InfluxDB service
`INFLUXDB_telegraf_enable`  | `false` | 1.1.0 | Generate Telegraf service
`INFLUXDB_chronograf_enable`  | `false` | 1.1.0 | Generate Chronograf service
`INFLUXDB_CHRONOGRAF_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Chronograf service
`INFLUXDB_kapacitor_enable`  | `false` | 1.1.0 | Generate Kapacitor service
`INFLUXDB_KAPACITOR_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Kapacitor service
`INFLUXDB2_enable`  | `false` | 1.1.0 | VGenerate InfluxDB 2.0 service
`INFLUXDB2_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the InfluxDB 2.0 service
**_Prometheus_** |  |  |
`PROMETHEUS_enable`  | `false` | 1.1.0 | Generate Prometheus service
`PROMETHEUS_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Prometheus service
**_Tile38_** |  |  |
`TILE38_enable`  | `false` | 1.0.0 | Generate Tile38 service
**_RDBMS_** |  |  |
`MYSQL_enable`  | `false` | 1.0.0 | Generate MySQL service
`SQLSERVER_enable`  | `false` | 1.0.0 | Generate SQL Server service
`POSTGRESQL_enable`  | `false` | 1.0.0 | Generate PostgreSQL service
`ADMINER_enable`  | `false` | 1.0.0 | Generate Adminer RDBMS Admin UI service
**_Event Store_** |  |  |
`AXON_enable`  | `false` | 1.0.0 | Generate Axon Server service
**_MQTT_** |  |  |
`MQTT_enable`  | `false` | 1.0.0 | Generate MQTT service, either using Mosquitto or HiveMQ
`MOSQUITTO_enable`  | `false` | 1.0.0 | Generate Mosquitto service
`MOSQUITTO_nodes `  | `1` | 1.1.0 | number of Mosquitto nodes
`MOSQUITTO_volume_map_data `  | `false` | 1.1.0 | Volume map data folder into the Mosquitto broker
`HIVEMQ_enable`  | `false` | 1.0.0 | Generate HiveMQ service
`MQTT_UI_enable`  | `false` | 1.0.0 | Generate MQTT UI service
**_ActiveMQ_** |  |  |
`ACTIVEMQ_enable`  | `false` | 1.0.0 | Generate ActiveMQ service
**_FTP_** |  |  |
`FTP_enable`  | `false` | 1.0.0 | Generate FTP service
**_Object Storage_** |  |  |
`MINIO_enable`  | `false` | 1.0.0 | Generate Minio service
`MINIO_volume_map_data`  | `false` | 1.1.0 | Volume map data folder into the Minio service
`AWSCLI_enable`  | `false` | 1.0.0 | Generate AWSCli service
**_Container Management_** |  |  |
`PORTAINER_enable`  | `false` | 1.0.0 | Generate Portainer Container UI service


