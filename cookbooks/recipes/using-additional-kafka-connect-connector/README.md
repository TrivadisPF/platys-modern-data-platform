# Using additional Kafka Connect Connector

This recipe will show how to install an additional Kafka Connect Connector which is not part of the default platform. We will show two different versions, one installing it from the [Confluent Hub](https://www.confluent.io/hub/) and the other one by downloading a tar and copying it into the correct folder.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services KAFKA,KAFKA_CONNECT -s trivadis/platys-modern-data-platform -w 1.10.0
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Installing Kafka Connect connectors from Confluent Hub

Navigate to [Confluent Hub](https://www.confluent.io/hub/) and search for a connector you would like to use. In this cookbook we are going to to use the S3 connector. Type `S3` into the search bar and hit enter. You will see a result of two connectors appear below. We are going to use the **Kafka Connect S3** connector.

![Alt Image Text](./images/confluent-hub-1.png "Confluent Hub ")

Click on the **Kafka Connect S3** result and you should see the details page on the connector:

![Alt Image Text](./images/confluent-hub-2.png "Confluent Hub ")

The description tells us that it is a **Sink** connector and that it is available as part of the **Confluent Community License**, so it is free to use. 
 
**Note:** Not all connectors available on the **Confluent Hub** are free to use, some are part of the **Confluent Enterprise License**.

We will need the address of the connector which we can get from the install command: 

```bash
confluent-hub install confluentinc/kafka-connect-s3:5.5.3
```

So in our case it is currently `confluentinc/kafka-connect-s3:5.5.3` (the version could vary). 
Add this value to the `KAFKA_CONNECT_connectors` property in your `config.yml`

```yaml
KAFKA_CONNECT_enable: true
KAFKA_CONNECT_nodes: 2
KAFKA_CONNECT_connectors: 'confluentinc/kafka-connect-s3:5.5.3'
``` 

`KAFKA_CONNECT_connectors` holds a list of connector addresses from Confluent Hub and these connectors will be automatically installed when starting the Kafka Connect cluster. But first we have to regenerate the platform 

```bash
platys gen
```

and then we can restart the Kafka Connect cluster

```bash
docker-compose up -d
```

and we should see that the `kafka-connect-1` container is restarted

```bash
docker@ubuntu:~/platys-cookbook$ docker-compose up -d
schema-registry-1 is up-to-date
markdown-viewer is up-to-date
zookeeper-1 is up-to-date
kafka-connect-2 is up-to-date
Recreating kafka-connect-1 ... 
Starting markdown-renderer ... 
kafka-2 is up-to-date
Recreating kafka-connect-1 ... done
Starting markdown-renderer ... done
```

Once the connector is up and running, we can use the **S3 Sink** connector. 

## Manually Downloading Kafka Connect connectors

t.b.d


