#!/bin/sh

# WGET the config reference from the URL configured by the CONFIG_URL environment variable
if [ ${CONFIG_URL} ]
then
  if [ ${VERBOSE:-0} -eq 1 ]
  then
     echo "======================================================================"
     echo "CONFIG_URL is set: downloading config.yml from ${CONFIG_URL}"
     echo "======================================================================"
  fi
  wget ${CONFIG_URL} -O /tmp/config.yml
fi

cp -r /opt/mdps-gen/static-data/* /opt/mdps-gen/destination

if [ ${VERBOSE:-0} -eq 1 ]
then
   echo "======================================================================"
   echo "Generating using the following custom stack-config.yml:"
   cat /tmp/config.yml
   echo "======================================================================"

   docker-compose-templer -v -f /opt/mdps-gen/stack-config.yml
   echo "======================================================================"
else
   docker-compose-templer -f /opt/mdps-gen/stack-config.yml
fi

# we asume that the output volume is mapped to /opt/mdps-gen/destination

if [ ${DEL_EMPTY_LINES:-0} -eq 1 ]
then
  # Remove all empty lines
  sed -i '/^[[:space:]]*$/d' "/opt/mdps-gen/destination/docker-compose.yml"
fi

# Setting Timezone, if needed
TIMEZONE=`yq r /tmp/config.yml use_timezone`

if [ ${VERBOSE:-0} -eq 1 ]
then
   echo "======================================================================"
   echo "Using timezone = ${TIMEZONE}"
   echo "======================================================================"
fi

if [ ${TIMEZONE} ]
then
  mkdir -p /opt/mdps-gen/destination/etc
  cp /usr/share/zoneinfo/${TIMEZONE} /opt/mdps-gen/destination/etc/localtime
  echo "${TIMEZONE}" > /opt/mdps-gen/destination/etc/timezone
fi

# Currently not used
#jinja2 /opt/mdps-gen/destination/documentation/templates/services.md.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /opt/mdps-gen/destination/documentation/services.md
