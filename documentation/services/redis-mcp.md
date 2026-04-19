# Redis MCP Server 

The official Redis MCP Server is a natural language interface designed for agentic applications to manage and search data in Redis efficiently.

Because remote servers are not yet supported, redis mcp server is wrapped inside a [Supergateway](https://github.com/supercorp-ai/supergateway) instance.

 **[Documentation](https://github.com/redis/mcp-redis)** | **[GitHub](https://github.com/redis/mcp-redis)**

## How to enable?

```
platys init --enable-services REDIS, REDIS_MCP
platys gen
```

## How to use it?

Configure  to <http://dataplatform:28225/sse> if transport configuration setting is left to default.