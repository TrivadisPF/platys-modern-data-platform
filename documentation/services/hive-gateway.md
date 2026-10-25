# GraphQL Hive Gateway

GraphQL Hive Gateway is a fully open-source, highly performant GraphQL gateway compatible with Apollo Federation. It serves a composed supergraph and routes incoming queries to the underlying subgraphs.

**[Website](https://the-guild.dev/graphql/hive/docs/gateway)** | **[Documentation](https://the-guild.dev/graphql/hive/docs/gateway)** | **[GitHub](https://github.com/graphql-hive/gateway)**

## Ports

| External Port | Internal Port | Description          |
|:-------------:|:-------------:|----------------------|
| 28147         | 4000          | GraphQL endpoint     |

## How to enable?

```bash
platys init --enable-services HIVE_GATEWAY
platys gen
```

```yaml
HIVE_GATEWAY_enable: true
```

## Configuration

The gateway serves the supergraph defined in `custom-conf/hive-gateway/supergraph.graphql` (mounted into the container at `/gateway/supergraph.graphql`). Replace the placeholder with your composed supergraph SDL, for example:

```bash
# with the Hive CLI
hive schema:compose --output supergraph.graphql

# or with Apollo rover
rover supergraph compose --config supergraph.yaml > supergraph.graphql
```

Use a different file name by setting `HIVE_GATEWAY_supergraph_file`.

## How to use it?

- **GraphQL endpoint**: <http://dataplatform:28147/graphql>

The gateway can also run against a Hive schema registry (CDN) instead of a static supergraph file — see the [Hive Gateway docs](https://the-guild.dev/graphql/hive/docs/gateway) for that mode.
