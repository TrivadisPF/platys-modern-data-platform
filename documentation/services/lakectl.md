# LakeFS CLI

Git-like capabilities for your object storage.

**[Website](https://lakefs.io/)** | **[Documentation](https://docs.lakefs.io/reference/commands.html#installing-the-lakectl-command-locally)** | **[GitHub](https://github.com/treeverse/lakeFS)**

## How to enable?

```bash
platys init --enable-services LAKEFS, MINIO, POSTGRESQL
platys gen
```

## How to use it?

```bash
docker exec -ti lakectl lakectl
```

```bash
docker exec -ti lakectl lakectl branch list lakefs://example
```