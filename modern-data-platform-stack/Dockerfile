#
# This image assumes that either a config.yml file is located in /tmp/config.yml by either copying it to this location (when deriving from this image) or through a
# volume mapping (automatically done when using gen with the --config-filename flag).
# When the CONFIG_URL environment is set, then the URL is used to download a config.yml file and the content is placed in /tmp/config.yml.
#
# The DEL_EMPTY_LINES environment variable, when set, causes empty lines to be removed.
# The VERBOSE environment variable, when set, switches to a more verbose output.
#
FROM python:3.8.0-alpine3.10

# install docker-compose-templer
RUN pip install docker-compose-templer && mkdir /opt/mdps-gen && chmod 777 -R /opt/mdps-gen

# Install timezone and jq support
RUN apk add tzdata &&  apk add jq

# Install yq 
RUN wget -q -O /usr/bin/yq $(wget -q -O - https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets[] | select(.name == "yq_linux_amd64") | .browser_download_url') &&  chmod +x /usr/bin/yq

# copy generator config into the image (templates & config.yml)
COPY ./generator-config /opt/mdps-gen

# copy static data needed for the stack to run into the image
COPY ./static-data /opt/mdps-gen/static-data

# copy the generator script and make it executable
COPY generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate.sh

# we assume that the output volume is mapped to /opt/analytics-generator/stacks
CMD generate.sh
