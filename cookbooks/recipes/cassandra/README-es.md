# Caso de IoT con Cassandra

Esta receta mostrará cómo usar Casandra

## Inicializar la plataforma de datos

Primero [inicializar una plataforma de datos compatible con platys](../documentation/getting-started.md) con los siguientes servicios habilitados

    platys init --enable-services CASSANDRA -s trivadis/platys-modern-data-platform -w 1.8.0

Ahora genere e inicie la plataforma de datos.

```bash
platys gen

docker-compose up -d
```

## Crear una tabla de sensores y series de tiempo

Puedes encontrar el `cqlsh` utilidad de línea de comandos dentro del contenedor docker de Cassandra que se ejecuta como parte de la plataforma. Conéctese a través de SSH al host de Docker y ejecute el siguiente comando docker exec

```bash
docker exec -ti cassandra-1 cqlsh
```

Alternativamente, también puede usar la interfaz de usuario web de Cassandra en <http://analyticsplatform:28120/>.

Cree un espacio de claves para los datos de IoT:

```sql
DROP KEYSPACE IF EXISTS iot_v10;

CREATE KEYSPACE iot_v10
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};
```

Ahora cambie al nuevo espacio de teclas

```sql
USE iot_v10;
```

And create the `iot_sensor` table


```sql
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
Insert some data

```sql
INSERT INTO iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, name, place) VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, 'st-1', '/environmentalSensor/stuttgart/1', 'environmental', 'Stuttgart-1', 'Stuttgart Server Room');

INSERT INTO iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, name, place) VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, 'zh-1', 'ultrasonicSensor', 'distance', 'Zurich-1', 'Zurich IT');
```

And create the `iot_timeseries` table

```sql
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

Insert some data

```sql
INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 24.1);

INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 50);

```


```sql
INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'TEMP', 22.2);

INSERT INTO iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALUES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'HUM', 45);
```