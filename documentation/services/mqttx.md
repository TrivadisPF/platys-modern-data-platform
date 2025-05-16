# MQTTX

A Powerful and All-in-One MQTT 5.0 client toolbox for Desktop, CLI and WebSocket. 

**[Website](https://mqttx.app/)** | **[Documentation](https://mqttx.app/docs)** | **[GitHub](https://github.com/emqx/MQTTX)**

## How to enable?

```
platys init --enable-services MQTTX_CLI MQTTX_WEB
platys gen
```

## How to use it?

### Web

Navigate to <http://dataplatform:28367>.

### CLI

```bash
docker exec -ti mqttx-cli mqttx
```

## Using Simulator

list the built-in scenarios

```bash
docker exec -ti mqttx-cli mqttx ls --scenarios
```

run the `smart_home` scenario

```bash
docker exec -ti mqttx-cli mqttx simulate -sc smart_home -c 100 conn  -h 'mosquitto-1' -p 1883
```