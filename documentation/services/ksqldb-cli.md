# ksqlDB CLI

The database purpose-built for stream processing applications. This container runs the ksqlDB CLI. 

**[Website](https://ksqldb.io/)** | **[Documentation](https://ksqldb.io/quickstart.html)** | **[GitHub](https://github.com/confluentinc/ksql)**

## How to enable?

```
platys init --enable-services KAFKA_KSQLDB
platys gen
```

## How to use it?

### Running the CLI

```
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```


