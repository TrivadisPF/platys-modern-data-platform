#!/usr/bin/env sh

jinja2 /templates/services.md.j2 /variables/docker-compose.yml --format=yaml --outfile /output/services.md
jinja2 /templates/index.md.j2 /variables/docker-compose.yml --format=yaml --outfile /output/index.md

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