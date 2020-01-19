#!/bin/sh

# WGET the config reference from the URL configured by the CONFIG_URL environment variable
if [ ${CONFIG_URL} ]
then
   wget ${CONFIG_URL} -O /tmp/stack-config.yml
else
   cp /opt/mdps-gen/stack-config.yml /tmp/stack-config.yml
fi

cp -r /opt/mdps-gen/static-data/* /opt/mdps-gen/destination

if [ ${VERBOSE:-0} -eq 1 ]
then
   echo "======================================================================"
   echo "Generating using the following custom stack-config.yml:"
   cat /tmp/stack-config.yml
   echo "======================================================================"
fi

# we asume that the output volume is mapped to /opt/mdps-gen/destination
docker-compose-templer -v -f /opt/mdps-gen/stack-config.yml

# Remove all empty lines
sed -i '/^[[:space:]]*$/d' "/opt/mdps-gen/destination/docker-compose.yml"