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

to access a remote gateway, create an SSH tunnel from your local machine

```bash
ssh -N -L 28401:127.0.0.1:28401 root@187.124.0.29
```




