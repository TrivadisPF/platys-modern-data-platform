# Neon

Neon is a serverless, open-source alternative to AWS Aurora Postgres. It separates storage and compute to offer autoscaling, branching, and scale-to-zero for Postgres databases.

**[Website](https://neon.com)** | **[Documentation](https://neon.com/docs/introduction)**
| **[GitHub](https://github.com/neondatabase/neon)**

## How to enable?

```bash
platys init --enable-services NEON
platys gen
```

## How to use it?

The Postgres wire protocol is exposed on port `55433` of the `compute-1` node, the pageserver HTTP API on `9898`, and the storage broker on `50051`.
