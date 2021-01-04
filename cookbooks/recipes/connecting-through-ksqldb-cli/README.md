# Connecting through ksqlDB CLI

This recipe will show how to connect throught the CLI to ksqlDB. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
platys init --enable-services KAFKA,KAFKA_KSQLDB -s trivadis/platys-modern-data-platform -w 1.9.1
```

Optionally you can increase the number of ksqlDB server instances by adding the following property to the `config.yml` generated in the previous step.

```
KAFKA_KSQLDB_nodes: 2
```

Now set an environment variable to the home folder of the dataplatform and generate and then start the data platform. 

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Connect through the CLI

To connect over the CLI, we use the `ksqldb-cli` docker container and connect to the `ksqldb-server-1` container, which is running the ksqlDB server, possibly with other servers if have increased the number of nodes in `KAFKA_KSQLDB_nodes` property in the `config.yml`. 

```bash
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```

you should see an output similar to the one below

```
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.

                  
                  ===========================================
                  =       _              _ ____  ____       =
                  =      | | _____  __ _| |  _ \| __ )      =
                  =      | |/ / __|/ _` | | | | |  _ \      =
                  =      |   <\__ \ (_| | | |_| | |_) |     =
                  =      |_|\_\___/\__, |_|____/|____/      =
                  =                   |_|                   =
                  =  Event Streaming Database purpose-built =
                  =        for stream processing apps       =
                  ===========================================

Copyright 2017-2020 Confluent Inc.

CLI v0.14.0-rc732, Server v0.14.0-rc732 located at http://ksqldb-server-1:8088
Server Status: RUNNING

Having trouble? Type 'help' (case-insensitive) for a rundown of how things work!

ksql> 
```
