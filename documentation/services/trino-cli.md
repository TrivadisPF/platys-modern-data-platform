# Trino CLI

Distributed SQL Query Engine for Big Data. This container runs the Trino CLI.

**[Website](https://trino.io/)** | **[Documentation](https://trino.io/docs/current/client/cli.html)** | **[GitHub](https://github.com/trinodb/trino)**

## How to enable?

```
platys init --enable-services TRINO_CLI
platys gen
```

## How to use it?

```bash
docker exec -it trino-cli trino --server trino-1:8080
```
