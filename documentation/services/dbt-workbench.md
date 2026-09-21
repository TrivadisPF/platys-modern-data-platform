# dbt Workbench

dbt Workbench is a web-based IDE for dbt projects. It provides a browser-based interface for editing dbt models, running queries, browsing documentation, and managing artifacts.

**[GitHub](https://github.com/rezer-bleede/dbt-Workbench)**

## How to enable?

```
platys init --enable-services DBT_WORKBENCH,POSTGRESQL
platys gen
```

Or in `config.yml`:

```yaml
      POSTGRESQL_enable: true
      DBT_WORKBENCH_enable: true
```

## How to use it?

Navigate to <http://dataplatform:28497> to access the dbt Workbench UI.

The backend REST API is available at <http://dataplatform:28496>.

### Configuration

By default the service connects to the platys PostgreSQL instance. You can customise the database credentials:

```yaml
      DBT_WORKBENCH_enable: true
      DBT_WORKBENCH_db_user: dbt_workbench
      DBT_WORKBENCH_db_password: mysecretpassword
      DBT_WORKBENCH_db_name: dbt_workbench
```

### AI features

AI assistance is disabled by default. To enable it:

```yaml
      DBT_WORKBENCH_ai_enabled: true
```

> **Note:** AI features require an OpenAI-compatible API key to be configured in the application settings after startup.

### Persistent data

dbt project files and artifacts are stored in `./container-volume/dbt-workbench/data/` on the host, so they survive container restarts.
