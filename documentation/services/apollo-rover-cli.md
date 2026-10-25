# Apollo Rover CLI

Rover is the command-line interface for Apollo GraphOS. In the Platys platform it runs as a long-lived utility container with the configured plugins installed, so you can, for example, compose a supergraph from your subgraphs (see [Hive Yoga](hive-yoga-server.md), [Hive Router](hive-router.md)).

**[Website](https://www.apollographql.com/docs/rover)** | **[Documentation](https://www.apollographql.com/docs/rover)** | **[GitHub](https://github.com/apollographql/rover)**

## Ports

The container does not expose any ports.

## How to enable?

```bash
platys init --enable-services APOLLO_ROVER_CLI
platys gen
```

```yaml
APOLLO_ROVER_CLI_enable: true
# comma-separated list of rover plugins to install on container start (empty: none)
APOLLO_ROVER_CLI_plugins: supergraph@2,subgraph@2
# log level of rover (error, warn, info, debug, trace); empty: APOLLO_LOG_LEVEL is not set
APOLLO_ROVER_CLI_log_level: debug
```

## Configuration

If empty (the default), no plugin is installed. On start, the container runs one `rover plugin install <plugin>` for each entry of `APOLLO_ROVER_CLI_plugins` and then idles. With `APOLLO_ROVER_CLI_plugins: supergraph@2,subgraph@2` the entrypoint becomes:

```bash
rover plugin install supergraph@2 && rover plugin install subgraph@2 && exec sleep infinity
```

The Elastic License v2 is accepted through `APOLLO_ELV2_LICENSE: accept`. The platform folder is mounted at `/workspace` (the working directory).

## How to use it?

```bash
docker exec apollo-rover-cli rover supergraph compose --config custom-conf/hive-router/supergraph.yaml
```
