## Configuration

The list of variables that can be configured for the service generator can be found in the `generator-config/vars/default-values.yml`


Config        |  Default | Description
------------- | ---------| -----------------
`ZOOKEEPER_enabled`   | `false` | Use Zookeeper
`ZOOKEEPER_nodes`   | `1` | number of Zookeeper nodes to use
 | | 
`KAFKA_enabled`   | `false` | Use Kafka 
`KAFKA_volume_map_data`   | `false` | Use Kafka Broker
`KAFKA_nodes`   | `3` | number of Kafka Broker nodes to use
`KAFKA_delete_topic_enable`   | `false` | allow deletion of Kafka topics
`KAFKA_auto_create_topics_enable`  | `false` | allow automatic creation of Kafka topics
 | | 
`KAFKA_schema_registry_enabled`  | `false` | Generate Confluent Schema Registry service
`KAFKA_schema_registry_nodes`  | `false` | number of Confluent Schema Registry nodes
