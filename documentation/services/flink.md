# Apache Flink

Apache Flink is a framework and distributed processing engine for stateful computations over unbounded and bounded data streams. Flink has been designed to run in all common cluster environments perform computations at in-memory speed and at any scale. 

**[Website](https://flink.apache.org/)** | **[Documentation](https://nightlies.apache.org/flink/flink-docs-master/)** | **[GitHub](https://github.com/apache/flink)**

## How to enable?

```bash
platys init --enable-services FLINK
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28237>

To connect to the CLI use 

```bash
docker exec -ti flink-sql-cli ./bin/sql-client.sh
```

### Automatically download dependencies

you can specify maven and github release dependencies using `FLINK_install_maven_dep` and `FLINK_install_file_dep` config setting.

For example to download from maven repository using a maven coordinate:

```yaml
FLINK_install_maven_dep: 'org.apache.flink:flink-sql-connector-kafka:3.4.0-1.20'
```

and to download an artefact from Github release page (specify it in the format `"<owner>:<project>:<version>:<artefact-name>`):

```yaml
FLINK_install_file_dep: 'knaufk:flink-faker:v0.5.3:flink-faker-0.5.3.jar'
```

You can specify multiple dependencies comma separated.