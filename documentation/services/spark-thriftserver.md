# Spark Thriftserver

Thrift JDBC/ODBC Server (aka Spark Thrift Server or STS) is Spark SQL’s port of Apache Hive’s HiveServer2 that allows JDBC/ODBC clients to execute SQL queries over JDBC and ODBC protocols on Apache Spark.

**[Website](https://spark.apache.org/)** | **[Documentation](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html#running-the-thrift-jdbcodbc-server)** | **[GitHub](https://github.com/apache/spark/tree/master/sql/hive-thriftserver)**

## How to enable?

```
platys init --enable-services SPARK,SPARK_THRIFTSERVER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28298> to view the Thriftserver UI.

### Connect with Beeline

Start beeline

```bash
docker exec -ti spark-thriftserver /spark/bin/beeline
```

and connect to Spark Thrift Server (enter blank for username and password)

```bash
!connect jdbc:hive2://spark-thriftserver:10000
```

### Connect with JDBC

Download Hive JDBC Driver 3.1.2 (standalone) from [here](https://repo.maven.apache.org/maven2/org/apache/hive/hive-jdbc/3.1.2/hive-jdbc-3.1.2-standalone.jar).

Use `jdbc:hive2://dataplatform:28118` (external) or `jdbc:hive2://spark-thriftserver:10000` (internal) for the JDBC URL and use `org.apache.hive.jdbc.HiveDriver` for the class name. 
