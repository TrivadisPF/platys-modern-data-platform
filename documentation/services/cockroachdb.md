# CockroachDB

CockroachDB is a cloud-native distributed SQL database built for high availability, horizontal scalability, and strong consistency. It is wire-compatible with PostgreSQL.

**[Website](https://www.cockroachlabs.com/)** | **[Documentation](https://www.cockroachlabs.com/docs/)** | **[GitHub](https://github.com/cockroachdb/cockroach)**

## How to enable?

```
platys init --enable-services COCKROACHDB
platys gen
```

## How to use it?

Connect using any PostgreSQL-compatible client on port `26257`:

```bash
docker exec -it cockroachdb-1 ./cockroach sql --insecure
```

Or connect via `psql`:

```bash
psql -h dataplatform -p 26257 -U root defaultdb
```

Navigate to <http://dataplatform:28080> to access the CockroachDB Admin UI.
