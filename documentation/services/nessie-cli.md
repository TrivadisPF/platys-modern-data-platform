# Nessie CLI

Transactional Catalog for Data Lakes with Git-like semantics. This container runs the Nessie CLI.

**[Website](https://projectnessie.org/)** | **[Documentation](https://projectnessie.org/features/)** | **[GitHub](https://github.com/projectnessie/nessie)**

## How to enable?

```
platys init --enable-services NESSIE_CLI
platys gen
```

## How to use it?

The container starts the CLI already connected to Nessie. Attach to it interactively:

```bash
docker attach nessie-cli
```
