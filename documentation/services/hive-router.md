# GraphQL Hive Router

GraphQL Hive Router is a high-performance GraphQL federation router written in Rust. It serves a composed supergraph and routes incoming queries to the underlying subgraphs.

**[Website](https://the-guild.dev/graphql/hive/docs/router)** | **[Documentation](https://the-guild.dev/graphql/hive/docs/router)** | **[GitHub](https://github.com/graphql-hive/router)**

## Ports

| External Port | Internal Port | Description          |
|:-------------:|:-------------:|----------------------|
| 28148         | 4000          | GraphQL endpoint     |

## How to enable?

```bash
platys init --enable-services HIVE_ROUTER
platys gen
```

```yaml
HIVE_ROUTER_enable: true
```

## Configuration

The router serves the supergraph defined in `conf/hive-router/supergraph.graphql`, which is mounted into the container at `/app/supergraph.graphql` and referenced through the `SUPERGRAPH_FILE_PATH` environment variable. Replace the placeholder with your composed supergraph SDL, for example:

```bash
# with the Hive CLI
hive schema:compose --output supergraph.graphql

# or with Apollo rover
rover supergraph compose --config supergraph.yaml > supergraph.graphql
```

Use a different file name by setting `HIVE_ROUTER_supergraph_file`.

## How to use it?

- **GraphQL endpoint**: <http://dataplatform:28148/graphql>

## Hive Router vs. Hive Gateway

Both serve an Apollo-Federation supergraph. The **Router** is a newer, Rust-based implementation focused on raw performance, while the **Gateway** is the JavaScript implementation with a broader plugin ecosystem. Enable whichever fits your needs (they can both run, on ports 28148 and 28147 respectively).
