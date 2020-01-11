#!/bin/sh

# WGET the config reference from the URL configured by the CONFIG_REF environment variable
if [ ${CONFIG_REF} ]
then 
   wget ${CONFIG_REF} -O /tmp/refbased-custom-values.yml
   cp /tmp/refbased-custom-values.yml /tmp/custom-values.yml
else
   cp /tmp/filebased-custom-values.yml /tmp/custom-values.yml
fi

cp -r /opt/static-data/* /opt/analytics-generator/stacks

if [ ${DEBUG:-0} -eq 1 ]
then
   echo "======================================================================"
   echo "Generating using the following config.yml:"
   cat /tmp/custom-values.yml
   echo "======================================================================"
fi

# we asume that the output volume is mapped to /opt/analytics-generator/stacks
docker-compose-templer -v -f /opt/analytics-generator/stack-config.yml

# Remove all empty lines
sed -i '/^[[:space:]]*$/d' "/opt/analytics-generator/stacks/docker-compose.yml"