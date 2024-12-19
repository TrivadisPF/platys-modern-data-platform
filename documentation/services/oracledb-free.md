# Oracle Database Free (official)

Oracle Database 23c Free—Developer Release is the same, powerful Oracle Database that businesses throughout the world rely on. It offers a full-featured experience and is packaged for ease of use and simple download—for free.

**[Website](https://www.oracle.com/database/free/)** | **[Documentation](https://www.oracle.com/database/free/get-started/)** | **[Docker Image Details](https://container-registry.oracle.com/ords/f?p=113:4:115567976113134:::4:P4_REPOSITORY,AI_REPOSITORY,AI_REPOSITORY_NAME,P4_REPOSITORY_NAME,P4_EULA_ID,P4_BUSINESS_AREA_ID:1863,1863,Oracle%20Database%20Free,Oracle%20Database%20Free,1,0&cs=3MHjs2CbU7Z2xE5zjfryFwJMO-0oce2_nARX2Z8Z4Dgj0xnkJrda2U2qYAfcWRGCAZZdE5Al5ElcN0V30HCpA5A)**

## How to enable?

```
platys init --enable-services ORACLE_FREE
platys gen
```

## Initialize database

You can initialize the database automatically by putting the necessary scripts in 

 * `./init/oracle-free/startup` - scripts to be run after database startup
 * `./init/oracle-free/setup` - scripts to be run after database setup.

## How to use it?

### Connect through SQL Plus

```
docker exec -ti oracledb-free sqlplus "user1/abc123!"@//localhost/FREEPDB1
```

### Connect through JDBC

* **JDBC Url:**  	`jdbc:oracle:thin:@dataplatform:1524/FREEPDB1`
* **JDBC Driver Class Name:** 	`oracle.jdbc.driver.OracleDriver`
