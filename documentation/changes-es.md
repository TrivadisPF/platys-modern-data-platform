# `modern-data-platform` - ¿Qué hay de nuevo?

Ver [Actualizar a una nueva versión de pila de plataforma](https://github.com/TrivadisPF/platys/blob/master/documentation/upgrade-platform-stack.md) para saber cómo actualizar a una versión más reciente.

## Novedades de la versión 1.14.0

La versión 1.14.0 de Modern Data Platform contiene las siguientes correcciones de errores y mejoras:

### Nuevos Servicios

*   Kouncil
*   Registro Apicurio
*   Plataforma DataOps de conjuntos de flujos
*   Grafana Loki
*   Grafana Promtail
*   Herramientas Avro
*   Magia Kafka
*   StreamPipes
*   Rémora
*   Metabase
*   Jikkou
*   Horca
*   Jaeger
*   Colector OTEL (OpenTelemetry)
*   Plataforma Camunda BPM
*   Camunda Optimizar
*   Caja de lentes
*   Consulta Tempo & Tempo
*   Promtail

### Nuevas recetas de libros de cocina

*   [Registro apicurio con almacenamiento SQL (PostgreSQL)
    ](../cookbooks/recipes/apicurio-with-database-storage)

*   [Automatice la gestión de los temas de Kafka en la plataforma](../cookbooks/recipes/jikkou-automate-kafka-topics-management/README.md)

*   [Configuración simulada de varios CC en una máquina](../cookbooks/recipes/simulated-multi-dc-setup/README.md)

*   [Creación de un entorno de DataOps de StreamSets autogestionado mediante Platys](../cookbooks/recipes/streamsets-dataops-creating-environment/README.md)

*   [Carga de tuberías de Streamsets al inicio del contenedor](../cookbooks/recipes/streamsets-loading-pipelines/README.md)

*   [Trabajar con Tipboard y Kafka](../cookbooks/recipes/tipboard-and-kafka/README.md)

*   [Consulta de datos en Kafka desde Trino (anteriormente PrestoSQL)](../cookbooks/recipes/querying-kafka-with-trino/README.md)

*   [Uso de un conector Kafka Connect que no esté en confluentes](../cookbooks/recipes/using-kafka-connector-not-in-confluent-hub/README.md)

### Actualizaciones de versión

*   Actualizar `DataHub` Para `0.8.25`
*   Actualizar `Trino` Para `371`
*   Actualizar `Starburst Enterprise` Para `369-e`
*   Actualizar `Apache NiFi` Para `1.15.0`
*   Actualizar `Hasura` Para `v2.0.0-beta.2`
*   Actualizar `ksqlDB` Para `0.23.1`
*   Actualizar `Zeppelin` Para `0.10.0`
*   Actualizar `Livy` Para `0.7.1-incubating`
*   Actualizar `Spark 3` Para `3.2`
*   Actualizar `Streamsheets` Para `2.5-milestone`
*   Actualizar `Neo4J` Para `4.4`
*   Actualizar `Confluent` Para `7.0.1`
*   Actualizar `NiFi` Para `1.15.2` y `NiFi Registry` Para `1.15.1`
*   Actualizar `Marquez` Para `0.20.0`
*   Actualizar `Amundsen Frontend` Para `4.0.0` y `Amundsen Search` Para `3.0.0`
*   Actualizar `InfluxDB 2` Para `2.1.1`
*   Actualizar `EventStore`Para `21.10.1-buster-slim`
*   Actualizar `Keycloak` Para `16.1.1`
*   Actualizar `Dremio` Para `20.0`
*   Actualizar `Minio` Para `RELEASE.2022-02-01T18-00-14Z`
*   Actualizar `lakeFS` Para `0.58.0`
*   Actualizar `Vault` Para `1.9.3`
*   Actualizar `Ranger` Para `2.2.0`
*   Actualizar `Materialize` Para `v0.19.0`
*   Actualizar `kcat` Para `1.7.1`
*   Actualizar `Debezium` Para `1.8.0.Final`
*   Actualizar `Datastax` Para `6.8.19`
*   Actualizar `Elasticsearch` Para `7.17.0`
*   Actualizar `Node-RED` Para `2.2.0`
*   Actualizar `Spring Dataflow` Para `2.9.2` y `Skipper` Para `2.8.2`
*   Actualizar `MLflow` Para `1.23.1`
*   Actualizar `Optuna Dashboard` Para `0.5.0`
*   Actualizar `Kie-Server` Para `7.61.0.Final`
*   Actualizar `Grafana` Para `8.3.4`
*   Actualizar `Kibana` Para `7.17.0`
*   Actualizar `Memchached` Para `1.6.13`
*   Actualizar `Solr` Para `8.11`
*   Actualizar `DGraph` Para `v21.12.0`
*   Actualizar `Stardog` Para `7.8.3-java11-preview`
*   Actualizar `GraphDB` Para `9.10.1`
*   Actualizar `QuestDB` Para `6.2`
*   Actualizar `Druid` Para `0.22.1`
*   Actualizar `Pinot` Para `0.9.3`
*   Actualizar `Prometheus` Para `v2.33.1` y `pushgateway` Para `v1.4.2` y `nodeexporter` Para `v1.3.1`
*   Actualizar `Tile38` Para `1.27.1`
*   Actualizar `Axon` Para `4.5.10`
*   Actualizar `Hasura` Para `v2.2.0`
*   Actualizar `Emq` Para `4.3.11`
*   Actualizar `Cedalo Mgmt Center` Para `2.2`
*   Actualizar `Thingsboard` Para `3.3.3`
*   Actualizar `RabbitMQ` Para `3.9-management`
*   Actualizar `Watchtower` Para `1.4.0`

### Cambios de última hora

*   InfluxDB ahora está escuchando en `19999` En lugar de `9999`
*   Todo `KAFKA_SCHEMA_REGISTRY_xxxx` renombrado a `CONFLUENT_SCHEMA_REGISTRY_xxxx`
*   Todo `KAFKA_SCHEMA_REGISTRY_UI_xxxx` renombrado a `SCHEMA_REGISTRY_UI_xxxx`
*   Agregue kafka advertised listener adicional para localhost (puerto 39092 - 39099) y divídalo del docker listener (en $DOCKER_HOST_IP con el puerto 29092 - 29099)
*   permite cambiar el uso del puerto estándar de Kafka entre EXTERNAL y DOCKER_HOST Listener (parámetro config `KAFKA_use_standard_port_for_external_interface`)
*   `KAFKA_BURROW_enable` renombrado a `BURROW_enable`
*   `conf-override` renombrado a `custom-conf` para reflejar mejor el hecho, que esta carpeta es solo para archivos de configuración cusotmized que no se sobrescribirán al volver a generar la plataforma
*   Si copia manualmente los conectores de Kafka Connect, ya no los coloca en `plugins/kafka-connect` pero `plugins/kafka-connect/connectors`
*   Cambiar el nombre de la `python` opciones de configuración (`PYTHON_artefacts_folder` y `PYTHON_script_file`)

### Mejoras

*   Apicurio Schema Registry como reemplazo directo para el Confluent Schema Registry
*   Todos los servicios de la página de markdown de la lista de servicios (http://dataplatform/services) contienen un enlace a su página de inicio
*   La página de configuración también enlaza con la página de inicio de serice
*   Soporte de autenticación y autorización en apicurio Registry a través de Keycloak
*   Se ha agregado compatibilidad con los paquetes PIP que se instalarán antes de ejecutar el `python` contenedor
*   Soporte para el envío de registros docker a Grafana Loki

### Correcciones

*   Error corregido con el servicio Burrow
*   `KEYCLOCK` cambiado a `KEYCLOAK` para reflejar el nombre correcto

## Novedades de la versión 1.13.0

La versión 1.13.0 de Modern Data Platform contiene las siguientes correcciones de errores y mejoras:

### Nuevos Servicios

*   Nuclio FaaS
*   Navegador Firefox
*   Zipkin
*   Servidor Apache Tika
*   RStudio
*   Servidor brillante
*   Servidor MLflow
*   Optuna
*   Panel de Optuna
*   Excalidraw
*   Drools Servidor KIE
*   Drools Business Central Workbench
*   Flink
*   Diseñador Nussknacker
*   Kowl
*   Apache Ignite
*   Servidor Debezium
*   pgAdmin
*   Oracle XE

### Nuevas recetas de libros de cocina

*   [Compatibilidad con la activación del recopilador de datos StreamSets](../cookbooks/recipes/streamsets-oss-activation)

### Actualizaciones de versión

*   Actualizar `Confluent` Para `6.2.0`
*   Actualizar `Marquez` Para `0.19.0`
*   Actualizar `Trino` Para `363`
*   Actualizar `Starburstdata` Para `363-e`
*   Actualizar `DataHub` Para `0.8.15`
*   Actualizar `Minio` Para `RELEASE.2021-06-17T00-10-46Z`
*   Actualizar `ksqlDB` Para `0.20.0`
*   Actualizar `tile38` Para `1.25.2`
*   Actualizar `kcat` Para `1.7.0` (solía ser `kafkacat`)
*   Actualizar `Elasticsearch` Para `7.14.0`
*   Actualizar `Kibana` Para `7.14.0`
*   Actualizar `Cassandra` Para `3.11`
*   Actualizar `DSE-Server` Para `6.8.14`
*   Actualizar `MongoDB` Para `5.0`
*   Actualizar `Neo4J` Para `4.2`
*   Actualizar `Stardog` Para `7.7.1-java11-preview`
*   Actualizar `Stardog-Studio` Para `current`
*   Actualizar `Chronograf` Para `1.9`
*   Actualizar `Telegraf` Para `1.19`
*   Actualizar `Influxdb2` Para `2.0.8` (cambiar a la imagen oficial de Docker)
*   Actualizar `Kudu` Para `1.15`
*   Actualizar `Pinot` Para `0.8.0`
*   Actualizar `Pinot` Para `0.8.0`
*   Actualizar `Prometheus` Para `v2.29.1`
*   Actualizar `Prometheus Pushgateway` Para `v1.4.1`
*   Actualizar `Prometheus Nodeexporter` Para `v1.2.2`
*   Actualizar `Yugabyte` Para `2.4.6.0-b10`
*   Actualizar `GraphDB` Para `9.9.0`
*   Actualizar `Druid` Para `0.21.1`
*   Actualizar `Solr` Para `8.9`
*   Actualizar `Redis` Para `6.2`
*   Actualizar `Memcached` Para `1.6.10`
*   Actualizar `Grafana` Para `8.2.0`
*   Actualizar `QuestDB` Para `6.0.4`
*   Actualizar `Spark` Para `3.1.1`
*   Actualizar `Minio` Para `RELEASE.2021-09-15T04-54-25Z`
*   Actualizar `Axon Server` Para `4.5.7`
*   Actualizar `Hazelcast` Para `5.0`
*   Actualizar `Apache Atlas` Para `2.2.0`
*   Actualizar `LakeFS` Para `0.52.2`
*   Actualizar `Amundsen-Frontend` Para `3.13.0`
*   Actualizar `Amundsen-Metadata` Para `3.10.0`
*   Actualizar `Amundsen-Search` Para `2.11.1`

### Cambios de última hora

*   Cambiado `HAZELCAST_IMDG_xxxxxx` Para `HAZELCAST_xxxxxx`
*   Cambiado `ORACLE_xxxxxx` Para `ORACLE_EE_xxxxxx`
*   Se ha cambiado el valor predeterminado de `KAFKA_CONNECT_nodes` De `2` Para `1`
*   Cambiado `KAFKA_EAGLE_enable` Para `KAFKA_EFAK_enable`

### Mejoras

*   Las páginas de markdown de documentación se copian en la plataforma generada y están disponibles en el visor de markdown
*   Soporte Zookeeper-Less Kafka Setup en modo KRaft (`KAFKA_use_kraft_mode`)
*   Soporte para configurar el `SDC ID` a un valor fijo para StreamSets, de modo que un código de activación siga siendo válido después de volver a crear el `streamsets-1` contenedor docker
*   Cambiar de `cp-enterprise-kafka` Para `cp-server` imagen para Confluent Enterprise
*   Admite múltiples bases de datos dentro de un solo contenedor Posgresql
*   Rebautizar `kafkacat` Para `kcat` (para reflejar el proyecto GitHub)
*   Añadir soporte para Cassandra 3 y Cassandra 4
*   Agregar propiedades de configuración adicionales al Registro de esquemas de confluentes
*   Compatibilidad con la instalación de paquetes de Python al iniciar Jupyter
*   Agregar compatibilidad con el servidor Kafka Connect integrado en ksqlDB Server (establecer `KAFKA_KSQLDB_use_embedded_connect` Para `true`)
*   Agregar interfaz de usuario de Kafka adicional (Kowl)
*   Agregar soporte para Flink
*   Añadir soporte para Drools
*   Añadir soporte para Ignite y Hazelcast
*   Agregar soporte para Otuna y MLFlow
*   Agregar compatibilidad para instalar paquetes de Python al iniciar Jupyter (`JUPYTER_python_packages`)
*   Agregar páginas de detalles para algunos servicios vinculados desde el **Lista de servicios** página representada por el visor de Markdown

### Correcciones

*   Corregir el error "pánico: error de tiempo de ejecución: límites de división fuera del rango" en `schema-registry-ui` y `kafka-connect-ui` al permitir la asignación de la `resolv.conf` en el contenedor. Está habilitado de forma predeterminada.

## Novedades de la versión 1.12.1

La versión 1.12.1 de Modern Data Platform contiene las siguientes correcciones de errores y mejoras:

### Actualizaciones de versión

*   Actualizar `NiFi` Para `1.13.2`
*   Actualizar `DataHub` Para `v0.8.0`
*   Actualizar `ksqlDb` Para `0.18.0`
*   Actualizar `Jupyter` Para `spark-3.1.1`

### Correcciones

*   Arreglar Thrift Server que no funcionó en la versión anterior debido a las imágenes de Spark que se basan en Alpine Linux

## Novedades de la versión 1.12.0

La versión 1.12.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Prometheus Nodeexporter
*   Kafka Lag Exportador
*   Base de datos EventStore
*   Camunda Zeebe + Operar + ZeeQs
*   Hazelcast IMDG + Centro de Gestión
*   Apache Pinot
*   LagoFS
*   EMQ-X MQTT Broker
*   QuestDB Timeeries DB
*   Materializar
*   Interfaz de usuario de Debezium

### Nuevas recetas de libros de cocina

*   [Creación y visualización de ADR con log4brains](../cookbooks/recipes/creating-adr-with-log4brains)
*   [Uso de Dev Simulator Orgin para simular datos de streaming](../cookbooks/recipes/using-dev-simulator-origin)
*   [Uso de la imagen privada (Trivadis) de Oracle XE](../cookbooks/recipes/using-private-oracle-xe-image)
*   [Uso de la imagen privada (Trivadis) de Oracle EE](../cookbooks/recipes/using-private-oracle-ee-image)
*   [Uso de la imagen pública de Oracle XE](../cookbooks/recipes/using-public-oracle-xe-image)

### Actualizaciones de versión

*   Actualizar `Azkarra` Para `0.9.1`
*   Actualizar `Hasura` Para `v2.0.0-alpha.9`
*   Actualizar `Marquez` Para `0.14.2`
*   Actualizar `Grafana` Para `7.5.2`
*   Actualizar `Axonserver` Para `4.5`
*   Actualizar `Streamsheets` Para `2.3-milestone`
*   Actualizar `Streamsets` Para `3.22.2`
*   Actualizar `Trino` Para `356`
*   Actualizar `Starburstdata Presto` Para `356-e.1` (usando nuevo `starburst-enterprise` imagen)
*   Actualizar `PrestoDB` Para `0.253`
*   Actualizar `Ahana` Para `0.253`
*   Actualizar `DataHub` Para `0.7.1`
*   Actualizar `InfluxDB2` Para `2.0.4`
*   Actualizar `Telegraf` Para `1.18`
*   Actualizar `MongoDB` Para `4.4`
*   Actualizar `Elasticsearch` Para `7.12.0`
*   Actualizar `Kibana` Para `7.12.0`
*   Actualizar `Neo4J` Para `4.2.5`
*   Actualizar `ksqlDB` Para `0.17.0`
*   Actualizar `Druid`Para `0.21.0`
*   Actualizar `HiveMQ 4` Para `4.6.1`
*   Actualizar `Airflow` Para `2`

### Mejoras

*   Se agregó soporte para Kafka Monitoring usando JMX y Prometheus / Grafana (con la entrada de este [proyecto github confluente](https://github.com/confluentinc/jmx-monitoring-stacks)
*   use la imagen oficial de Docker de Cloudbeaver y ya no la de trivadis
*   [solución documentend](https://github.com/TrivadisPF/platys/blob/master/documentation/docker-compose-without-internet.md) sobre cómo utilizar una plataforma generada por Platys sin Internet en la infraestructura de destino

## Novedades de la versión 1.11.0

La versión 1.11.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Watchtower añadida
*   Hasura añadido
*   Dgraph añadido
*   Explorador de archivos añadido
*   Se ha añadido la CLI de MinIO MC
*   Kafka UI añadida
*   Interfaz de usuario de Adminio agregada
*   Consola MinIO añadida
*   S3 Manager agregado
*   Filestash añadido
*   SQLPad agregado
*   Malla GraphQL agregada
*   Se ha agregado el Explorador de transmisiones
*   Comunidad thingsboard añadida
*   Cartero añadido
*   Keyclock añadido
*   Microcks añadidos
*   Dataiku Data Science Studio añadido
*   Kafka Eagle agregó
*   Trino agregó
*   GraphDB añadido
*   PostgREST añadido
*   Log4brains añadido

### Nuevas recetas de libros de cocina

*   [Spark con PostgreSQL](../cookbooks/recipes/spark-with-postgresql)
*   [Consulta de datos de S3 (MinIO) mediante MinIO](../cookbooks/recipes/querying-minio-with-trino/)
*   [Consulta de datos de Kafka con Trino](../cookbooks/recipes/querying-kafka-with-trino/)

### Actualizaciones de versión

*   Actualizar `Elasticsearch` Para `7.10.1`
*   Actualizar `Kibana` Para `7.10.1`
*   Actualizar `HiveMQ4`Para `4.5.0`
*   Actualizar `Streamsets Transformer` Para `3.17.0`
*   Actualizar `Axon Server` Para `4.4.5`
*   Cambiar a oficial `Streamsets DataCollector` de `3.21.0`
*   Actualizar `Marquez` Para `0.12.2`
*   Actualizar `Cedalo Management Center` Para `2.1`
*   Actualizar `Confluent Platform` Para `6.1.0`
*   Actualizar `ksqlDB` Para `0.15.0`
*   Actualizar `APICurio Registry` Para `1.3.2`
*   Actualizar `Starburstdata Presto` Para `350-e.5`
*   Actualizar `Ahana PrestoDB` Para `0.249`
*   Actualizar `PrestoDB` Para `0.249`
*   Actualizar `DataHub` Para `0.7.0`

### Mejoras

*   Permitir la configuración de las bibliotecas de etapas adicionales de StreamSets para instalarlas al iniciar StreamSets (ya no usamos las imágenes de Docker de Trivadis)
*   Admite la instalación automática de canalizaciones de StreamSets al iniciar StreamSets
*   Soporte para Trino agregado (renombrado proyecto PrestoSQL) en paralelo a PrestoDB (la otra bifurcación de Presto)

## Novedades de la versión 1.10.0

La versión 1.10.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Flujo de datos de Spring Cloud

### Nuevas recetas de libros de cocina

*   [Uso de kafka Connect Connector adicional](../cookbooks/recipes/using-additional-kafka-connect-connector)
*   [UDF y ksqlDB personalizados](../cookbooks/recipes/custom-udf-and-ksqldb)
*   [Uso de proxy MQTT confluente](../cookbooks/recipes/using-mqtt-proxy/)
*   [Spark con S3 interno (usando en minIO)](..cookbooks//recipes/spark-with-internal-s3)
*   [Spark con S3 externo](../cookbooks/recipes/spark-with-extern-s3)

### Actualizaciones de versión

*   Actualizar `ksqlDB` Para `0.14.0`
*   Actualizar `Streamsheets` Para `2.2`
*   Actualizar `Zeppelin` Para `0.9.0`
*   Actualizar `Confluent` Para `6.0.1`
*   Actualizar `Presto` Para `348-e`
*   Actualizar `Stardog` Para `7.4.5-java11-preview` y `Stardog Studio` Para `1.30.0`

### Mejoras

*   Agregue la opción para cambiar el puerto del Visor de rebajas a `8000`, con el valor predeterminado que sigue siendo el puerto `80`.
*   Agregue una opción para utilizar el contenido de la carpeta `DOCKER_HOST_IP` en lugar de la `PUBLIC_IP` variable para los enlaces web a los servicios.
*   cambio `minio` imagen a la de `bitnami`, que permite crear buckets al inicio del servicio
*   permitir la configuración de `spark.max.cores` y `spark.executor.memory` en Zeppelin
*   permitir la configuración de `SPARK_MASTER_OPTS` y `SPARK_WORKER_OPTS`, `SPARK_WORKER_CORES`, `SPARK_WORKER_MEMORY` para Spark
*   Se ha añadido compatibilidad para cambiar entre Spark 2 y Spark 3
*   cambiar el valor predeterminado de `KAFKA_delete_topic_enable` Para `true`
*   agregar `KAFKA_SCHEMA_REGISTRY_UI_use_public_ip` Para cambiar entre la dirección IP del host público y de Docker para la interfaz de usuario del Registro de esquemas
*   Hacer que el usuario administrador y el usuario "normal" sean configurables en Zeppelin
*   Los archivos de configuración para Zeppelin ya no se asignan desde el `conf` en el contenedor, ahora está "preconstruido" en la nueva imagen de docker de zepelín.
*   Se ha añadido compatibilidad con Spark 3.0
*   Agregar compatibilidad para habilitar Zeppelin Cron Scheduler en cada bloc de notas

### Corrección de errores

*   corregir error con S3 interno (minIO) introducido en `1.9.0`

## Novedades de la versión 1.9.0

La versión 1.9.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Visión de Redis
*   WebTTY
*   Markdown Viewer (habilitado de forma predeterminada, que representa la documentación sobre la plataforma)
*   Registro NiFi

### Actualizaciones de versión

*   Cambio `Redis` a la imagen bitnami
*   Actualizar `DataHub` Para `0.6.1`
*   Actualizar `Portainer` Para `2.0.0`
*   Actualizar `CAdvisor` Para `v0.36.0`
*   Actualizar `Marquez` Para `0.11.3` y Marquez UI a `0.7.0`
*   Actualizar `Apache NiFi` Para `1.12.1`
*   Actualizar `StreamSets Data Collector` Para `3.19.0`
*   Actualizar `ksqlDB` Para `0.13.0`
*   Actualizar `Hue` Para `4.8.0`
*   Actualizar `Amundsen-Frontend` Para `3.0.0`
*   Actualizar `Amundsen-Metadata` Para `3.0.0`
*   Actualizar `Amundsen-Search` Para `2.4.1`
*   Actualizar `Presto` Para `347-e`
*   Actualizar `Dremio` Para `4.9`
*   Actualizar `MongoDB` Para `4.4.2`
*   Actualizar `MongoDB` Para `4.2.0`
*   Actualizar `InfluxDB 2.0` Para `v2.0.2`
*   Actualizar `Druid` Para `0.20.0`
*   Actualizar `Memcached` Para `1.6.9`
*   Actualizar `Kudu` Para `1.13`
*   Actualizar `Prometheus` Para `v2.23.0` y `Prometheus-Pushgateway` Para `v1.3.0`
*   Actualizar `Tile38` Para `1.22.5`
*   Actualizar `Grafana` Para `7.3.4`
*   Actualizar `Stardog` Para `7.4.4-java11-preview` y `Stardog Studio` Para `1.29.1`
*   Actualizar `Yugabyte` Para `2.5.0.0-b2`
*   Actualizar `Axon` Para `4.4.5`
*   Actualizar `Presto` Para `346-e`
*   Actualizar `Dremio` Para `11.0`
*   Actualizar `HiveMQ3` Para `3.4.7` y `HiveMQ4` Para `4.4.3`
*   Actualizar `Vault` Para `1.6.0`
*   Actualizar `Airflow` Para `1.10.13`
*   Actualizar `Atlas` Para `2.1.0`
*   Actualizar `Ranger` Para `2.1.0`
*   Actualizar `Mosquitto` Para `2.0`
*   Actualizar `Streamsheets` Para `2.1-milestone`

### Mejoras

*   soporte para la configuración de Master/Slave Redis
*   Establezca automáticamente el nombre de la red de Docker en el valor de la `platform-name` propiedad de la `config.yml`
*   Permitir agregar `ConfigProvider` clases a la `kafka-connect` que admite el uso de variables en configuraciones de conectores que se resuelven dinámicamente cuando se (re)inicia el conector.
*   Representación de archivos de markdown con información sobre la plataforma generada
*   Agregar propiedad de configuración a `ksqldb-server` Para habilitar la nueva funcionalidad de supresión y utilizar un archivo de consulta
*   soporte externo `Kafka` cluster (estaba en versión preliminar en 1.8) y `S3` almacenamiento de objetos con el nuevo `external` sección
*   admite la configuración de la clave de acceso y la clave secreta que se utilizarán para `minio` En `config.yml` Utilizando los mismos valores predeterminados que antes
*   admite la asignación de volúmenes para la carpeta de datos y registros de `nifi` servicio

### Cambios de última hora

*   Actualizar la versión de docker-compose a `3.5` (requiere Docker Engine versión 17.12.0 y superior)
*   Volumen asignado `data` carpeta en Streamsets (`STREAMSETS_volume_map_data=true`) ahora está asignado a `container-volume/streamsets-1/data` y ya no a `container-volume/streamsets-1`
*   Ya no utilice el `KAFKA_bootstrap_servers` para configurar Kafka externo, pero `external['KAFKA_enable']` propiedad en `config.yml`

### Correcciones

*   Corrección del error al utilizar el `STREAMSETS_volume_map_data` característica

## Novedades de la versión 1.8.0

La versión 1.8.0 de Modern Data Platform contiene los siguientes nuevos servicios y mejoras:

### Nuevos Servicios

*   Registro Apicurio
*   Aplastando Dashbaord
*   Panel de control de Tipboard
*   Panel de control del tablón de gráficos
*   Arroyos de Azkarra

### Actualizaciones de versión

*   actualizar `DataHub` Para `0.5.0-beta`
*   actualizar `StreamSheets` Para `2.0-milestone`
*   actualizar `StreamSets` Para `3.18.1`
*   actualizar `Confluent Platfrom` Para `6.0.0`
*   actualizar `ksqlDB` Para `0.12.0`

### Mejoras

*   hacer que el usuario, la contraseña y la base de datos de Postgreqsql sean configurables
*   configuración de soporte de `KAFKA_MQTTPROXY_topic_regex_list` en `KAFKA_MQTTPROXY`
*   crear automáticamente el `default-bucket` en Minio si `MINIO_ENABLE` es `true`
*   admite varias propiedades adicionales del corredor de Kafka, como `KAFKA_message_timestamp_type`, `KAFKA_replica_selector_class`, `KAFKA_min_insync_replicas`, `KAFKA_log_segement_bytes`, `KAFKA_log_retention_ms`, `KAFKA_log_retention_hours`, `KAFKA_log_retention_bytes`, `KAFKA_compression_type` y `KAFKA_confluent_log_placement_constraints`
*   soporta Kafka Tiered Storage con `confluent.tier.xxxx` Propiedades
*   apoyo `STREAMSETS_volume_map_security_policy` propiedad en `streamsets` servicio

### Cambios de última hora

*   El usuario predeterminado para el servicio Postgresql se ha cambiado a `demo` y la base de datos para `demodb`.
*   cambiar el nombre del servicio de `redis` Para `redis-1`
*   cambiar propiedad ` RANGER_POSTGRESQL_volume_map_data  ` Para `RANGER_postgresql_volume_map_data` para el `RANGER` servicio

### Correcciones

*   apoyo para el `hive` Se ha corregido la opción en SPARK para que Spark pueda usar el metaalmacén de Hive en lugar del metaalmacén integrado predeterminado

## Novedades de la versión 1.7.0

**Nota:** Tiene que instalar la versión más reciente de [`platys`](http://github/trivadispf/platys) (> 2.3.0) para utilizar esta nueva versión de la pila de plataformas.

La versión 1.7.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Redash
*   Memcached
*   Stardog & Stardog Estudio

### Mejoras / Cambios

*   Se agregó la supervisión de JMX a los servicios ksqldb-server-X
*   Permitir la habilitación de la autenticación básica en el servicio Administrador de clústeres para Apache Kafka (CMAK)
*   refactorizó las propiedades de platys (`platform-stack` y `platform-stack-version`) para coincidir con [versión 2.3.0](https://github.com/TrivadisPF/platys/blob/master/documentation/changes.md#whats-new-in-230) de `platys`.

## Novedades de la versión 1.6.0

La versión 1.6.0 de Modern Data Platform contiene los siguientes nuevos servicios y mejoras:

### Nuevos Servicios

*   Interfaz de usuario de quix Database (estilo Notebook)
*   Penthao Webspoon
*   Hawtio
*   ConejoMQ
*   Cloudbeaver
*   Swagger Editor y Swagger UI
*   Kafkacat
*   StreamSheets
*   Replicador confluente
*   Presto CLI
*   Apache Ranger (vista previa)

### Mejoras / Cambios

*   Solo se muestra la salida detallada del generador docker-compose-templer si el `-v` la bandera se pasa en el `platys` línea de comandos
*   Actualizar `ksqlDB` versión predeterminada a la más reciente `0.9.0`
*   Admite la instalación automática de conectores de Confluent Hub en Kafka Connect al iniciarse
*   Compatibilidad con clústeres de Presto junto con una sola instancia de Presto
*   Soporte para bifurcaciones Prestosql y Prestodb de código abierto Presto, así como la nueva suscripción a Ahana Prestodb

## Novedades de la versión 1.5.2

1.5.2 es solo una versión fija sin nuevos servicios.

### Mejoras / Cambios

*   agregar la posibilidad de especificar un repositorio privado de maven para descargar paquetes de maven en Spark, Livy y Zeppelin
*   Permitir especificar propiedades adicionales del entorno de tiempo de ejecución en `spark-defaults.conf`

### Correcciones

*   Generación de arreglos del servicio Burrow y Zookeeper Navigator
*   Corregir el vínculo que no funciona a la interfaz de usuario de Spark desde la interfaz de usuario maestra de Spark

## Novedades de la versión 1.5.1

1.5.1 es solo una versión fija sin nuevos servicios.

### Correcciones

*   Reparar el servicio Hadoop

## Novedades de la versión 1.5.0

La versión 1.5.0 de Modern Data Platform contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Oracle XE (solo a través de una imagen de Docker privada) agregado
*   Oracle EE (solo a través de una imagen privada de Docker) agregado
*   Se ha agregado Oracle REST Data Service (solo a través de una imagen privada de Docker)
*   Hashicorp Vault añadido
*   Base de datos Yugabyte agregada
*   Márquez agregó
*   Apache Ranger añadido

### Mejoras / Cambios

*   cambio `drill`, `dremio` y `presto` para incluir el número de instancia de servicio, es decir, `<service>-1` Para prepararse para admitir varias instancias
*   compatibilidad con el cambio de la zona horaria a nivel mundial para todas las imágenes de Docker (`use_timezone`)
*   nueva opción de configuración (` private_docker_repository_name  `) para cambiar el repositorio privado que se va a utilizar para las imágenes privadas de Docker
*   Se han corregido los puertos JMX del servicio Kafka
*   Se ha agregado compatibilidad con propiedades adicionales de Kafka

## Novedades de la versión 1.4.0

La versión 1.4.0 de Modern Analytical Data Platform Stack contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Se ha añadido la interfaz de usuario de Kafka Topics
*   Apache Drill añadido
*   DataHub agregado
*   Apache Druid agregado (actualmente solo admite Sandbox de un solo servidor)
*   Apache Superset añadido

### Mejoras / Cambios

*   Las interfaces de usuario de Elastisearch (Kibana, DejaVu, Cerebro, ElasticHQ) son independientes de Elasticsearch

## Novedades de la versión 1.3.0

La versión 1.3.0 de Modern Analytical Data Platform Stack contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Flujo de aire Apache
*   Apache Sqoop (anteriormente parte de `hadoop-client` servicio)
*   Code-Server (VS Code IDE en el navegador)

### Mejoras / Cambios

*   Algunos primeros tutoriales simples agregados, que muestran cómo usar los servicios
*   Las imágenes de Hadoop cambiaron a las de Big Data Europe
*   Service Kafka Manger ahora es CMAK (debido al cambio de nombre en Yahoo GitHub)
*   KafkaHQ ha sido renombrado a AKHQ por el desarrollador y ahora usamos esta imagen

## Novedades de la versión 1.2.0

La versión 1.2.0 de Modern Analytical Data Platform Stack contiene los siguientes servicios y mejoras nuevos:

### Nuevos Servicios

*   Confluent Enterprise como edición para Kafka
*   Borde del recopilador de datos de conjuntos de secuencias
*   Transformador de conjuntos de arroyos
*   Apache NiFi
*   varios servicios de Jupyter
*   Nodo RED
*   Pila de ticks de datos de afluencia (influxdb, cronógrafo, kapacitor)
*   Afluencia DB 2.0-alfa

### Mejoras / Cambios

*   Refactorizar algunos puertos a los puertos originales

*   Cambiar el nombre de todas las propiedades desde `XXXX_enabled` Para `XXXX_enable`

*   Cambie el nombre de todas las propiedades desde 'XXXX_yyyy_enabled`  to 'XXXX_YYYY_enabled ` para distinguir claramente entre producto/servicio y las propiedades

*   Rebautizar `connect-n` servicio a `kafka-connect-n` para ser más claros

*   Rebautizar `broker-n` servicio a `kafka-n` para ser más claros

*   Actualizar a Confluent Platform 5.4.0

*   Agregar [concepto de edición](service-design.md) para los servicios de Kafka y Jupyter
