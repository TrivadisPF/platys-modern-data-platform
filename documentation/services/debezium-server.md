# Debezium Server

Debezium can be deployed either as connector instances in a Kafka Connect cluster, or as a standalone application - Debezium Server. Debezium Server is a Quarkus-based high-performance application that streams data from database to a one of supported sinks or a user developed sink.

**[Website](https://debezium.io/documentation/reference/operations/debezium-ui.html)** | **[Documentation](https://debezium.io/documentation/reference/operations/debezium-server.html)** | **[GitHub](https://github.com/debezium/debezium/tree/master/debezium-server)**

## How to enable?

```
platys init --enable-services DEBEZIUM_SERVER
platys gen
```

## How to use it?
