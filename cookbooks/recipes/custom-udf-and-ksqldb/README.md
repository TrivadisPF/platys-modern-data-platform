# Custom UDF and ksqlDB

This recipe will show how to use a custom UDF with ksqlDB. We will see a "normal" UDF in action, which is a stateless function working on scalar value. Besides the UDFs, you can also create stateful aggregate functions (UDAFs) and table functions (UDTFs). Find more information on these 3 types of user-defined functions in the [ksqlDB documentation](https://docs.ksqldb.io/en/latest/concepts/functions/). 

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

You can find the complete Java project in the subfolder [ksql-udf-string](./ksql-udf-string).

Add the following to the `~/.m2/settings.xml`:

```xml
<settings>
   <profiles>
      <profile>
         <id>myprofile</id>
         <repositories>
            <!-- Confluent releases -->  
            <repository>
               <id>confluent</id>
               <url>https://packages.confluent.io/maven/</url>
            </repository>

            <!-- further repository entries here -->
         </repositories>   
      </profile>
    </profiles> 

   <activeProfiles>
      <activeProfile>myprofile</activeProfile>
   </activeProfiles>
</settings>
```

Run the following command to create a new Maven project:

```bash
mvn archetype:generate -X \
    -DarchetypeGroupId=io.confluent.ksql \
    -DarchetypeArtifactId=ksqldb-udf-quickstart \
    -DarchetypeVersion=6.0.0
```

Fill out the arguments being prompted for.

Add the following dependency to the POM:

```xml
	<dependencies>
	
        <!-- https://mvnrepository.com/artifact/org.apache.commons/commons-lang3 -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.11</version>
        </dependency>
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
        


