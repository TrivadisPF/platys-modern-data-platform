---
technologies:       lakefs,minio
version:				1.16.0
validated-at:			26.5.2023
---

# Using LakeFS with Minio

This recipe will show how to use LakeFS with Minio. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
export DATAPLATFORM_HOME=${PWD}
platys init --enable-services PROVISIONING_DATA,LAKEFS,MINIO,AWSCLI -s trivadis/platys-modern-data-platform -w 1.16.0
```

Edit the `config.yml` 




Save the file and generate and start the data platform.

```bash
platys gen
docker-compose up -d
```

## Prepare the data

```bash
docker exec -ti awscli aws --endpoint-url=http://lakefs:8000 s3 cp /data-transfer/flight-data/airports.csv s3://flight-bucket/main/
```

```bash
docker exec -ti awscli aws --endpoint-url=http://lakefs:8000 s3 cp /data-transfer/flight-data/carriers.csv s3://flight-bucket/main/
```

```bash
docker exec -ti awscli aws --endpoint-url=http://lakefs:8000 s3 ls s3://flight-bucket/main/
```


```bash
docker exec -ti lakectl lakectl branch list lakefs://flight-bucket
```

## Use the Platform




1. Open lakeFS’s web interface at <http://dataplatform:28220/> and login with username `V42FCGRVMK24JJ8DHUYG` and password `bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza` (if left to defaults). 

You’ll notice that there aren’t any repositories created yet. Click the Create Sample Repository button.

```bash
docker exec -ti lakectl \
    lakectl branch create \
	    lakefs://flight-bucket/experiment \
		--source lakefs://flight-bucket/main
```


```bash
docker exec -ti awscli aws --endpoint-url=http://lakefs:8000 s3 cp /data-transfer/readme.txt s3://example/main/
```

docker exec lakectl \
    lakectl commit lakefs://flight-data/main \
 -m "Create inital dataset of airports"    