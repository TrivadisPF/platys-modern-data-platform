# Materialize

Materialize simplifies application development with streaming data. Incrementally-updated materialized views - in PostgreSQL and in real time. Materialize is powered by Timely Dataflow. 

**[Website](https://materialize.com/)** | **[Documentation](https://materialize.com/docs/)** | **[GitHub](https://github.com/MaterializeInc/materialize)**

## How to enable?

```
platys init --enable-services MATERIALIZE
platys gen
```

## How to use it?

You can connect via `mzcli` (enable it using `MATERIALIZE_CLI_enable`)

```bash
docker exec -ti mzcli mzcli -h materialize-1
```


