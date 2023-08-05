# HStreamDB

HStreamDB is an open-source, cloud-native streaming database for IoT and beyond. Modernize your data stack for real-time applications. 

**[Website](https://hstream.io/)** | **[Documentation](https://docs.hstream.io/)** | **[GitHub](https://github.com/hstreamdb/hstream)**

## How to enable?

```bash
platys init --enable-services ZOOKEEPER, HSTREAMDB
platys gen
```

## How to use it?

Connect to the CLI

```
docker run -it --rm --name some-hstream-cli --network host hstreamdb/hstream:latest hstream --port 6570 sql
```