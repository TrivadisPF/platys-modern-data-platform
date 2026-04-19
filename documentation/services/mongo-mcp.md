# Mongo MCP Server 

A Model Context Protocol server to connect to MongoDB databases and MongoDB Atlas Clusters.

Because remote servers are not yet supported, redis mcp server is wrapped inside a [Supergateway](https://github.com/supercorp-ai/supergateway) instance.

 **[Documentation](https://github.com/mongodb-js/mongodb-mcp-server)** | **[GitHub](https://github.com/mongodb-js/mongodb-mcp-server)**

## How to enable?

```
platys init --enable-services MONGO, MONGO_MCP
platys gen
```

## How to use it?

Configure  to <http://dataplatform:28403/sse> if transport configuration setting is left to default.