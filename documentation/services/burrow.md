# Burrow

Burrow is a monitoring companion for Apache Kafka that provides consumer lag checking as a service without the need for specifying thresholds. It monitors committed offsets for all consumers and calculates the status of those consumers on demand. An HTTP endpoint is provided to request status on demand, as well as provide other Kafka cluster information. There are also configurable notifiers that can send status out via email or HTTP calls to another service.

**[Website](https://github.com/linkedin/Burrow)** | **[Documentation](https://github.com/linkedin/Burrow)** | **[GitHub](https://github.com/linkedin/Burrow)**

## How to enable?

```
platys init --enable-services KAFKA,BURROW
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28260>