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

### AWS (S3) Credentials

Platys automatically creates the file `/opt/nifi/nifi-current/s3-credentials.properties` in the `nifi-1` container with the AWS credentials configured for either Minio or External S3. It is meant to be used as the **Credentials File** in either one of the AWS/S3 related processors or the [AWSCredentialsProviderControllerService](https://nifi.apache.org/docs/nifi-docs/components/org.apache.nifi/nifi-aws-nar/latest/org.apache.nifi.processors.aws.credentials.provider.service.AWSCredentialsProviderControllerService/index.html).

Platys also injects the following environment variables into the `nifi-1` container.

* `S3_ENDPOINT` - the S3 endpoint to use
* `S3_PATH_STYLE_ACCESS` - if path style access should be used
* `S3_REGION` - the AWS region to use
