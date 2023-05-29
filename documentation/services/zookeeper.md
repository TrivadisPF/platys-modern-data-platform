# Zookeeper

ZooKeeper is a high-performance coordination service for distributed applications. It exposes common services - such as naming, configuration management, synchronization, and group services - in a simple interface so you don't have to write them from scratch. You can use it off-the-shelf to implement consensus, group management, leader election, and presence protocols. And you can build on it for your own, specific needs.

**[Website](https://zookeeper.apache.org/)** | **[Documentation](https://zookeeper.apache.org/doc/r3.7.0/index.html)** | **[GitHub](https://github.com/apache/zookeeper)**

### How to enable?

```
platys init --enable-services ZOOKEEPER
platys gen
```

### How to use it?

You can use the command line tool to inspect zookeeper:

```bash
docker exec -ti zookeeper-1 bash
```

```bash
/bin/zookeeper-shell localhost:2181 ls /brokers/ids/1

/bin/zookeeper-shell localhost:2181 get /brokers/ids/1
```