# Cosmo Router

WunderGraph Cosmo Router — a high-performance, open-source GraphQL router for federated graphs.

**[Website](https://cosmo-docs.wundergraph.com/router/intro)** | **[Documentation](https://cosmo-docs.wundergraph.com/router/configuration)** | **[GitHub](https://github.com/wundergraph/cosmo)**

## How to enable?

```
platys init --enable-services COSMO_ROUTER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28495>.

The router requires an execution config file before starting. Place your `config.json` at `./conf/cosmo-router/config.json` in your stack directory. You can generate this file using the Cosmo CLI or from WunderGraph Cosmo Cloud.

```bash
# Example: generate config with the Cosmo CLI
wgc router fetch <graph-name> --namespace default -o config.json
```
