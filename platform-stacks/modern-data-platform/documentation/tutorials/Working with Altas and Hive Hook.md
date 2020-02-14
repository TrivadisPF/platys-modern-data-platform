# Working with Altas and Hive Hook

This tutorial will show the Hive Hook and Atlas in Action.

## Setup a platform

First initialise a platform with the following minimal services enabled. 

```
KAFKA_enable=true
HADOOP_enable=true
HIVE_enable=true
HUE_enable=true
ATLAS_enable=true
```

## Listen on the ATLAS_HOOK

Before we create a table in Hive, let's listen on the Kafka topic `ATLAS_HOOK` to see the event raised by the Hive hook. 

In a terminal window, either use the `kafka-console-consumer` inside the running docker container

```
docker exec -ti kafka-1 kafka-console-consumer --topic ATLAS_HOOK --broker-list kafka-1:9092
```

or using a local installation of `kafkacat`

```
kafkacat -b dataplatform -t ATLAS_HOOK
```

## Create a table in Hive

In a browser window, navigate to hue: <http://dataplatform:8888>. 

```
create table test3 (v1 string)
```

## Check data in ATLAS_HOOK

Check that an event has been raised on the `ATLAS_HOOK` Kafka topic you have started the event listener above. 


## Check the entity in Apache Atlas

In a browser, navigate to <http://dataplatform:21000> and search for hive-table