# Parquet Tools CLI

pache Parquet is an open source, column-oriented data file format designed for efficient data storage and retrieval. It provides efficient data compression and encoding schemes with enhanced performance to handle complex data in bulk. Parquet is available in multiple languages including Java, C++, Python, etc...

**[Website](https://parquet.apache.org/)** | **[Documentation](https://parquet.apache.org/docs/)** | **[GitHub](https://github.com/apache/parquet-mr/)**

## How to enable?

```
platys init --enable-services PARQUET_TOOLS
platys gen
```

## How to use it?

To use the parquet tool, once it is generated, just use the `docker exec` command:

```bash
docker compose run --rm parquet-tools <command>
```