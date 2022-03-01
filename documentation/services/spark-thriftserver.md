# Spark Thriftserver

Thrift JDBC/ODBC Server (aka Spark Thrift Server or STS) is Spark SQL’s port of Apache Hive’s HiveServer2 that allows JDBC/ODBC clients to execute SQL queries over JDBC and ODBC protocols on Apache Spark.

**[Website](https://spark.apache.org/)** | **[Documentation](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html#running-the-thrift-jdbcodbc-server)** | **[GitHub](https://github.com/apache/spark/tree/master/sql/hive-thriftserver)**

## How to enable?

```
platys init --enable-services SPARK,SPARK_THRIFTSERVER
platys gen
```

## How to use it?

