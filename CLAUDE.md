# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**platys-modern-data-platform** is a [Platys](https://github.com/TrivadisPF/platys) platform stack that generates Docker Compose configurations for modern data platforms. Users enable desired services in a `config.yml` file, then run `platys gen` to produce a fully-configured `docker-compose.yml`.

Current version: **1.21.0** (develop branch; new/changed params should use `since: "1.21.0"`)

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
│   ├── vars/
│   │   └── config.yml            # Default enable flags + params for every service (the init template)
│   ├── configuration/
│   │   └── services/<svc>.yml    # Per-service metadata (links, description, param reference)
│   └── templates/
│       └── docker-compose.yml.j2 # ~33K line Jinja2 template (the core artifact)
├── static-data/
│   ├── conf/                     # Generator-shipped/predefined config files (NOT user-edited)
│   ├── custom-conf/              # User-editable config files (supergraphs, pipelines, etc.)
│   ├── init/                     # DB/service init scripts (also used for build contexts / Dockerfiles)
│   ├── bin/                      # Utility scripts (nifi-api.sh, lakefs-api.sh, passwd.sh)
│   ├── scripts/                  # Container helper scripts / mounted service sources
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

- **`modern-data-platform-stack/generator-config/stack-config.yml`** — Defines default versions for all ~100+ services. When adding a new service that pulls an image, register its version variable here.
- **`modern-data-platform-stack/generator-config/vars/config.yml`** — The default `config.yml` users get from `platys init`. Add every new `SERVICE_enable` flag and param (with sensible defaults) here, grouped in a commented `# ===== Service =====` block.
- **`modern-data-platform-stack/generator-config/templates/docker-compose.yml.j2`** — The main template. All service definitions live here as Jinja2 blocks controlled by `enable` flags.
- **`modern-data-platform-stack/generator-config/configuration/services/<service>.yml`** — Per-service metadata (name, links, description, and a `parameters:` reference with `default`/`since`). Add one per new service.
- **`modern-data-platform-stack/static-data/`** — Files copied into user-generated stacks, keyed on the service's `com.platys.name` label. See `conf/` vs `custom-conf/` below.
- **`documentation/configuration.md`** — ~740KB reference for every configurable parameter. Keep in sync when adding new services/params.
- **`documentation/services/<service>.md`** — User-facing per-service doc (ports, how to enable, configuration, usage).
- **`documentation/port-mapping.md`** — Master host→container port table; pick free ports here.
- **`documentation/changes.md`** — Changelog; add new services under "What's new in 1.21.0".

## Adding or Modifying a Service

A new service touches ~7 places (keep them all in sync):

1. **`stack-config.yml`** — add the version var (e.g. `SERVICE_version: '1.2'`) if the service pulls an image. Build-from-Dockerfile services don't need one.
2. **`vars/config.yml`** — add `SERVICE_enable: false` and all params in a `# ===== Service =====` block.
3. **`docker-compose.yml.j2`** — three edits:
   - version-set near the top: `{% set __SERVICE_version = SERVICE_version | default('latest') -%}`
   - default-false guard in the guards block (~line 1140): `{% set SERVICE_enable = false -%}`
   - the service block itself, gated by `{% if SERVICE_enable | default(false) %}` … `{% endif %}   {#  SERVICE_enable #}`, with a `com.platys.name: "<service>"` label.
4. **Static files** — predefined files under `static-data/conf/<service>/`; user-editable files under `static-data/custom-conf/<service>/`; Dockerfiles/build contexts under `static-data/init/<service>/`. Folders are auto-copied by `com.platys.name` — no `copy-static-data.j2` edit needed unless the copy is conditional/special.
5. **`configuration/services/<service>.yml`** — service metadata + `parameters:` with `default` and `since: "1.21.0"`.
6. **`documentation/services/<service>.md`** + **`documentation/configuration.md`** — user docs and the param reference table (`since` = `1.21.0`).
7. **`documentation/port-mapping.md`** — add host port rows (pick free ports), and **`documentation/changes.md`** — list under "New Services".

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
- Version vars follow `SERVICE_version`, resolved once into `__SERVICE_version` via `{% set __SERVICE_version = SERVICE_version | default('latest') -%}` near the top and referenced as `{{__SERVICE_version}}` in the image tag
- Every `SERVICE_enable` gets a default-false guard (`{% set SERVICE_enable = false -%}`) in the guards block so the `{% if %}` never fails when the flag is absent
- Each service block carries a `com.platys.name: "<service>"` label; `copy-static-data.j2` uses it to copy `conf/<name>/`, `custom-conf/<name>/`, `init/<name>/`, `scripts/<name>/`, etc. into the generated stack
- Dependencies between services are handled inside the template (e.g., enabling Kafka implicitly enables Zookeeper when not using KRaft)
- Environment variables passed to containers often reference `${DOCKER_HOST_IP}` and `${PUBLIC_IP}` from the user's `.env` file

### `conf/` vs `custom-conf/`

- **`conf/`** is reserved for predefined config files that ship with / are produced by the generation. Do not put files a user is meant to edit here.
- **`custom-conf/`** is where users edit their own config (supergraph schemas, router/gateway/pipeline configs). When a new service mounts a user-editable config file, place the placeholder under `static-data/custom-conf/<service>/` and mount it from `./custom-conf/<service>/...` in the template.

### `.templ` static files

Static files ending in `.templ` (e.g. `supergraph.graphql.templ`, `server-1.mjs.templ`) are Jinja-rendered during generation and the `.templ` suffix is stripped in the output. Reference the **final** name (without `.templ`) in volume mounts.

### Multi-node services

Services that support N instances use a `SERVICE_nodes` param and a `{% for num in range(SERVICE_nodes | default(1)) %}` loop, emitting `service-{{loop.index}}` containers (see `NEO4J_nodes`, `VECTOR_nodes`, `HIVE_YOGA_SERVER_nodes`). Allocate a contiguous host-port block and compute each node's port from `loop.index` (e.g. `{% set host_port = BASE + (loop.index - 1) %}`).

## Shell note

The dev shell is **fish**, not bash. `for … end` loops and space-split `for x in $var` behave differently — prefer separate commands or explicit tooling over bash-style loops when running shell commands here.

## Branch Strategy

- **`develop`** — active development branch
- **`master`** — stable release branch; PRs should target `master` for releases
