# GraphQL Hive Console

GraphQL Hive is an open-source schema registry, observability and governance platform for GraphQL. The self-hosted Console is composed of several micro-services, all prefixed with `hive-console-`.

**[Website](https://the-guild.dev/graphql/hive)** | **[Documentation](https://the-guild.dev/graphql/hive/docs)** | **[GitHub](https://github.com/graphql-hive/console)**

## Services

| Service | Image | Role |
|---------|-------|------|
| `hive-console-migrations` | `storage` | One-off Postgres + ClickHouse migration job |
| `hive-console-server` | `server` | GraphQL API server |
| `hive-console-schema` | `schema` | Schema processing service |
| `hive-console-policy` | `policy` | Schema policy service |
| `hive-console-workflows` | `workflows` | Background workflows |
| `hive-console-usage` | `usage` | Usage ingestion API |
| `hive-console-usage-ingestor` | `usage-ingestor` | Kafka → ClickHouse usage ingestor |
| `hive-console-app` | `app` | Web console (UI) |

## Ports

| External Port | Internal Port | Service |
|:-------------:|:-------------:|---------|
| 28107 | 3000 | `hive-console-app` (Web Console) |
| 28108 | 3001 | `hive-console-server` (GraphQL API) |
| 28109 | 3006 | `hive-console-usage` (Usage API) |

## Dependencies

Hive Console reuses the existing Platys infrastructure services rather than bringing its own. Enable them alongside `HIVE_CONSOLE`:

- **PostgreSQL** (`postgresql`) — metadata storage
- **Redis** (`redis-1`) — caching / pub-sub
- **ClickHouse** (`clickhouse`) — usage analytics
- **Kafka** — usage report transport (topic `usage_reports_v2`)
- **S3** — an S3 service selected via `s3_service_to_use` (MinIO, RustFS, VersityGW, …), with buckets `artifacts` and `audit-logs`

## How to enable?

```bash
platys init --enable-services POSTGRESQL,REDIS,CLICKHOUSE,KAFKA,MINIO,HIVE_CONSOLE
platys gen
```

```yaml
HIVE_CONSOLE_enable: true
POSTGRESQL_enable: true
REDIS_enable: true
CLICKHOUSE_enable: true
KAFKA_enable: true
MINIO_enable: true
```

## How to use it?

- **Web Console**: <http://dataplatform:28107>
- **GraphQL API**: <http://dataplatform:28108/graphql>
- **Usage API**: <http://dataplatform:28109>

> **Note:** The default secrets (`HIVE_CONSOLE_encryption_secret`, SuperTokens keys, CDN key) are for local testing only — change them for any shared or production deployment. The S3 buckets `artifacts` and `audit-logs` must exist (create them via your S3 service's bucket configuration), and Hive relies on the Kafka topic `usage_reports_v2`.
