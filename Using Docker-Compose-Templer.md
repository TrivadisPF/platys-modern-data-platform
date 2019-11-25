# Using Docker-Compose-Templer

<https://pypi.org/project/Docker-Compose-Templer/>

```
cd /mnt/hgfs/git/trivadisBDS/modern-data-analytics-stack/full-stack-variable/docker
```

```
docker run -ti -v${PWD}:/data trivadis/docker-compose-templer bash
```

```
docker-compose-templer -f -v stack-config.yml
```