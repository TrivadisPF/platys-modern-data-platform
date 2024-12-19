# Oracle Database Free (OCI - gvenzl edition)

Oracle Database 23c Free—Developer Release is the same, powerful Oracle Database that businesses throughout the world rely on. It offers a full-featured experience and is packaged for ease of use and simple download—for free.

**[Website](https://www.oracle.com/database/free/)** | **[Documentation](https://www.oracle.com/database/free/get-started/)** | **[Docker Image](https://github.com/gvenzl/oci-oracle-free)** | **[Docker Image Details](https://github.com/gvenzl/oci-oracle-free/blob/main/ImageDetails.md)**

## How to enable?

```
platys init --enable-services ORACLE_OCI_FREE
platys gen
```

## Initialize database

You can initialize the database automatically by putting the necessary scripts in `./init/oracle-oci-free`:

To create more users, add a bash script, e.g. `01_create-user.sh`

```bash
#!/bin/bash
#
./createAppUser user1 abc123!
./createAppUser user2 abc123!
```

to create schema objects, add an sql script, e.g. `02_create-user1-schema.sql`

```sql
CONNECT user1/abc123!@//localhost/FREEPDB1

DROP TABLE person_t IF EXISTS;

CREATE TABLE person_t (
	business_entity_id     	INTEGER     PRIMARY KEY,
    person_type            	VARCHAR2(100),
    name_style             	VARCHAR2(1),
    title					VARCHAR2(20),
    first_name             	VARCHAR2(100),
    middle_name            	VARCHAR2(100),
    last_name              	VARCHAR2(100),
    email_promotion        	NUMBER(10),
    demographics			VARCHAR2(2000),
    created_date			TIMESTAMP,
    modified_date         	TIMESTAMP);
```     

## How to use it?

### Connect through SQL Plus

```
docker exec -ti oracledb-oci-free sqlplus "user1/abc123!"@//localhost/FREEPDB1
```

### Connect through JDBC

* **JDBC Url:**  	`jdbc:oracle:thin:@dataplatform:1523/FREEPDB1`
* **JDBC Driver Class Name:** 	`oracle.jdbc.driver.OracleDriver`
