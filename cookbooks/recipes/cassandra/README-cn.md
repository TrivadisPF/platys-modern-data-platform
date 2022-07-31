# 与卡桑德拉的物联网案例

这个食谱将展示如何使用卡萨恩德拉

## 初始化数据平台

第一[初始化平台支持的数据平台](../documentation/getting-started.md)启用以下服务

    platys init --enable-services CASSANDRA -s trivadis/platys-modern-data-platform -w 1.8.0

现在生成并启动数据平台。

    platys gen

    docker-compose up -d

## 创建传感器和时间序列表

您可以找到`cqlsh`Cassandra docker 容器中的命令行实用程序作为平台的一部分运行。通过 SSH 连接到 Docker 主机并运行以下 docker exec 命令

    docker exec -ti cassandra-1 cqlsh

或者，您也可以在<http://analyticsplatform:28120/>.

为 IoT 数据创建密钥空间：

    DROP KEYSPACE IF EXISTS iot_v10;

    CREATE KEYSPACE iot_v10
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

现在切换到新的密钥空间

````
USE iot_v10;use ```

And create the `iot_sensor` table


````

\-- 网关存储
如果存在，则删除表 iot_sensor;
如果不存在，则创建表 iot_sensor （id UUID，
sensor_key文本，
sensor_topic_name文本，
sensor_type文本，
名称文本，
置入文本，
主键 （id））;

```
```

插入到iot_sensor（id，sensor_key，sensor_topic_name，sensor_type，名称，地点）值（3248240c-4725-49d3-8da6-9850bb69f2a0，'st-1'，'/environmentalSensor/stuttgart/1'，'environmental'，'Stuttgart-1'，'Stuttgart-1';

INSERT INTO iot_sensor （id， sensor_key， sensor_topic_name， sensor_type， name， place） VALUES （6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c， 'zh-1'， 'ultrasonicSensor'， 'distance'， 'Zurich-1'， 'Zurich IT'）;

```


And create the `iot_timeseries` table

```

\-- 按reading_type
iot_timeseries删除表;
如果不存在，则创建表 iot_timeseries （
sensor_id uuid，
bucket_id文本，
reading_time_id时间戳，
reading_type文本，
reading_value十进制，
主键（（sensor_id、bucket_id）、reading_time_id、reading_type））
按聚类顺序排列（reading_time_id DESC）
和紧凑的存储;

```


```

INSERT INTO iot_v10.iot_timeseries （sensor_id， bucket_id， reading_time_id， reading_type， reading_value）
值 （3248240c-4725-49d3-8da6-9850bb69f2a0， '2020-09'， toTimeStamp（now（））， 'TEMP'， 24.1）;

INSERT INTO iot_v10.iot_timeseries （sensor_id， bucket_id， reading_time_id， reading_type， reading_value）
值 （3248240c-4725-49d3-8da6-9850bb69f2a0， '2020-09'， toTimeStamp（now（））， 'TEMP'， 50）;

```


```

INSERT INTO iot_v10.iot_timeseries （sensor_id， bucket_id， reading_time_id， reading_type， reading_value）
值 （6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c， '2020-09'， toTimeStamp（now（））， 'TEMP'， 22.2）;

INSERT INTO iot_v10.iot_timeseries （sensor_id， bucket_id， reading_time_id， reading_type， reading_value）
值 （6cb83f1d-49cc-45d8-b2d2-3fdd7b30a76c， '2020-09'， toTimeStamp（now（））， 'HUM'， 45）;

```
```
