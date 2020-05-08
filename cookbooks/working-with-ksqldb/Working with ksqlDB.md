# Working with ksqlDB

This tutorial will show how to access Delta Lake table from with Presto.

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      KAFKA_enable: true
      SCHEMA_REGISTRY_enable: true
      KSQLDB_enable: true
```

Now generate and start the data platform. 

## Connect to ksqlDB

```
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```
