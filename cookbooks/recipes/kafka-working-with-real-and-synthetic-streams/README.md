---
technologies:       lakefs,minio
version:				1.19.0
validated-at:			3.7.2025
---

# Working with real and synthetic data streams

This recipe will show how to stream data into Kafka using various real and synthetic datastreams. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
export DATAPLATFORM_HOME=${PWD}
platys init --enable-services KAFKA,AKHQ,SCHEMA_REGISTRY,KAFKA_CONNECT -s trivadis/platys-modern-data-platform -w 1.19.0

platys gen
docker-compose up -d
```


## Bluesky

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
kcat -q -b dataplatform:9092 -t bluesky.raw
```

What are the different message types?

```bash
kcat -q -b dataplatform:9092 -t bluesky.raw | jq .record.commit.collection
```

Let's view only the `text` of an `app.bsky.feed.post` message

```bash
kcat -q -b dataplatform:9092 -t bluesky.raw | jq 'select(.record.commit.collection == "app.bsky.feed.post") | .record.commit.record.text'
```

## Vehicles




   