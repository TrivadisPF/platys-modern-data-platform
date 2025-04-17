#!/bin/sh

# we assume that the output volume is mapped to /opt/mdps-gen/destination

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

if [ ${DEL_EMPTY_LINES:-0} -eq 1 ]
then
  # Remove all empty lines
  sed -i '/^[[:space:]]*$/d' "/opt/mdps-gen/destination/docker-compose.yml"
fi

# Setting Timezone, if needed
TIMEZONE=`yq e '.use_timezone' /tmp/config.yml`

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

# Generate the README file for the generated platform
jinja2 /opt/mdps-gen/README.md.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /opt/mdps-gen/destination/README.md

# Generate the password template file
jinja2 /opt/mdps-gen/dotenv-passsword.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /opt/mdps-gen/destination/.env-password
#cat /opt/mdps-gen/destination/.env-password > /opt/mdps-gen/destination/.env-password

# Generate the copy-static-data.sh file for the generated platform
jinja2 /opt/mdps-gen/copy-static-data.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /opt/mdps-gen/destination/copy-static-data.sh

# Copy the static data to the generated platform
chmod +x /opt/mdps-gen/destination/copy-static-data.sh
/opt/mdps-gen/destination/copy-static-data.sh

#cp -r /opt/mdps-gen/static-data/* /opt/mdps-gen/destination

# Create a .gitignore and add the .env to it, if it does not yet exists
grep -qxF '.env' /opt/mdps-gen/destination/.gitignore || echo '.env' >> /opt/mdps-gen/destination/.gitignore

