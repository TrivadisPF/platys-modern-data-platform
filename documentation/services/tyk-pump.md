# Tyk Pump

Traffic analytics are captured by the Tyk Gateway nodes and then temporarily stored in Redis. The Tyk Pump is responsible for moving those analytics into a persistent data store, such as MongoDB, where the traffic can be analysed.

**[Website](https://tyk.io/open-source-api-gateway/)** | **[Documentation](https://tyk.io/docs/tyk-pump/)** | **[GitHub](https://github.com/TykTechnologies/tyk-pump)**

## How to enable?

```
platys init --enable-services TYK,TYK_PUMP
platys gen
```

## How to use it?

