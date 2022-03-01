# Jikkou

A command-line tool to help you automate the management of the configurations that live on your Apache Kafka clusters. 

**[Documentation](https://github.com/streamthoughts/jikkou)** | **[GitHub](https://github.com/streamthoughts/jikkou)**

## How to enable?

```
platys init --enable-services JIKKOU
platys gen
```

## How to use it?

Place desired state of Kafka Topics, ACLs, or Quotas into the `./scripts/jikkou/topic-specs.yml` file.

Here a sample of a `topic-specs.yml` file

```yaml
version: 1
specs:
  topics:
  - name: 'my-first-topic-with-jikkou'
    partitions: 12
    replication_factor: 3
    configs:
      min.insync.replicas: 2
```

The file is applied the first time you start the stack using `docker-compose up -d` as well as anytime you apply the `docker-compose up -d` on an already running stack, where it will apply the necessary changes to get from the current to the desired state (if you have changed the topic-specs.yml file).