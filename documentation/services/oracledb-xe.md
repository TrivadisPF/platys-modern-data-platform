# Oracle RDBMS XE

Whether you are a developer, a DBA, a data scientist, an educator, or just curious about databases, Oracle Database Express Edition (XE) is the ideal way to get started. It is the same powerful Oracle Database that enterprises rely on worldwide, packaged for simple download, ease-of-use, and a full-featured experience. You get an Oracle Database to use in any environment, plus the ability to embed and redistribute – all completely free!  

**[Website](https://www.oracle.com/database/technologies/appdev/xe.html)** | **[Documentation](https://www.oracle.com/database/technologies/appdev/xe/quickstart.html)** 

## How to enable?

```
platys init --enable-services ORACLE_XE
platys gen
```

### Connect through JDBC

* **JDBC Url:**  	`jdbc:oracle:thin:@dataplatform:1522/XEPDB1`
* **JDBC Driver Class Name:** 	`oracle.jdbc.driver.OracleDriver`
