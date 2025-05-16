# Arroyo

Distributed stream processing engine in Rust.

**[Website](https://www.arroyo.dev/)** | **[Documentation](https://doc.arroyo.dev/introduction)** | **[GitHub](https://github.com/ArroyoSystems/arroyo)**

## How to enable?

```
platys init --enable-services ARROYO
platys gen
```

## How to use it?

Navigate to <http://dataplatform:5115>.

### Using the CLI

```bash
docker exec -ti arroyo ./arroyo
```

```bash
~/w/platys-demo-platform> docker exec -ti arroyo ./arroyo
Usage: arroyo [OPTIONS] <COMMAND>

Commands:
  run         Run a query as a local pipeline cluster
  api         Starts an Arroyo API server
  controller  Starts an Arroyo Controller
  cluster     Starts a complete Arroyo cluster
  worker      Starts an Arroyo worker
  compiler    Starts an Arroyo compiler server
  node        Starts an Arroyo node server
  migrate     Runs database migrations on the configured Postgres database
  visualize   Visualizes a query plan
  help        Print this message or the help of the given subcommand(s)

Options:
  -c, --config <CONFIG>          Path to an Arroyo config file, in TOML or YAML format
      --config-dir <CONFIG_DIR>  Directory in which to look for configuration files
  -h, --help                     Print help
  -V, --version                  Print version
```  
