# Apache Kafka

Apache Kafka is an open-source distributed event streaming platform used by thousands of companies for high-performance data pipelines, streaming analytics, data integration, and mission-critical applications. 

**[Website](http://kafka.apache.org)** | **[Documentation](https://kafka.apache.org/documentation)** | **[GitHub](https://github.com/apache/kafka)**

## How to enable?

```
platys init --enable-services KAFKA
platys gen
```

## How to use?

Connecting to one of the brokers (i.e. `kafka-1`)

```
docker exec -ti kafka-1 bash
```

Show all the topics

```
docker exec -ti kafka-1 kafka-topics --bootstrap-sever kafka-1:29092 --list
```

Show all the topics (on cluster with security)

```
docker exec -ti kafka-1 kafka-topics --bootstrap-sever kafka-1:29092 --list --command-config /tmp/client.properties
```



Show metadata of KRaft Cluster

```bash
docker exec -ti kafka-1 kafka-dump-log --cluster-metadata-decoder --files /var/lib/kafka/data/__cluster_metadata-0/00000000000000000000.log
```
