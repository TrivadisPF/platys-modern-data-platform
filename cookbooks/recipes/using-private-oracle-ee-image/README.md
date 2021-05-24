---
technoglogies:      oracle,rdbms
version:				1.12.0
validated-at:			17.5.2021
---

# Using Private (Trivadis) Oracle EE Docker image

This recipe will show how to use the private docker image for Oracle EE provided by the Docker Hub Trivadis organization. It will only work if you have access to the Trivadis organization or if you provide your own image.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services ORACLE -s trivadis/platys-modern-data-platform -w 1.12.0
```

Edit the `config.yml` and add the following configuration settings:

```
      ORACLE_edition: 'ee'
```

If you want to change the password of the `SYS` and `SYSTEM` user, add the following line

```
      ORACLE_password: '<your password>'
```

Add the following configuration, if you want the data to be volume mapped to the docker host:

```
      ORACLE_volume_map_data: true
```

Add the following configuration, if you want Oracle to setup a pluggable container database:

```
      ORACLE_container_enable: true
```

If you want to use your own version of the Oracle image, you can overwrite the repository name through the `private_docker_repository_name` property right at the top of the `config.yml`:

```
	  private_docker_repository_name: 'trivadis'
```

Now generate the platform 

```
platys gen
```

Before you can start the platform, you have to login to Docker with a user which is priviledged for the `Trivadis` organization:

```
docker login
```

Enter the user and password and then start the platform: 

```
docker-compose up -d
```

## Connect to Oracle

First connect to the docker instance

```
docker exec -ti oracledb bash
```

Now run SQL Plus to connect as user `sys` to the PDB (change the default password if you have configured another one above).

```
sqlplus sys/EAo4KsTfRR as SYSDBA
```

