# PostGraphile

PostGraphile builds a powerful, extensible and performant GraphQL API from a PostgreSQL schema in seconds, serving both the GraphQL API and the GraphiQL IDE over HTTP.

**[Website](https://www.graphile.org/postgraphile/)** | **[Documentation](https://www.graphile.org/postgraphile/introduction/)** | **[GitHub](https://github.com/graphile/postgraphile)**

## Ports

| External Port | Internal Port | Description                 |
|:-------------:|:-------------:|-----------------------------|
| 28151         | 5000          | GraphQL API / GraphiQL IDE  |

## How to enable?

PostGraphile needs a PostgreSQL database, so enable it together with the `POSTGRESQL` service (or point it at an external one):

```bash
platys init --enable-services POSTGRESQL,POSTGRAPHILE
platys gen
```

```yaml
POSTGRAPHILE_enable: true
POSTGRAPHILE_postgres_database: postgres
POSTGRAPHILE_schema: public
```

## How to use it?

- **GraphiQL IDE**: <http://dataplatform:28151/graphiql>
- **GraphQL API**: <http://dataplatform:28151/graphql>

By default the service connects to the built-in `postgresql` service and exposes the `public` schema, with `--watch`, `--enhance-graphiql`, and `--dynamic-json` enabled. Adjust the `POSTGRAPHILE_*` parameters to change the target database, schema, or feature flags.
