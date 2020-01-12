#!/bin/sh

# WGET the config reference from the URL configured by the CONFIG_URL environment variable
if [ ${CONFIG_URL} ]
then 
   wget ${CONFIG_URL} -O /tmp/refbased-stack-config.yml
   cp /tmp/refbased-stack-config.yml /tmp/custom-values.yml
else
   cp /tmp/filebased-stack-config.yml /tmp/custom-values.yml
fi

cp -r /opt/static-data/* /opt/mdps-generator/stacks

if [ ${DEBUG:-0} -eq 1 ]
then
   echo "======================================================================"
   echo "Generating using the following config.yml:"
   cat /tmp/custom-values.yml
   echo "======================================================================"
fi

# we asume that the output volume is mapped to /opt/analytics-generator/stacks
docker-compose-templer -v -f /opt/mdps-generator/stack-config.yml

# Remove all empty lines
sed -i '/^[[:space:]]*$/d' "/opt/mdps-generator/stacks/docker-compose.yml"