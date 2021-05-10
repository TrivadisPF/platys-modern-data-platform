---
technoglogies:      oracle,rdbms
version:				1.12.0
validated-at:			10.5.2021
---

# Using Public Oracle XE Docker image

This recipe will show how to use a public docker image for Oracle XE. This is instead of the "normal" way of refering to a private repository for the Oracle database docker images, due to licensing requirements by Oracle. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services ORACLE -s trivadis/platys-modern-data-platform -w 1.12.0
```

Edit the `config.yml` and add the following configuration settings.

```
      ORACLE_edition: 'xe'
      ORACLE_xe_docker_image: 'quillbuilduser/oracle-18-xe'
      ORACLE_XE_version: latest
```

We are using the following docker image [quillbuilduser/oracle-18-xe](https://github.com/deusaquilus/docker-oracle-xe).

Now generate and start the data platform. 

```
platys gen

docker-compose up -d
```

## Connect to Oracle

First connect to the docker instance

```
docker exec -ti oracledb bash
```

and run SQL Plus to connect as user `sys` to the PDB.

```
/opt/oracle/product/18c/dbhomeXE/bin/sqlplus sys/Oracle18@oracledb:1521/XEPDB1 as sysdba
```

