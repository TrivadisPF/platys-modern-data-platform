# Caso de IoT con Cassandra

Esta receta mostrará cómo usar Casandra

## Inicializar la plataforma de datos

Primero [inicializar una plataforma de datos compatible con platys](../documentation/getting-started.md) con los siguientes servicios habilitados

    platys init --enable-services CASSANDRA -s trivadis/platys-modern-data-platform -w 1.8.0

Ahora genere e inicie la plataforma de datos.

    platys gen

    docker-compose up -d

## Crear una tabla de sensores y series de tiempo

Puedes encontrar el `cqlsh` utilidad de línea de comandos dentro del contenedor docker de Cassandra que se ejecuta como parte de la plataforma. Conéctese a través de SSH al host de Docker y ejecute el siguiente comando docker exec

    docker exec -ti cassandra-1 cqlsh

Alternativamente, también puede usar la interfaz de usuario web de Cassandra en <http://analyticsplatform:28120/>.

Cree un espacio de claves para los datos de IoT:

    DROP KEYSPACE IF EXISTS iot_v10;

    CREATE KEYSPACE iot_v10
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

Ahora cambie al nuevo espacio de teclas

````
USE iot_v10;use ```

And create the `iot_sensor` table


````

\-- almacenamiento de gateways
COLOCAR TABLA SI EXISTE iot_sensor;
CREAR TABLA SI NO EXISTE iot_sensor (id UUID,
sensor_key texto,
sensor_topic_name texto,
sensor_type texto,
texto del nombre,
colocar texto,
CLAVE PRIMARIA (id));

```
```

INSERTE en iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, nombre, lugar) VALORES (3248240c-4725-49d3-8da6-9850bb69f2a0, 'st-1', '/environmentalSensor/stuttgart/1', 'environmental', 'Stuttgart-1', 'Stuttgart Server Room');

INSERT INTO iot_sensor (id, sensor_key, sensor_topic_name, sensor_type, name, place) VALORES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, 'zh-1', 'ultrasonicSensor', 'distance', 'Zurich-1', 'Zurich IT');

```


And create the `iot_timeseries` table

```

\-- series temporales por reading_type
IOT_TIMESERIES DE LA TABLA DE CAÍDAS;
CREAR TABLA SI NO EXISTE iot_timeseries (
sensor_id uuid,
bucket_id texto,
reading_time_id marca de tiempo,
reading_type texto,
reading_value decimal,
CLAVE PRIMARIA((sensor_id, bucket_id), reading_time_id, reading_type))
CON PEDIDO DE AGRUPACIÓN POR (reading_time_id DESC)
Y ALMACENAMIENTO COMPACTO;

```


```

INSERTAR EN iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALORES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 24.1);

INSERTAR EN iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALORES (3248240c-4725-49d3-8da6-9850bb69f2a0, '2020-09', toTimeStamp(now()), 'TEMP', 50);

```


```

INSERTAR EN iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALORES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'TEMP', 22.2);

INSERTAR EN iot_v10.iot_timeseries (sensor_id, bucket_id, reading_time_id, reading_type, reading_value)
VALORES (6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c, '2020-09', toTimeStamp(now()), 'HUM', 45);

```
```
