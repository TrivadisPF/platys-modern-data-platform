# Apache Livy

Apache Livy is a service that enables easy interaction with a Spark cluster over a REST interface. It enables easy submission of Spark jobs or snippets of Spark code, synchronous or asynchronous result retrieval, as well as Spark Context management, all via a simple REST interface or an RPC client library. Apache Livy also simplifies the interaction between Spark and application servers, thus enabling the use of Spark for interactive web/mobile applications.

**[Website](https://livy.incubator.apache.org/)** | **[Documentation](https://livy.incubator.apache.org/)** | **[GitHub](https://github.com/apache/incubator-livy)**

## How to enable?

```
platys init --enable-services SPARK,LIVY
platys gen
```

## How to use it?

