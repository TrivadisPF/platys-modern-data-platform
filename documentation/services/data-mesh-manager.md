# Data Mesh Manager

Data Mesh Manager (Community Edition).

**[Website](https://www.datamesh-manager.com/)** | **[Documentation](https://docs.datamesh-manager.com/)** | **[GitHub](https://github.com/datamesh-manager/datamesh-manager-ce)**

## How to enable?

```bash
platys init --enable-services DATA_MESH_MANAGER MAILHOG
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

Navigate to <http://dataplatform:28381>.
