# Kong decK

decK helps manage Kong’s configuration in a declarative fashion. This means that a developer can define the desired state of Kong Gateway or Konnect – services, routes, plugins, and more – and let decK handle implementation without needing to execute each step manually, as you would with the Kong Admin API.

**[Website](https://konghq.com/products/api-gateway-platform)** | **[Documentation](https://docs.konghq.com/deck/latest/)** | **[GitHub](https://github.com/kong/deck/)**

## How to enable?

```
platys init --enable-services KONG KONG_DECK
platys gen
```

## How to use it?

```bash
docker exec -ti kong-deck deck
```