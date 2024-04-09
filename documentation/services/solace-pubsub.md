# Solace PubSub+

PubSub+ event brokers power an event mesh, a modern messaging layer that can be deployed across every environment and component of the distributed enterprise, to stream events across them all.

**[Website](https://solace.com/)** | **[Documentation](https://docs.solace.com)** | **[GitHub](https://github.com/SolaceLabs/solace-single-docker-compose)**

## How to enable?

```
platys init --enable-services SOLACE_PUBSUB
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28358>.

Login with username `admin	` and password `abc123!`.

### Using the CLI

```bash
docker exec -it solace /usr/sw/loads/currentload/bin/cli -A
```
