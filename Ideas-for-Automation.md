# Ideas for Automation

## Service Snippets

Each service to be used in a stack is described as an independent artefact (currently a file). The name of the file includes the service-name and an optional version. 

For example the file `kafka-5.1.0` would hold

```
  kafka-1:
    image: confluentinc/cp-enterprise-kafka:5.1.0
    hostname: broker-1
    depends_on:
      - zookeeper-1
    ports:
      - "9092:9092"
    environment:
      KAFKA_BROKER_ID: $1
      KAFKA_BROKER_RACK: 'r1'
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper-1:2181'
      KAFKA_ADVERTISED_LISTENERS: 'PLAINTEXT://${DOCKER_HOST_IP}:9092'
      KAFKA_METRIC_REPORTERS: io.confluent.metrics.reporter.ConfluentMetricsReporter
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_DELETE_TOPIC_ENABLE: 'true'
      KAFKA_AUTO_CREATE_TOPICS_ENABLE: 'false'
      KAFKA_JMX_PORT: 9994
      CONFLUENT_METRICS_REPORTER_BOOTSTRAP_SERVERS: broker-1:9092
      CONFLUENT_METRICS_REPORTER_ZOOKEEPER_CONNECT: zookeeper-1:2181
      CONFLUENT_METRICS_REPORTER_TOPIC_REPLICAS: 1
      CONFLUENT_METRICS_ENABLE: 'true'
      CONFLUENT_SUPPORT_CUSTOMER_ID: 'anonymous'
    restart: always
```


## Idea for a stack file
```
stack: 
  properties: 
    key: value
  version: 1.0
  description: 
    a docker stack with Kafka, Streamsets, 
  services:
    [1-3]kafka-5.1.0
    [1-3]zookeeper
    schema-registry
    [1-2]kafka-connect
    schema-registry-ui
    kafka-connect-ui
    streamsets
    spark-master
    spark-worker[1-3]
    hadoop-namenode
    hadoop-datanode[1-3]
```    
    