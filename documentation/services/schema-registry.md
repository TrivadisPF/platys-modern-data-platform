# Confluent Schema Registry

Confluent Schema Registry for Kafka 

**[Website](https://docs.confluent.io/1.0/schema-registry/docs/intro.html)** | **[Documentation](https://docs.confluent.io/1.0/schema-registry/docs/intro.html)** | **[GitHub](https://github.com/confluentinc/schema-registry)**

## How to enable?

```
platys init --enable-services SCHEMA_REGISTRY
platys gen
```

## How to use it?

```
jq -n --slurpfile schema movies-raw.avsc  '$schema | {schema: tostring}' | curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data @- http://dataplatform:8081/subjects/movies-raw-value/versions  
```