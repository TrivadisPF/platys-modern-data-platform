# Apache Spark Connect

Spark Connect introduces a decoupled client-server architecture for Apache Spark that allows remote connectivity from any language or tool over a gRPC interface. Clients connect to the Spark Connect server without embedding a Spark driver, enabling lightweight, language-agnostic access to Spark.

**[Website](https://spark.apache.org/)** | **[Documentation](https://spark.apache.org/docs/latest/spark-connect-overview.html)** | **[GitHub](https://github.com/apache/spark)**

## How to enable?

```
platys init --enable-services SPARK,SPARK_CONNECT
platys gen
```

## How to use it?

### Connect with PySpark

Install the PySpark client:

```bash
pip install pyspark
```

Connect from Python using the Spark Connect URL:

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .remote("sc://dataplatform:15002") \
    .getOrCreate()

df = spark.range(10)
df.show()
```

### Spark Connect UI

Navigate to <http://dataplatform:24040> to view the Spark application UI for the Connect server.
