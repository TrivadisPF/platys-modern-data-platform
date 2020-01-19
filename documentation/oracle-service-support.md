# Support Oracle Containers


## Oracle RDMBS
Oracle is not available as pre-built images on Docker Hub. Instead you have to built a container on your own using the Dockerfiles Oracle provides on GitHub. 


### Express Edition 18.4.0

In a terminal window, navigate to the `18.4.0` folder

```
cd dockerfiles/18.4.0
```

Now build the Oracle XE docker image 

```
./buildDockerImage.sh -v 18.4.0 -x -i
```

Run a standalone container instance using the following command

```
docker run --name xe \
		-p 1521:1521 -p 5500:5500 \
		-e ORACLE_PWD=manager \
		-e ORACLE_CHARACTERSET=AL32UTF8 \
		-v ./work/docker/db_setup_scripts:/opt/oracle/scripts/setup \
		oracle/database:18.4.0-xe
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.4.0-xe
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

### Standard Edition 18.3.0

In a terminal window, navigate to the `18.3.0` folder

```
cd dockerfiles/18.3.0
```

Now build the Oracle Standard Edition docker image 

```
./buildDockerImage.sh -v 18.3.0 -s -i
```

Run a standalone container instance using the following command

```
docker run --name orcl \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-e ORACLE_PWD=manager \
-e ORACLE_CHARACTERSET=AL32UTF8 \
oracle/database:18.3.0-se2
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.3.0-se2
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_SID: ORCLCDB
      ORACLE_PDB: ORCLPDB1
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

### Enterprise Edition 18.3.0

In a terminal window, navigate to the `18.3.0` folder

```
cd dockerfiles/18.3.0
```

Now build the Oracle Enterprise Edition docker image  

```
./buildDockerImage.sh -v 18.3.0 -e -i
```

Run a standalone container instance using the following command

```
docker run --name orcl \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-e ORACLE_PWD=manager \
-e ORACLE_CHARACTERSET=AL32UTF8 \
-v ${PWD}/db_setup_scripts:/opt/oracle/scripts/setup \
oracle/database:18.3.0-ee
```

Or add it as a service to a docker-compose configuration

```
  oracle-db:
    image: oracle/database:18.3.0-ee
    container_name: oracle-db
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      ORACLE_SID: ORCLCDB
      ORACLE_PDB: ORCLPDB1
      ORACLE_PWD: manager
      ORACLE_CHARACTERSET: AL32UTF8
    restart: always
```

## Oracle REST Data Services on Docker

Support available here: <https://github.com/oracle/docker-images/tree/master/OracleRestDataServices>

First you have to build the `OracleJava` docker image. Download the latest server-jre-8uNNN-linux-x64.tar.gz and build it

```
./build.sh
```

Then in the `OracleRestDatabaseService` folder build the Oracle REST Data Service docker image 

```
./buildDockerImage.sh -i
```

Run a standalone instance using the following command

```
docker run --name <container name> \
--network=<name of your created network> \
-p 8888:8888 \
-e ORACLE_HOST=oracle-db \
-e ORACLE_PORT=1521 \
-e ORACLE_SERVICE=XEPDB1 \
-e ORACLE_PWD=manager \
-e ORDS_PWD=manager \
-v [<host mount point>:]/opt/oracle/ords/config/ords \
oracle/restdataservices:18.4.0
```

Or add it as a service to a docker-compose configuration

```
  oracle-rest-1:
    image: oracle/restdataservices:18.4.0
    container_name: oracle-rest-1
    ports:
      - "8888:8888"
    environment:
      ORACLE_HOST: oracle-db
      ORACLE_PORT: 1521
      ORACLE_SERVICE: XEPDB1
      ORACLE_PWD: manager
      ORDS_PWD: manager
    restart: always
```
 
