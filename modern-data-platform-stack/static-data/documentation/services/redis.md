# Redis

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, Streams, HyperLogLogs, Bitmaps. 

**[Website](https://redis.io/)** | **[Documentation](https://redis.io/documentation)** | **[GitHub](https://github.com/redis/redis)**

## How to enable?

```
platys init --enable-services REDIS
platys gen
```

## How to use it?

To connect to Redis over the Redis-CLI, use

```
docker exec -ti redis-1 redis-cli
```