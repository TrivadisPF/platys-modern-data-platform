# Apache Hive Metastore

Hive metastore (HMS) is a service that stores metadata related to Apache Hive and other services, in a backend RDBMS, such as MySQL or PostgreSQL. Impala, Spark, Hive, and other services share the metastore. The connections to and from HMS include HiveServer, Ranger, and the NameNode that represents HDFS.

**[Website](https://hive.apache.org/)** | **[Documentation](https://cwiki.apache.org/confluence/display/Hive/GettingStarted)** | **[GitHub](https://github.com/apache/hive)**

## How to enable?

```
platys init --enable-services HIVE_METASTORE
platys gen
```

## How to use it?

