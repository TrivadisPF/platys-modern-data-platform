# Materialize CLI

Materialize simplifies application development with streaming data. This container runs the `mzcli` command-line client for connecting to Materialize.

**[Website](https://materialize.com/)** | **[Documentation](https://materialize.com/docs/)** | **[GitHub](https://github.com/MaterializeInc/materialize)**

## How to enable?

```
platys init --enable-services MATERIALIZE_CLI
platys gen
```

## How to use it?

```bash
docker exec -ti mzcli mzcli -h materialize-1
```
