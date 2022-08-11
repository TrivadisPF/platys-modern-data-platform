---
technoglogies:      tipboard,kafka
version:				1.14.0
validated-at:			28.11.2021
---

# Working with Tipboard and Kafka

This recipe will show how to use Tipboard with Kafka to stream data to the dashboard.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services TIPBOARD,KAFKA,KSQLDB,AKHQ,KCAT -n cookbook-platform -s trivadis/platys-modern-data-platform -w 1.14.0
```

edit the `config.yml` and add the connector to the following property

```
      TIPBOARD_volume_map_dashboards: true
      TIPBOARD_redis_password: 'abc123!'
```

start the platform

```
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

## Create the Tipboard Layout

Create a file `layout_config.yaml` in the `scripts/tipboard` folder

```
details:
    page_title: Sample Dashboard
layout:
    - row_1_of_2:
        - col_1_of_2:
            - tile_template: text
              tile_id: Status
              title: Status
              classes:

        - col_1_of_2:
            - tile_template: empty
              tile_id: empty
              title: Empty Tile
              classes:

    - row_1_of_2:
        - col_1_of_4:
            - tile_template: empty
              tile_id: empty
              title: Empty Tile
              classes:

        - col_1_of_4:
            - tile_template: empty
              tile_id: empty
              title: Empty Tile
              classes:

        - col_1_of_4:
            - tile_template: empty
              tile_id: empty
              title: Empty Tile
              classes:

        - col_1_of_4:
            - tile_template: empty
              tile_id: empty
              title: Empty Tile
              classes:
```

## Create a Kafka topic and simulate values

Create a Kafka topic

```bash
docker exec -ti kafka-1 kafka-topics --bootstrap-server kafka-1:19092 --create --topic sensor-readings --replication-factor 3 --partitions 3
```

Create the simulator definition

```bash
mkdir simulator-conf

nano simulator-conf/devices-def.json
```

```json
[
    {
        "type":"simple",
        "uuid":"",
        "topic":"sensor-readings",
        "sampling":{"type":"fixed", "interval":1000},
        "copy":10,
        "sensors":[
            {"type":"dev.timestamp",    "name":"ts", "format":"yyyy-MM-dd'T'HH:mm:ss.SSSZ"},
            {"type":"dev.uuid",         "name":"uuid"},
            {"type":"double_walk",   "name":"temp",  "min":-15, "max":3},
            {"type":"double_cycle",  "name":"level", "values": [1.1,3.2,8.3,9.4]},
            {"type":"string",        "name":"level", "random": ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o"]}
        ]
    }
]
```

Run the simulator

```bash
docker run --network cookbook-platform -v $PWD/simulator-conf/devices-def.json:/conf/devices-def.json trivadis/iot-simulator -dt KAFKA -u kafka-1:19092 -t iot/ -cf /conf/devices-def.json
```


