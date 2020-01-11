#!/bin/sh

cp -r /opt/static-data/* /opt/analytics-generator/stacks

# we asume that the output volume is mapped to /opt/analytics-generator/stacks
docker-compose-templer -v -f /opt/analytics-generator/stack-config.yml

# Remove all empty lines
sed -i '/^[[:space:]]*$/d' "/opt/analytics-generator/stacks/docker-compose.yml"