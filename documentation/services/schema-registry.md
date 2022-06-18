# Confluent Schema Registry

Confluent Schema Registry for Kafka 

**[Website](https://docs.confluent.io/1.0/schema-registry/docs/intro.html)** | **[Documentation](https://docs.confluent.io/1.0/schema-registry/docs/intro.html)** | **[GitHub](https://github.com/confluentinc/schema-registry)**

## How to enable?

```
platys init --enable-services SCHEMA_REGISTRY
platys gen
```

## How to use it?

### Uploading a Schema via script

using `curl`

```bash
export TOPIC=topicName
export SCHEMA=$(jq tostring $TOPIC-value.avsc)

echo "{\"schema\":$SCHEMA}"

curl -XPOST -H "Content-Type:application/json" -d"{\"schema\":$SCHEMA}" http://dataplatform:8081/subjects/$TOPIC-value/versions
```

using `httpie`

```bash
export TOPIC=topicName
http -v POST :8081/subjects/example.with-schema.user-value/versions \
  Accept:application/vnd.schemaregistry.v1+json \
  schema=@avro/src/main/avro/user.avsc
```

### Downloading a schema (for a subject) from schema registry

using `curl`

```bash
export TOPIC=topicName
curl http://dataplatfor:8081/subjects/$TOPIC-value/versions/latest | jq -r '.schema|fromjson' > $TOPIC-value.avsc
```

using `httpie`


```bash
export TOPIC=topicName
http http://dataplatform:8081/subjects/$TOPIC-value/versions/latest \
  | jq -r '.schema|fromjson' \
  > $TOPIC-value.avsc
```
  
  