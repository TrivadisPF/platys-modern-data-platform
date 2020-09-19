# IoT Case with Cassandra

This recipe will show how to use Casandra 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services CASSANDRA -s trivadis/platys-modern-data-platform -w 1.8.0
```

Now generate and start the data platform. 

```
platys gen

docker-compose up -d
```

## Create a sensor and timeseries table

You can find the `cqlsh` command line utility inside the Cassandra docker container running as part of the platform. Connect via SSH onto the Docker Host and run the following docker exec command

```
docker exec -ti cassandra-1 cqlsh
```

Alternatively you can also use the Cassandra Web UI on <http://analyticsplatform:28120/>.

Create a keyspace for the IoT data:

```
DROP KEYSPACE IF EXISTS iot_v10;

CREATE KEYSPACE iot_v10
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};
```

now switch to the new keyspace

```
USE iot_v10;use ```

And create the `iot_sensor` table


```
-- gateways storage
DROP TABLE IF EXISTS iot_sensor;
CREATE TABLE IF NOT EXISTS iot_sensor (id UUID,
						    sensor_key text,
						    sensor_topic_name text,
						    sensor_type text,
							 name text,
							 place text,
							PRIMARY KEY (id));
```

```
INSERT INTO iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, name, place) VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, 'st-1', '/environmentalSensor/stuttgart/1', 'environmental', 'Stuttgart-1', 'Stuttgart Server Room');

INSERT INTO iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, name, place) VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, 'zh-1', 'ultrasonicSensor', 'distance', 'Zurich-1', 'Zurich IT');
```


And create the `iot_timeseries` table

```
-- timeseries by reading_type
DROP TABLE iot_timeseries;
CREATE TABLE IF NOT EXISTS iot_timeseries (
    sensor_id   uuid,
    bucket_id   text,
    reading_time_id     timestamp, 
    reading_type    text,
    reading_value	decimal,
    PRIMARY KEY((sensor_id, bucket_id), reading_time_id, reading_type))
    WITH CLUSTERING ORDER BY (reading_time_id DESC)
    AND COMPACT STORAGE;
```


```



INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 24.1);

INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 50);

```


```
INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'TEMP', 22.2);

INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'HUM', 45);

```
