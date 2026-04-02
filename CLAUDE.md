# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**platys-modern-data-platform** is a [Platys](https://github.com/TrivadisPF/platys) platform stack that generates Docker Compose configurations for modern data platforms. Users enable desired services in a `config.yml` file, then run `platys gen` to produce a fully-configured `docker-compose.yml`.

Current version: **1.20.0** (develop branch tracking 1.20.0)

## How the Generator Works

The core workflow:

1. User runs `platys init` to create a `config.yml` in their project directory
2. User edits `config.yml` to enable services (e.g., `KAFKA_enable: true`)
3. User runs `platys gen` — Platys pulls the generator Docker image and mounts the project directory
4. The generator container runs `generate.sh`, which:
   - Calls `docker-compose-templer` to process `stack-config.yml` (which references `templates/docker-compose.yml.j2`)
   - Runs Jinja2 to generate `README.md`, `.env-password`, and `copy-static-data.sh`
   - Executes `copy-static-data.sh` to copy relevant static files to the output directory
5. User runs `docker compose up -d` in their project directory

## Repository Structure

```
modern-data-platform-stack/
├── generator-config/
│   ├── stack-config.yml          # Master list of all service versions and vars
│   └── templates/
│       └── docker-compose.yml.j2 # ~33K line Jinja2 template (the core artifact)
├── static-data/
│   ├── conf/                     # Service config files (nginx, kafka, spark, etc.)
│   ├── init/                     # DB/service initialization scripts
│   ├── bin/                      # Utility scripts (nifi-api.sh, lakefs-api.sh, passwd.sh)
│   ├── scripts/                  # Container helper scripts
│   ├── security/                 # SSL/TLS/Kerberos configs
│   └── container-volume/         # Pre-seeded volume data
├── generate.sh                   # Entrypoint script inside the generator container
├── copy-static-data.j2           # Template generating the static file copy script
├── dotenv-passsword.j2           # Template generating .env-password
└── README.md.j2                  # Template for generated platform README
Dockerfile                        # Builds the generator image (python:3.10.13-alpine3.18)
documentation/                    # User-facing docs (getting-started, config reference, etc.)
cookbooks/recipes/                # 85+ example recipes for specific use cases
tutorials/                        # End-to-end tutorial projects
```

## Key Files to Know

- **`modern-data-platform-stack/generator-config/stack-config.yml`** — Defines default versions for all ~100+ services. When adding a new service, register its version variable here.
- **`modern-data-platform-stack/generator-config/templates/docker-compose.yml.j2`** — The main template. All service definitions live here as Jinja2 blocks controlled by `enable` flags from `config.yml`.
- **`modern-data-platform-stack/static-data/`** — Files copied verbatim (or via the copy script template) into user-generated stacks. Organized by service name under `conf/` and `init/`.
- **`documentation/configuration.md`** — ~740KB reference for every configurable parameter. Keep in sync when adding new services/params.
- **`documentation/changes.md`** — Changelog; update when making user-visible changes.

## Adding or Modifying a Service

1. Add version variable(s) to `stack-config.yml` under `vars:`
2. Add the service block to `docker-compose.yml.j2`, gated by `{% if vars.get('SERVICE_enable', False) %}`
3. Add any static config files under `modern-data-platform-stack/static-data/conf/<service>/`
4. Add any init scripts under `modern-data-platform-stack/static-data/init/<service>/`
5. Update `copy-static-data.j2` if the service needs specific files conditionally copied
6. Document the service in `documentation/services/<service>.md` and `documentation/configuration.md`
7. Add a port entry to `documentation/port-mapping.md`

## Building the Generator Docker Image

```bash
docker build -t trivadis/platys-modern-data-platform:latest .
```

The image is tagged as `trivadis/platys-modern-data-platform:<version>` for releases.

## Testing Changes Locally

To test the generator with a local config:

```bash
# Mount your config.yml at /tmp/config.yml and output to ./destination
docker run --rm \
  -v $(pwd)/config.yml:/tmp/config.yml \
  -v $(pwd)/destination:/opt/mdps-gen/destination \
  trivadis/platys-modern-data-platform:latest
```

Or use the Platys CLI with `--stack-image-type local` to point at a locally built image.

## Template Conventions in `docker-compose.yml.j2`

- Service enable flags follow the pattern `SERVICE_enable` (e.g., `KAFKA_enable`, `SPARK_enable`)
- Version vars follow `SERVICE_version` (e.g., `KAFKA_version`, `SPARK_version`)
- Dependencies between services are handled inside the template (e.g., enabling Kafka implicitly enables Zookeeper when not using KRaft)
- Environment variables passed to containers often reference `${DOCKER_HOST_IP}` and `${PUBLIC_IP}` from the user's `.env` file

## Branch Strategy

- **`develop`** — active development branch
- **`master`** — stable release branch; PRs should target `master` for releases
