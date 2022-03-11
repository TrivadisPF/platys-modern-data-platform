---
technoglogies:      kafka
version:				1.14.0
validated-at:			1.3.2020
---

# Using Confluent Cloud with Platys

This recipe will show how combine Platys with an external Kafka cluster, using Confluent Cloud as an example.

## Initialise a Confluent Cloud environment

Navigate to <https://confluent.cloud/> and create a cluster.



## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) witout specifying a specific service

```bash
platys init -s trivadis/platys-modern-data-platform -w 1.14.0
```

## Configure the external Kafka

Open the `config.yml` file in an editor

```bash
      # ========================================================================
      # External Services
      # ========================================================================
      external:
          KAFKA_enable: true
          KAFKA_bootstrap_servers: pkc-zpjg0.eu-central-1.aws.confluent.cloud:9092
          KAFKA_username: MHSED2OIUKMFVYMO
          KAFKA_password: g9X/m+8ybyjQMiWsOM2qx6Uy8553+d8c/lf9tVvMJxQCOXgwoeII6r/lFYO3Qguq
          SCHEMA_REGISTRY_enable: true
          SCHEMA_REGISTRY_url: https://psrc-do01d.eu-central-1.aws.confluent.cloud
          S3_enable: false
          S3_endpoint:
          S3_default_region:
          S3_path_style_access: false
```

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

