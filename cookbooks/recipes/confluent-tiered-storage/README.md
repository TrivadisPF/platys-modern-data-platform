---
technoglogies:      kafka,confluent
version:				1.13.0
validated-at:			8.7.2021
---

# Using Confluent Enterprise Tiered Storage

This recipe will show how to support activation of StreamSets Data Collector in persistent and replayable way.

The problem with the activation of StreamSets is, that an activation code is given for a given `SDC ID` (a.k.a product id). If you restart the StreamSets Data Collector container, everything is fine, but if you stop, remove and recrate the container, a new `SDC ID` is generated and you have to re-activate StreamSets. 

This recipe shows, how the `SDC ID` can be fixed to a value, so that recreating a container won't change it. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,PLATYS -s trivadis/platys-modern-data-platform -w 1.13.0
```

Edit the `config.yml` and add the following configuration settings.

```
      KAFKA_edition: 'enterprise'
      
      KAFKA_confluent_tier_enable: true
      KAFKA_confluent_tier_feature: true
      KAFKA_confluent_tier_s3_aws_endpoint_override: http://minio-1:9000
      KAFKA_confluent_tier_s3_force_path_style_access: true
      KAFKA_confluent_tier_local_hotset_ms: 0
      KAFKA_confluent_tier_local_hotset_bytes: -1
      KAFKA_confluent_tier_archiver_num_threads: 8
      KAFKA_confluent_tier_fetcher_num_threads: 16
      KAFKA_confluent_tier_topic_delete_check_interval_ms: 60000
      
      KAFKA_log_segment_bytes: 1048576
```

Now generate data platform 

```
platys gen
```

and then start the platform:

```
docker-compose up -d
```

## Creating a Topic with Tiering enabled

```
kafka-topics --bootstrap-server kafka-1:19092   \
  --create --topic truck_position \
  --partitions 8 \
  --replication-factor 3 \
  --config confluent.tier.enable=true \
  --config confluent.tier.local.hotset.ms=3600000 \
  --config retention.ms=604800000
```