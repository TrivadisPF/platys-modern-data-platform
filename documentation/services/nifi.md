# Apache NiFi

Apache NiFi supports powerful and scalable directed graphs of data routing, transformation, and system mediation logic.

**[Website](https://nifi.apache.org/)** | **[Documentation](https://nifi.apache.org/docs.html)** | **[GitHub](https://github.com/apache/nifi)**

## How to enable?

```bash
platys init --enable-services NIFI
platys gen
```

## How to use it?

Navigate to <http://dataplatform:18080/nifi>

Login with User `nifi` and password `1234567890ACD`.


### Installing JDBC Driver

If you want to use one of the Database Processors, you need to install a JDBC Driver for the database. Download it into `./plugins/nifi/jars` of your Platys stack and specify the folder `/extra-jars` folder when creating the Controller service in Apache NiFi.
