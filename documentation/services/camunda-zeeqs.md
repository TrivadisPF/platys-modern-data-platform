# ZeeQS - Zeebe Query Service

A Zeebe community extension that provides a GraphQL query API over Zeebe's data. The data is imported from the broker using an exporter (e.g. Hazelcast, Elasticsearch) and aggregated in the service.

**[Documentation](https://github.com/camunda-community-hub/zeeqs)** | **[GitHub](https://github.com/camunda-community-hub/zeeqs)**

## How to enable?

```
platys init --enable-services CAMUNDA_ZEEQS
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28208/graphiql>.

