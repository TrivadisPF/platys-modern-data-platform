# ksqlDB

The database purpose-built for stream processing applications. 

**[Website](https://ksqldb.io/)** | **[Documentation](https://ksqldb.io/quickstart.html)** | **[GitHub](https://github.com/confluentinc/ksql)**

```
platys init --enable-services KAFKA_KSQLDB
platys gen
```

### List Configuration

```
docker exec -ti ksqldb-server-1 cat /etc/ksqldb/ksqldb-server.properties
```

### Running the CLI

```
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```
