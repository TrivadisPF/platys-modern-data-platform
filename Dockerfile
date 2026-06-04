#
# This image assumes that either a config.yml file is located in /tmp/config.yml by either copying it to this location (when deriving from this image) or through a
# volume mapping (automatically done when using gen with the --config-filename flag).
# When the CONFIG_URL environment is set, then the URL is used to download a config.yml file and the content is placed in /tmp/config.yml.
#
# The DEL_EMPTY_LINES environment variable, when set, causes empty lines to be removed.
# The VERBOSE environment variable, when set, switches to a more verbose output.
#
FROM python:3.10.13-alpine3.18 AS builder

# Build C extension in isolation so gcc/musl-dev/python3-dev don't end up in the final image.
# --prefix=/install keeps all installed files under one path for easy COPY.
RUN apk add --no-cache gcc musl-dev python3-dev && \
    pip install --no-cache-dir --prefix=/install \
        ruamel.yaml.clib \
        docker-compose-templer \
        pwgen \
        jinja2-cli \
        pyyaml

# --- final stage ---
FROM python:3.10.13-alpine3.18

COPY --from=builder /install /usr/local

RUN apk add --no-cache tzdata jq yq && \
    mkdir -p /opt/mdps-gen && chmod 777 -R /opt/mdps-gen && \
    mkdir /templates && \
    mkdir /variables

# copy generator config into the image (templates & config.yml)
COPY ./modern-data-platform-stack/generator-config /opt/mdps-gen

# copy static data needed for the stack to run into the image
COPY ./modern-data-platform-stack/static-data /opt/mdps-gen/static-data

# copy documentation folder, cookbooks and README
COPY ./documentation /opt/mdps-gen/static-data/artefacts/documentation
COPY ./cookbooks /opt/mdps-gen/static-data/artefacts/cookbooks
COPY ./tutorials /opt/mdps-gen/static-data/artefacts/tutorials
COPY ./README.md /opt/mdps-gen/static-data/artefacts
COPY ./modern-data-platform-stack/*.j2 /opt/mdps-gen/

# remove all .md extensions in links inside *.md files, as the markdown viewer only works without extensions
WORKDIR /opt/mdps-gen/static-data/artefacts
RUN find . -name "*.md" -exec sed -i 's/.md)/)/g' {} \;

# copy the generator script and make it executable
COPY ./modern-data-platform-stack/generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate.sh

# Set needed env vars
ENV SCRIPTS_DIR=/scripts
ENV TEMPLATES_DIR=/templates

CMD generate.sh
