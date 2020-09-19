# Setting Schema Registry to Read-Only
This tutorial will show the Hive Hook and Atlas in Action.

## Initialise a platform with Kafka and Schema Registry

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      KAFKA_enable: true
      KAFKA_SCHEMA_REGISTRY_enable: false
      KAFKA_SCHEMA_REGISTRY_UI_enable: true
      KAFKA_AKHQ_enable: true
```

## Using the Schema Registry Resource Extension


Create a `docker-compose.override.yml` file located where the platys-generated `docker-compose.yml` is and add


```
version: "3.0"

services:
  schema-registry-1:
    environment:
      SCHEMA_REGISTRY_RESOURCE_EXTENSION_CLASS: 'com.trivadis.kafka.schemaregistry.rest.extensions.SchemaRegistryReadOnlyResourceExtension'
    volumes:
      - ./plugins/schema-registry/schema-registry-readonly-plugin-1.0.0.jar:/usr/share/java/schema-registry/schema-registry-readonly-plugin-1.0.0.jar
```

Now navigate to the `plugins/schema-registry` folder (create it if it does not exist) and download the resource extension

```
wget https://github.com/TrivadisPF/schema-registry-readonly-plugin/releases/download/1.0.0/schema-registry-readonly-plugin-1.0.0.jar
```

Now let's start the stack. 

```
docker-compose up -d
```

Check with a `POST` request that registering a schema is no longer possible:
 
```
curl  -XPOST -H "Content-Type: application/vnd.schemaregistry.v1+json" --data '{
  "schema": "{\"type\":\"record\",\"name\":\"Payment\",\"namespace\":\"com.trivadis.examples.clients.simpleavro\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"temp\",\"type\":\"double\"}]}"
}' http://<schema-registry-url>/subjects/test-value/versions
{"error_code":42205,"message":"This schema-registry instance is read-only (forced by the SchemaRegistryReadOnlyResourceExtension)"}
```

and you will get the following error message.

```
{"error_code":42205,"message":"This schema-registry instance is read-only (forced by the SchemaRegistryReadOnlyResourceExtension)"}
```

The schema-registry is in read-only mode!

A `GET` request for the subjects however will work. 

```
curl  -XGET -H "Content-Type: application/vnd.schemaregistry.v1+json"  http://<schema-registry-url>/subjects
```

