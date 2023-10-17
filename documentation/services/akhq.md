# AKHQ

Kafka GUI for Apache Kafka to manage topics, topics data, consumers group, schema registry, connect and more... 

**[Website](https://akhq.io/)** | **[Documentation](https://github.com/tchiotludo/akhq#quick-preview)** | **[GitHub](https://github.com/tchiotludo/akhq)**

## How to enable?

```
platys init --enable-services AKHQ
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28107>.
If authentication is enabled, login with user `admin` and password `abc123!`.

To use the REST API <http://dataplatform:28107/api> (see <https://akhq.io/docs/api.html>)


### Monitoring API
  
  * <http://dataplatform:28320/info>  
  * <http://dataplatform:28320/health>
  * <http://dataplatform:28320/loggers>
  * <http://dataplatform:28320/metrics>
  * <http://dataplatform:28320/prometheus>