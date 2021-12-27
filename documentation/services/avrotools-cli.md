# Avro Tools CLI

Apache Avro™ is a data serialization system and Avro Tools help workin with Avro instances and schmeas. 

**[Website](https://avro.apache.org/)** | **[Documentation](https://avro.apache.org/)** | **[GitHub](https://github.com/apache/avro)**

## How to enable?

```
platys init --enable-services AVRO_TOOLS
platys gen
```

## How to use it?

To use the avro tool, once it is generated, just use the `docker exec` command:

```bash
docker exec -ti avrotools-cli avro-tools-runner <command>
```