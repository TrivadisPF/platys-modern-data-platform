# Redis Stack

A Redis server with additional database capabilities powered by Redis modules. 

**[Website](https://redis.io/)** | **[Documentation](https://redis.io/docs/about/about-stack/)** | **[GitHub](https://github.com/redis-stack/redis-stack)**

## How to enable?

```
platys init --enable-services REDIS_STACK
platys gen
```

## How to use it?

To connect to Redis Stack over the Redis-CLI, use

```
docker exec -ti redis-stack-1 redis-cli
```