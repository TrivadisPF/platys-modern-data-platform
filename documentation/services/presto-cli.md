# Presto CLI

Distributed SQL Query Engine for Big Data. This container runs the Presto CLI.

**[Website](https://prestodb.io/)** | **[Documentation](https://prestodb.io/docs/current/installation/cli.html)** | **[GitHub](https://github.com/prestodb/presto)**

## How to enable?

```
platys init --enable-services PRESTO_CLI
platys gen
```

## How to use it?

```bash
docker exec -it presto-cli presto-cli --server presto-1:8080
```
