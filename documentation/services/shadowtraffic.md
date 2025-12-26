# ShadowTraffic

ShadowTraffic is a product that helps you rapidly simulate production traffic to your backend—primarily to Apache Kafka, Postgres, S3, webhooks, and a few others.

**[Website](https://shadowtraffic.io/)** | **[Documentation](https://docs.shadowtraffic.io/)**

## How to enable?

```bash
platys init --enable-services SHADOW_TRAFFIC
platys gen
```

## How to use it?

Place a config into the `./scripts/shadowtraffic` folder.