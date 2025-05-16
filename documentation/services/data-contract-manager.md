# Data Contract Manager

Data Contract Manager (Community Edition).

**[Website](https://www.datacontract-manager.com/)** | **[Documentation](https://docs.datacontract-manager.com/)** | **[GitHub](https://github.com/datacontract-manager)**

## How to enable?

```bash
platys init --enable-services DATA_CONTRACT_MANAGER MAILHOG
```

Add the following settings to `config.yml`

```
POSTGRESQL_extension: 'pgvector'
```

Now you can generate and use the platform

```bash
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28382>.
