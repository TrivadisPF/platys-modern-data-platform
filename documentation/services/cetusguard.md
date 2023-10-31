# Cetusguard

CetusGuard is a tool that protects the Docker daemon socket by filtering calls to its API endpoints. 

**[Documentation](https://github.com/hectorm/cetusguard)** | **[GitHub](https://github.com/hectorm/cetusguard)**

## How to enable?

```
platys init --enable-services CETUSGUARD
platys gen
```

## How to use it?

Use `tcp://cetusguard:2376` for the Docker URL instead of `unix://var/run/docker.sock`.

