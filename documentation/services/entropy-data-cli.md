# Entropy Data CLI

Command line interface for Entropy Data.

**[Website](https://entropy-data.com/)** | **[Docker Hub](https://hub.docker.com/r/entropydata/entropy-data-cli)**

## How to enable?

```
platys init --enable-services ENTROPY_DATA_CLI
platys gen
```

## How to use it?

The image's entrypoint is the CLI itself, which would exit immediately. In the platform the entrypoint is overridden so that the container keeps running. Use `docker exec` to run the CLI:

```bash
docker exec -ti entropy-data-cli entropy-data --help
```

The folder configured with `ENTROPY_DATA_CLI_home_dir` (default: the folder of the platform) is mapped to `/home/entropy-data`, which is also the working directory of the container.
