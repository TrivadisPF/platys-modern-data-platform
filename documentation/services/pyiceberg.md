# Pyiceberg

PyIceberg is a Python implementation for accessing Iceberg tables, without the need of a JVM. It also comes with a CLI which is exposed by this service.

**[Website](https://py.iceberg.apache.org/)** | **[Documentation](https://py.iceberg.apache.org/)**

## How to enable?

```bash
platys init --enable-services PYICEBERG
platys gen
```

## How to use it?

Execute the cli 

```bash
docker  exec pyiceberg pyiceberg
```