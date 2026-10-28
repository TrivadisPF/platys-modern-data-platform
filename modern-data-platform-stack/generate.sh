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

# Remove service-level "volumes:" keys that ended up without any entries (e.g. if volume_map_data_transfer_folder is false),
# as docker compose rejects an empty volumes key
awk '
function flush(   i) { for (i = 1; i <= n; i++) print buf[i]; n = 0 }
pending {
  if ($0 ~ /^[[:space:]]*$/ || $0 ~ /^[[:space:]]*#/) { buf[++n] = $0; next }
  match($0, /^ */)
  if (RLENGTH > 4) print "    volumes:"
  pending = 0
  flush()
}
/^    volumes:[[:space:]]*$/ { pending = 1; n = 0; next }
{ print }
END { if (pending) flush() }
' "/opt/mdps-gen/destination/docker-compose.yml" > /tmp/docker-compose.nonempty-volumes.yml && \
  cp /tmp/docker-compose.nonempty-volumes.yml "/opt/mdps-gen/destination/docker-compose.yml"

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
jinja2 /opt/mdps-gen/copy-static-data.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /tmp/copy-static-data.sh

# Copy the static data to the generated platform
chmod +x /tmp/copy-static-data.sh
/tmp/copy-static-data.sh

#cp -r /opt/mdps-gen/static-data/* /opt/mdps-gen/destination

# Create a .gitignore and add the .env to it, if it does not yet exists
# Ensure the .gitignore file exists
touch /opt/mdps-gen/destination/.gitignore
grep -qxF '.env' /opt/mdps-gen/destination/.gitignore || echo '.env' >> /opt/mdps-gen/destination/.gitignore

