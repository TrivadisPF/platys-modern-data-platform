# Oracle RDBMS XE

Whether you are a developer, a DBA, a data scientist, an educator, or just curious about databases, Oracle Database Express Edition (XE) is the ideal way to get started. It is the same powerful Oracle Database that enterprises rely on worldwide, packaged for simple download, ease-of-use, and a full-featured experience. You get an Oracle Database to use in any environment, plus the ability to embed and redistribute – all completely free!  

**[Website](https://www.oracle.com/database/technologies/appdev/xe.html)** | **[Documentation](https://www.oracle.com/database/technologies/appdev/xe/quickstart.html)** | **[Docker Image](https://github.com/gvenzl/oci-oracle-xe)** | **[Docker Image Details](https://github.com/gvenzl/oci-oracle-xe/blob/main/ImageDetails.md)**

## How to enable?

```
platys init --enable-services ORACLE_XE
platys gen
```

## Initialize database

You can initialize the database automatically by putting the necessary scripts in `./init/oraclexe`:

To create more users, add a bash script, e.g. `01_create-user.sh`

```bash
#!/bin/bash
#
./createAppUser user1 abc123!
./createAppUser user2 abc123!
```

to create schema objects, add an sql script, e.g. `02_create-user1-schema.sql`

```sql
CONNECT user1/abc123!@//localhost/XEPDB1

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
docker exec -ti oracledb-xe sqlplus user1/abc123!@//localhost/XEPDB1
```

### Connect through JDBC

* **JDBC Url:**  	`jdbc:oracle:thin:@dataplatform:1522/XEPDB1`
* **JDBC Driver Class Name:** 	`oracle.jdbc.driver.OracleDriver`
