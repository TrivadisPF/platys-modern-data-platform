# RustFS

RustFS is an open-source, S3-compatible high-performance object storage system supporting migration and coexistence with other S3-compatible platforms such as MinIO and Ceph. 

**[Website](https://rustfs.com)** | **[Documentation](https://docs.rustfs.com)** | **[GitHub](https://github.com/rustfs/rustfs)**

## How to enable?

```bash
platys init --enable-services RUSTFS
platys gen
```

## How to use it?

Navigate to <http://dataplatform:9014>.


### Bucket event notifications

RustFS can send bucket events to a webhook, an MQTT broker and/or Kafka. Enable them with `RUSTFS_notify_webhook_enabled`, `RUSTFS_notify_mqtt_enabled` and/or `RUSTFS_notify_kafka_enabled` (see [configuration](../configuration.md) for the endpoint, topic and credential settings). `RUSTFS_NOTIFY_ENABLE` is set automatically. The targets are named `primary`, so the ARN to use in the bucket notification configuration is `arn:rustfs:sqs:us-east-1:primary:webhook`, `arn:rustfs:sqs:us-east-1:primary:mqtt` or `arn:rustfs:sqs:us-east-1:primary:kafka`.

Events are only sent for buckets which have a notification configuration referring to the target ARN.
