#
# This image assumes that either a config.yml file is located in /tmp/config.yml by either copying it to this location (when deriving from this image) or through a
# volume mapping (automatically done when using gen with the --config-filename flag).
# When the CONFIG_URL environment is set, then the URL is used to download a config.yml file and the content is placed in /tmp/config.yml.
#
# The DEL_EMPTY_LINES environment variable, when set, causes empty lines to be removed.
# The VERBOSE environment variable, when set, switches to a more verbose output.
#
FROM python:3.8.0-alpine3.10

# upgrade pip
RUN python3 -m pip install --upgrade pip

# install docker-compose-templer
RUN pip install docker-compose-templer && mkdir /opt/mdps-gen && chmod 777 -R /opt/mdps-gen

# Install timezone and jq support
RUN apk add tzdata &&  apk add jq

# Install yq
RUN wget -q -O /usr/bin/yq $(wget -q -O - https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets[] | select(.name == "yq_linux_amd64") | .browser_download_url') &&  chmod +x /usr/bin/yq

# copy generator config into the image (templates & config.yml)
COPY ./modern-data-platform-stack/generator-config /opt/mdps-gen

# copy static data needed for the stack to run into the image
COPY ./modern-data-platform-stack/static-data /opt/mdps-gen/static-data

# copy documentation folder, cookbooks and README
COPY ./documentation /opt/mdps-gen/static-data/doc/documentation
COPY ./cookbooks /opt/mdps-gen/static-data/doc/cookbooks
COPY ./README.md /opt/mdps-gen/static-data/doc

# copy remove all .md extensions in links inside *.md files, as for the markdown viewer used the links only work without the extensions
WORKDIR /opt/mdps-gen/static-data/doc
RUN find . -name "*.md" -exec sed -i 's/.md)/)/g' {} \;
RUN find . -name "*.md" -exec sed -i 's/dataplatform:/$PUBLIC_IP:/g' {} \;

# copy the generator script and make it executable
COPY ./modern-data-platform-stack/generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate.sh

# ================ Jinja2 (currently not used) =========================== #
# Create folders
RUN mkdir /templates/
RUN mkdir /variables/

# Set needed env vars
ENV SCRIPTS_DIR /scripts
ENV TEMPLATES_DIR /templates

# Currently not used
#RUN pip3 install jinja2-cli[yaml,toml,xml]==0.7.0

# we assume that the output volume is mapped to /opt/analytics-generator/stacks
CMD generate.sh
