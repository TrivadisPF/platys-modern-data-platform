## Configuration

The list of variables that can be configured for the service generator can be found in the [`generator-config/vars/default-values.yml`](./generator-config/vars/default-values.yml)


Config        |  Default | Description
------------- | ---------| -----------------
**_Apache Zookeeper_** |  | 
`ZOOKEEPER_enabled`   | `false` | Use Zookeeper
`ZOOKEEPER_nodes`   | `1` | number of Zookeeper nodes
**_Apache Kafka Broker_** |  | 
`KAFKA_enabled`   | `false` | Use Kafka 
`KAFKA_volume_map_data`   | `false` | Volume map data folder into the Kafka broker
`KAFKA_nodes`   | `3` | number of Kafka Broker nodes to use
`KAFKA_delete_topic_enable`   | `false` | allow deletion of Kafka topics
`KAFKA_auto_create_topics_enable`  | `false` | allow automatic creation of Kafka topics
**_Confluent Schema Registry_** |  | 
`KAFKA_schema_registry_enabled`  | `false` | Generate Confluent Schema Registry service
`KAFKA_schema_registry_nodes`  | `false` | number of Confluent Schema Registry nodes
`KAFKA_schema_registry_use_zookeeper_election`  | `false` | use Zookeeper for election of "master" Schema Registry node
`KAFKA_schema_registry_replication_factor`  | `1` | replication factor to use for the `_schemas` topic
**_Apache Kafka Connect_** |  | 
`KAFKA_connect_enabled`  | `false` | Generate Kafka Connect service
`KAFKA_connect_nodes`   | `2` | number of Kafka Connect nodes
**_ksqlDB_** |  | 
`KAFKA_ksqldb_enabled`  | `false` | Generate ksqlDB service
`KAFKA_ksqldb_nodes`   | `2` | number of ksqlDB nodes
**_Confluent REST and MQTT Proxy_** |  | 
``KAFKA_restproxy_enabled`  | `false` | Generate Confluent REST Proxy service
`KAFKA_mqttproxy_enabled`  | `false` | Generate Confluent MQTT Proxy service
**_Kafka UIs_** |  | 
`KAFKA_schema_registry_ui_enabled`  | `false` | Generate Landoop Schema-Registry UI service
`KAFKA_connect_ui_enabled`  | `false` | Generate Landoop Connect UI service
`KAFKA_manager_enabled`  | `false` | Generate Kafka Manger service
`KAFKA_kafdrop_enabled`  | `false` | Generate Kafdrop service
`KAFKA_kadmin_enabled`  | `false` | Generate KAdmin service
`KAFKA_kafkahq_enabled`  | `false` | Generate KafkaHQ service
`KAFKA_burrow_enabled`  | `false` | Generate Burrow service
**_Apache Hadoop_** |  | 
`HADOOP_enabled`  | `false` | Generate Hadoop services
`HADOOP_datanodes`  | `2	` | number of Hadoop Datanodes
**_Apache Spark_** |  | 
`SPARK_enabled`  | `false` | Generate Spark services
`SPARK_workers`  | `2` | number of Spark Worker nodes
`SPARK_history_enabled`  | `false` | Generate Spark History Server
`SPARK_thrift_enabled`  | `false` | Generate Spark Thrift Server
`SPARK_livy_enabled`  | `false` | Generate Spark Livy Server
**_Apache Hive_** |  | 
`HIVE_enabled`  | `false` | Generate Hive service
**_Apache Atlas & Amundsen_** |  | 
`ATLAS_enabled`  | `false` | Generate Atlas service
`AMUNDSEN_enabled`  | `falsee` | Generate Amundsen service
**_Apache Hue_** |  | 
`HUE_enabled`  | `false` | Generate Hue UI service
**_StreamSets DataCollector_** |  | 
`STREAMSETS_enabled`  | `false` | Generate StreamSets service
`STREAMSETS_EDGE_enabled`  | `false` | Generate StreamSets Edge service
**_Apache NiFi_** |  | 
`NIFI_enabled`  | `false` | Generate Apache NiFi service
**_Apache Zeppelin_** |  | 
`ZEPPELIN_enabled`  | `false` | Generate Apache Zeppelin service
**_Jupyter_** |  | 
`JUPYTER_minimal_enabled`  | `false` | Generate Jupyter Minimal Notebook service
`JUPYTER_r_enabled`  | `false` | Generate Jupyter R Notebook service
`JUPYTER_scipy_enabled`  | `false` | Generate Jupyter Scipy Notebook service
`JUPYTER_tensorflow_enabled`  | `false` | Generate Jupyter Tensorflow Notebook service
`JUPYTER_datascience_enabled`  | `false` | Generate Jupyter Datascience Notebook service
`JUPYTER_all_spark_enabled`  | `false` | Generate Jupyter All Spark Notebook service
`JUPYTER_volume_map_data`  | `false` | Volume map data folder into the Jupyter service



