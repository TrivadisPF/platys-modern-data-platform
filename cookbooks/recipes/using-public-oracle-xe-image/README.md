---
technoglogies:      oracle,rdbms
version:				1.13.0
validated-at:			24.10.2021
---

# Using Public Oracle XE Docker image

This recipe will show how to use a public docker image for Oracle XE. This is instead of the "normal" way of refering to a private repository for the Oracle database docker images, due to licensing requirements by Oracle. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services ORACLE_XE -s trivadis/platys-modern-data-platform -w 1.13.0
```

We are using the following docker image [gvenzl/oracle-xe](https://hub.docker.com/r/gvenzl/oracle-xe).

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

## Connect to Oracle

First connect to the docker instance

```bash
docker exec -ti oracledb-xe bash
```

and run SQL Plus to connect as user `sys` to the PDB.

```bash
sqlplus sys/EAo4KsTfRR@oracledb-xe:1521/XEPDB1 as sysdba```

