# Bluesky to Elasticsearch

In this small tutorial we will be tapping into the Bluesky social media firehose and send the posts via Kafka into Elasticsearch to visualize it over Kibana.

## Configure Platys stack

```bash
platys init -n platys-platform --stack trivadis/platys-modern-data-platform --stack-version develop -f  --structure flat
```

```yaml
KAFKA_enable: true
KAFKA_CONNECT_enable: true
KCAT_enable: true
AKHQ_enable: true
KAFKA_CONNECT_UI: true
ELASTICSEARCH_enable: true
KIBANA_enable: true
```

Configure the Elasticsearch connector and the additional SMTs

```yaml
KAFKA_CONNECT_connectors: 'confluentinc/kafka-connect-elasticsearch:15.0.0,confluentinc/connect-transforms:latest'
```

```bash
platys gen
```

## Creating the Bluesky retriever

Create the Kafka topic

```bash
docker exec -ti kafka-1 kafka-topics --bootstrap-server kafka-1:19092 --create --topic bluesky.raw --replication-factor 3 --partitions 8
```

Run the bluesky retriever

```bash
docker run --name bluesky-retriever --rm -d -e DESTINATION=kafka -e KAFKA_BROKERS=dataplatform:9092 -e KAFKA_TOPIC=bluesky.raw ghcr.io/gschmutz/bluebird:latest
```

Let's see the messages comming in with `kcat` 

```bash
kca	t -q -b dataplatform:9092 -t bluesky.raw
```

What are the different message types?

```bash
kcat -q -b dataplatform:9092 -t bluesky.raw | jq .record.commit.collection
```

Let's view only the `text` of an `app.bsky.feed.post` message

```bash
kcat -q -b dataplatform:9092 -t bluesky.raw | jq 'select(.record.commit.collection == "app.bsky.feed.post") | .record.commit.record.text'
```

## Kafka Connect - Elasticsearch Sink Connector

Add the Elasticsearch connector

```bash
curl -X PUT \
  http://dataplatform:8083/connectors/elasticsearch-bluesky-sink/config \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d '{
  "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
  "type.name": "_doc",
  "tasks.max": "1",
  "topics": "bluesky.raw",
  "connection.url": "http://elasticsearch-1:9200",
  "key.ignore": "true",
  "key.converter": "org.apache.kafka.connect.storage.StringConverter",
  "schema.ignore": "true",
  "type.name": "kafkaconnect",
  "value.converter": "org.apache.kafka.connect.json.JsonConverter",
  "value.converter.schemas.enable": "false",
  "value.converter.schema.registry.url": "http://schema-registry-1:8081",
  "errors.tolerance": "all",
  "errors.log.include.messages": "true",
  "errors.deadletterqueue.topic.name": "es-sink.bluesky.dlq",
  "errors.log.enable": "false",
  "behavior.on.malformed.documents": "ignore",
  "drop.invalid.message": "true",
  "behavior.on.null.values": "IGNORE",
  "transforms": "filterValue",
  "transforms.filterValue.filter.condition": "$[?(@.record.commit.collection =~ /.*app.bsky.feed.post/)]",
  "transforms.filterValue.filter.type": "include",
  "transforms.filterValue.type": "io.confluent.connect.transforms.Filter$Value"  
}'
```

Visulalize the connector in the [Kafka Connect UI](http://dataplatform:28103/).


## Kibana - Visualize the Posts

Navigate to <http://dataplatform:5601>