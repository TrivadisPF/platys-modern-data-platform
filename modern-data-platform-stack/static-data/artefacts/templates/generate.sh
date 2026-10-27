#!/usr/bin/env sh

if [ -f "/variables/docker-compose.override.yml" ]; then
  if yq --version 2>&1 | grep -qi mikefarah; then
    # Go yq (mikefarah)
    yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' /variables/docker-compose.yml /variables/docker-compose.override.yml > /tmp/docker-compose.yml
  else
    # Python yq (jq wrapper)
    yq -y -s '.[0] * .[1]' /variables/docker-compose.yml /variables/docker-compose.override.yml > /tmp/docker-compose.yml
  fi
  # fall back to the plain compose file if the merge produced nothing usable
  if ! grep -q '^services:' /tmp/docker-compose.yml; then
    cp /variables/docker-compose.yml /tmp/docker-compose.yml
  fi
else
  cp /variables/docker-compose.yml /tmp/docker-compose.yml
fi

jinja2 /templates/services-v1.md.j2 /tmp/docker-compose.yml --format=yaml --outfile /output/services-v1.md
jinja2 /templates/services-v2.md.j2 /tmp/docker-compose.yml --format=yaml --outfile /output/services-v2.md
jinja2 /templates/index.md.j2 /tmp/docker-compose.yml --format=yaml --outfile /output/index.md

# in all .md files, replace dataplatform: by the environment variable
cd /output

if [ ${USE_PUBLIC_IP:-True} == "True" ]
then
	find . -name "*.md" -exec sed -i 's/dataplatform:/'"$PUBLIC_IP"':/g' {} \;
else
	find . -name "*.md" -exec sed -i 's/dataplatform:/'"$DOCKER_HOST_IP"':/g' {} \;
fi	

# move data folders from cookbooks
if [ ${PLATYS_COPY_COOKBOOK_DATA:-True} == "True" ]
then
	find  cookbooks/recipes  -type  d  -name  "data" -exec cp -r -i {} /data-transfer/cookbook-data \;
fi	