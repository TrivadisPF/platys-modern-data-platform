# Apache Cassandra

Apache Cassandra is an open source NoSQL distributed database trusted by thousands of companies for scalability and high availability without compromising performance. Linear scalability and proven fault-tolerance on commodity hardware or cloud infrastructure make it the perfect platform for mission-critical data.

**[Website](https://cassandra.apache.org)** | **[Documentation](https://cassandra.apache.org/doc/latest/)** | **[GitHub](https://github.com/apache/cassandra)**

## How to enable?

```
platys init --enable-services CASSANDRA
platys gen
```

## How to use it?

To connect with the Cassandra CLI

```bash
docker exec -ti cassandra-1 cqlsh -u cassandra -p cassandra
```