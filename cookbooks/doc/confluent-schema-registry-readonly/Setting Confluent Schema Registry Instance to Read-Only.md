# Setting Confluent Schema Registry Instance to Read-Only

This tutorial will show how to set a schema registry instance to read-only by using a Custom Resource Extension plugin.

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `condfig.yml`

```
      KAFKA_enalbe: true
      SCHEMA_REGISTRY_enable: true
```

Now generate and start the data platform. 

If you are trying to add a schema to the schema registry you should succeed. Try the following REST API call

```
curl  -XPOST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{
  "schema": "{\"type\":\"record\",\"name\":\"Payment\",\"namespace\":\"com.trivadis.examples.clients.simpleavro\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"temp\",\"type\":\"double\"}]}"
}' http://dataplatform:8081/subjects/test-value/versions
```

## Add read-only configuration

In the `plugins/schema-registry` folder download the `schema-registry-readonly-plugin` Resource Extension Plugin:

```
cd ./plugins/schema-registry
wget https://github.com/TrivadisPF/schema-registry-readonly-plugin/releases/download/1.0.0/schema-registry-readonly-plugin-1.0.0.jar
```

Add the following to the ```docker-compose.override.yml```

```
version '3.0'
services:
  schema-registry-1:
    environment:
      SCHEMA_REGISTRY_RESOURCE_EXTENSION_CLASS: 'com.trivadis.kafka.schemaregistry.rest.extensions.SchemaRegistryReadOnlyResourceExtension'
    volumes:
      - ./plugins/schema-registry/schema-registry-readonly-plugin-1.0.0.jar:/usr/share/java/schema-registry/schema-registry-readonly-plugin-1.0.0.jar
```

```
docker-compose up -d
```

```
curl  -XPOST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{
  "schema": "{\"type\":\"record\",\"name\":\"Payment\",\"namespace\":\"com.trivadis.examples.clients.simpleavro\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"temp\",\"type\":\"double\"}]}"
}' http://dataplatform:8081/subjects/test-value/versions
```