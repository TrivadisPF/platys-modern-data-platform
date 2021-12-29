# Remora

Kafka consumer lag-checking application for monitoring, written in Scala and Akka HTTP; a wrap around the Kafka consumer group command. Integrations with Cloudwatch and Datadog. Authentication recently added 

**[Documentation](https://github.com/zalando-incubator/remora)** | **[GitHub](https://github.com/zalando-incubator/remora)**

## How to enable?

```
platys init --enable-services KAFKA,REMORA
platys gen
```

## How to use it?

Show active consumers

```bash
curl http://dataplatform:28256/consumers
```

Show specific consumer group information

```bash
curl http://dataplatform:28256/consumers/<consumer-group-id>
```

Show health

```bash
curl http://dataplatform:28256/health
```

Metrics

```bash
curl http://dataplatform:28256/metrics
```
