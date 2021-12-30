jinja2 /templates/services.md.j2 /variables/docker-compose.yml --format=yaml --outfile /output/services.md
jinja2 /templates/index.md.j2 /variables/config.yml --format=yaml --outfile /output/index.md

cd /output
find . -name "*.md" -exec sed -i 's/dataplatform:/'"$PUBLIC_IP"':/g' {} \;