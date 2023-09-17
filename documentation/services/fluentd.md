# FluentD

Registry service for Apache Kafka which keeps track of topics, consumer-groups, acls, quotas and their configuration/state/metadata across multiple kafka-clusters.

It allows performing administrative operations such as inspecting/creating/deleting/re-configuring topics/consumer-groups.

It also provides various analytical tools such as: SQL querying metadata; viewing topic records; analyzing json record structures; re-balancing cluster tools; etc.

**[Website](https://www.fluentd.org/)** | **[Documentation](https://docs.fluentd.org/)** | **[GitHub](https://github.com/fluent/fluentd)**

## How to enable?

```
platys init --enable-services FLUENTD
platys gen
```

## How to use?

