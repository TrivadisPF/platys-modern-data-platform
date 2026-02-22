# OpenClaw

Your own personal AI assistant. Any OS. Any Platform. The lobster way.

**[Website](https://openclaw.ai/)** | **[Documentation](https://docs.openclaw.ai/start/getting-started)** | **[GitHub](https://github.com/openclaw/openclaw)**

## How to enable?

```bash
platys init --enable-services OPENCLAW
platys gen
```

## How to use it?



Navitage to <http://dataplatform:28401?token=<token> and login with username and password specified in the configuration. 

Pass the token using `?token=<token>`.


```
docker exec -it openclaw openclaw devices list

docker exec -it openclaw openclaw devices approve <request-id>
```





