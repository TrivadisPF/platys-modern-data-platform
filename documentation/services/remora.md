# Remora

Kafka consumer lag-checking application for monitoring, written in Scala and Akka HTTP; a wrap around the Kafka consumer group command. Integrations with Cloudwatch and Datadog. Authentication recently added 

**[Documentation](https://github.com/zalando-incubator/remora)** | **[GitHub](https://github.com/zalando-incubator/remora)**

## How to enable?

```
platys init --enable-services KAFKA,REMORA
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28256>