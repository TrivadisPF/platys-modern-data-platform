# UDF and ksqlDB

This recipe will show how to use a custom UDF with ksqlDB. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services KAFKA,KAFKA_KSQLDB -s trivadis/platys-modern-data-platform -w 1.9.1
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Create the UDF

Create a Java Maven Project using the following POM

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.trivadis.ksqldb.udf.demo</groupId>
    <artifactId>ksql-udf-string</artifactId>
    <version>1.0</version>

    <licenses>
        <license>
            <name>Apache License 2.0</name>
            <url>http://www.apache.org/licenses/LICENSE-2.0.html</url>
            <distribution>repo</distribution>
        </license>
    </licenses>

    <repositories>
        <repository>
            <id>confluent</id>
            <url>https://packages.confluent.io/maven/</url>
        </repository>
    </repositories>

    <properties>
        <assertj.version>3.11.1</assertj.version>
        <confluent.version>6.0.0</confluent.version>
        <exec.mainClass>com.gschmutz.ksql.udf.geohash.ThisIsIgnored</exec.mainClass>
        <java.version>1.8</java.version>
        <junit.version>4.12</junit.version>
        <kafka.version>2.6.0</kafka.version>
        <kafka.scala.version>2.11</kafka.scala.version>
        <maven.assembly.plugin.version>3.1.1</maven.assembly.plugin.version>
        <maven.compiler.plugin.version>3.8.1</maven.compiler.plugin.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <scala.version>${kafka.scala.version}.8</scala.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>io.confluent.ksql</groupId>
            <artifactId>ksqldb-udf</artifactId>
            <version>${confluent.version}</version>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.apache.commons/commons-lang3 -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.11</version>
        </dependency>

        <!-- Test dependencies -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.assertj</groupId>
            <artifactId>assertj-core</artifactId>
            <version>${assertj.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>

        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven.compiler.plugin.version}</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                    <compilerArgs>
                        <arg>-Xlint:all</arg>
                        <arg>-Werror</arg>
                    </compilerArgs>
                </configuration>
            </plugin>

            <!-- Package all dependencies as one jar -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>${maven.assembly.plugin.version}</version>
                <configuration>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <mainClass>${exec.mainClass}</mainClass>
                        </manifest>
                    </archive>
                </configuration>
                <executions>
                    <execution>
                        <id>assemble-all</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>

    </build>

</project>
```

Create a Java package `com.trivadis.ksql.demo` and in it create the following Java class:

```java
package com.trivadis.ksql.demo;

import io.confluent.ksql.function.udf.Udf;
import io.confluent.ksql.function.udf.UdfDescription;
import io.confluent.ksql.function.udf.UdfParameter;
import org.apache.commons.lang3.StringUtils;

@UdfDescription(name = "del_whitespace", description = "Deletes all whitespaces from a String")
public class StringUDF {
	@Udf(description = "Deletes all whitespaces from a String")
	public String adjacentHash(@UdfParameter(value="string", description = "the string to apply the function on") String value) {
		return StringUtils.deleteWhitespace(value);
	}

}
```

Build the Java project using

```
mvn clean package
```

Inside the `target` folder, a jar named `ksql-udf-string-1.0-jar-with-dependencies.jar` should be created. 


## Copy the JAR to the ksqlDB engine folder

When working with Platys, the `target/ksql-udf-string-1.0-jar-with-dependencies.jar` JAR file has to be copied into the folder `$DATAPLATFORM_HOME/plugins/ksql`, from where it will be picked-up by the kqlDB engine. 

Restart the ksqldb servers using 

```
docker restart ksqldb-server-1
docker restart ksqldb-server-2
```

If you have more than 2 servers running, do it for the other ones as well. 

## Test the UDF

Now let's see our UDF in action. For that let's connect to ksqlDB CLI

```bash
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```

And show all functions

```
show functions;
```

Besides the built-in functions, our new UDF called `del_whitespace` should show up as well. 

Let's create a new Stream backed by a topic, just for doing a `SELECT ...` to test the UDF

```
CREATE STREAM test_s (v1 VARCHAR) 
WITH (kafka_topic='test',
        value_format='JSON',
        partitions=8,
        replicas=3);
```

Let's call the UDF inside a `SELECT ... EMIT CHANGES`

```
SELECT del_whitespace(v1) 
FROM test_s 
EMIT CHANGES;
```

To see it working, we have to publish some data into the topic. The simplest way to do that is using an `INSERT INTO ...` from an other ksqlDB CLI. 

```
INSERT INTO test_s VALUES ('Guido Schmutz');
```

You should see the result in the previous ksqlDB CLI

```
ksql> select del_whitespace(v1) from test_s emit changes;
+-----------------------------------------------------------------------------------------------------------------+
|KSQL_COL_0                                                                                                       |
+-----------------------------------------------------------------------------------------------------------------+
|GuidoSchmutz                                                                                                     |

Press CTRL-C to interrupt
```
        


