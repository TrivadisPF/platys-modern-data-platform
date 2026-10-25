# GraphQL Hive Yoga

GraphQL Yoga is a fully-featured, batteries-included GraphQL server that is easy to set up and performant. In the Platys platform it is used to run one or more lightweight GraphQL subgraph servers that can be federated by the [Hive Router](hive-router.md) or [Hive Gateway](hive-gateway.md).

**[Website](https://the-guild.dev/graphql/yoga-server)** | **[Documentation](https://the-guild.dev/graphql/yoga-server/docs)** | **[GitHub](https://github.com/graphql-hive/graphql-yoga)**

## Ports

Only the **first 5 nodes** (`hive-yoga-server-1` … `hive-yoga-server-5`) get a host port published, on `28162 + (N-1)`. Additional nodes (node 6 and beyond) still run and are reachable from other containers over the Docker network on port `3001`, but have no host port mapped:

| External Port | Internal Port | Description                    |
|:-------------:|:-------------:|--------------------------------|
| 28162         | 3001          | GraphQL endpoint (hive-yoga-server-1) |
| 28163         | 3001          | GraphQL endpoint (hive-yoga-server-2) |
| 28164         | 3001          | GraphQL endpoint (hive-yoga-server-3) |
| 28165         | 3001          | GraphQL endpoint (hive-yoga-server-4) |
| 28166         | 3001          | GraphQL endpoint (hive-yoga-server-5) |

## How to enable?

```bash
platys init --enable-services HIVE_YOGA_SERVER
platys gen
```

```yaml
HIVE_YOGA_SERVER_enable: true
# generate more than one subgraph instance
HIVE_YOGA_SERVER_nodes: 2
```

> **Note:** Only the first 5 nodes (`HIVE_YOGA_SERVER_nodes` 1–5) get their ports mapped to the host (`28162`–`28166`). Nodes 6 and beyond are still started but are only reachable from other containers on the Docker network (port `3001`).

## Configuration

Each node is built from the `Dockerfile` in `init/hive-yoga-server/` (Node.js 22 with the `graphql` and `graphql-yoga` dependencies from `init/hive-yoga-server/package.json`). The GraphQL server implementation is **not** baked into the image — it is mounted at runtime from `scripts/hive-yoga-server/server-<N>.mjs` into the container at `/app/server.mjs`, so you can edit each subgraph independently:

- `scripts/hive-yoga-server/server-1.mjs` → `hive-yoga-server-1`
- `scripts/hive-yoga-server/server-2.mjs` → `hive-yoga-server-2`
- ...

When you set `HIVE_YOGA_SERVER_nodes` to more than 1, add a matching `server-<N>.mjs` for each additional node (copy and adapt `server-1.mjs`). Each node listens on container port `3001` (configurable through the `PORT` environment variable).

## How to use it?

- **GraphQL endpoint (node 1)**: <http://dataplatform:28162/graphql>
- **GraphQL endpoint (node 2)**: <http://dataplatform:28163/graphql>

These subgraphs can be composed into a supergraph and served through the [Hive Router](hive-router.md) or [Hive Gateway](hive-gateway.md).
