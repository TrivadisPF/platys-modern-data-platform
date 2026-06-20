# Apache NiFi - MiNiFi - (C++)

MiNiFi - a subproject of Apache NiFi - is a lightweight edge agent derived from Apache NiFi, designed to collect and route data at the source (sensors, IoT devices, edge nodes) with a minimal footprint. It runs the same dataflow model as NiFi but stripped down for resource-constrained environments, feeding data upstream into a full NiFi instance or directly into Kafka.

**[Website](https://nifi.apache.org/projects/minifi/)** | **[Documentation](https://github.com/apache/nifi-minifi-cpp/tree/main)** | **[GitHub](https://github.com/apache/nifi-minifi-cpp)**

## How to enable?

```bash
platys init --enable-services MINIFI
platys gen
```

## How to use it?

