# Valkey

A flexible distributed key-value datastore that is optimized for caching and other realtime workloads. 

**Note:** This project was forked from the open source Redis project right before the transition to their new source available licenses.

**[Website](https://valkey.io/)** | **[Documentation](https://valkey.io/docs/)** | **[GitHub](https://github.com/valkey-io/valkey)**

## How to enable?

```
platys init --enable-services VALKEY
platys gen
```

## How to use it?

To connect to Keyval over the Valkey-CLI, use

```
docker exec -ti valkey-1 valkey-cli
```