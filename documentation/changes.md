# `modern-data-platform` - What's new?

See [Upgrade to a new platform stack version](https://github.com/TrivadisPF/platys/blob/master/documentation/upgrade-platform-stack.md) for how to upgrade to newer version.

## What's new in 1.13.0

The Modern Data Platform version 1.13.0 contains the following bug fixes and enhancements:

### New Services

 * Nuclio FaaS
 * Firefox Browser
 * Zipkin
 * Apache Tika Server
 * RStudio
 * Shiny Server
 * MLflow Server
 * Optuna
 * Optuna Dashboard
 * Excalidraw
 * Drools KIE Server
 * Drools Business Central Workbench
 * Flink
 * Nussknacker Designer
 * Kowl
 * Apache Ignite
 * Debezium Server
 * pgAdmin
 * Oracle XE

### New Cookbook Recipes

 * [Support StreamSets Data Collector Activation](../cookbooks/recipes/streamsets-oss-activation)

### Version upgrades 

 * Update `Confluent` to `6.2.0` 
 * Update `Marquez` to `0.19.0` 
 * Update `Trino` to `363`
 * Update `Starburstdata` to `363-e`
 * Update `DataHub` to `0.8.15`
 * Update `Minio` to `RELEASE.2021-06-17T00-10-46Z`
 * Update `ksqlDB` to `0.20.0`
 * Update `tile38` to `1.25.2`
 * Update `kcat` to `1.7.0` (used to be `kafkacat`)
 * Update `Elasticsearch` to `7.14.0`
 * Update `Kibana` to `7.14.0`
 * Update `Cassandra` to `3.11`
 * Update `DSE-Server` to `6.8.14`
 * Update `MongoDB` to `5.0`
 * Update `Neo4J` to `4.2`
 * Update `Stardog` to `7.7.1-java11-preview`
 * Update `Stardog-Studio` to `current`
 * Update `Chronograf` to `1.9`
 * Update `Telegraf` to `1.19`
 * Update `Influxdb2` to `2.0.8` (switch to official docker image)
 * Update `Kudu` to `1.15`
 * Update `Pinot` to `0.8.0`
 * Update `Pinot` to `0.8.0`
 * Update `Prometheus` to `v2.29.1`
 * Update `Prometheus Pushgateway` to `v1.4.1`
 * Update `Prometheus Nodeexporter` to `v1.2.2`
 * Update `Yugabyte` to `2.4.6.0-b10`
 * Update `GraphDB` to `9.9.0`
 * Update `Druid` to `0.21.1`
 * Update `Solr` to `8.9`
 * Update `Redis` to `6.2`
 * Update `Memcached` to `1.6.10`
 * Update `Grafana` to `8.2.0`
 * Update `QuestDB` to `6.0.4`
 * Update `Spark` to `3.1.1`
 * Update `Minio` to `RELEASE.2021-09-15T04-54-25Z`
 * Update `Axon Server` to `4.5.7`
 * Update `Hazelcast` to `5.0`
 * Update `Apache Atlas` to `2.2.0`
 * Update `LakeFS` to `0.52.2`
 * Update `Amundsen-Frontend` to `3.13.0`
 * Update `Amundsen-Metadata` to `3.10.0`
 * Update `Amundsen-Search` to `2.11.1`

### Breaking Changes

 * Changed `HAZELCAST_IMDG_xxxxxx` to `HAZELCAST_xxxxxx` 
 * Changed `ORACLE_xxxxxx` to `ORACLE_EE_xxxxxx` 
 * Changed default of `KAFKA_CONNECT_nodes` from `2` to `1`
 * Changed `KAFKA_EAGLE_enable` to `KAFKA_EFAK_enable`

### Enhancements 

 * Documentation markdown pages are copied into the generated platform and available in the markdown viewer 
 * Support Zookeeper-Less Kafka Setup in KRaft mode (`KAFKA_use_kraft_mode`)
 * Support setting the `SDC ID` to a fixed value for StreamSets, so that an Activation code is still valid after recreating the `streamsets-1` docker container
 * Switch from `cp-enterprise-kafka` to `cp-server` image for Confluent Enterprise
 * Support multiple databases within one single Posgresql container
 * Rename `kafkacat` to `kcat` (to reflect the GitHub project)
 * Add support for both Cassandra 3 and Cassandra 4
 * Add additional configuration properties to Confluent Schema Registry
 * Support installing Python packages when starting Jupyter
 * Add support for embedded Kafka Connect server in ksqlDB Server (set `KAFKA_KSQLDB_use_embedded_connect` to `true`)
 * Add additional Kafka UI (Kowl)
 * Add support for Flink
 * Add support for Drools
 * Add support for Ignite and Hazelcast
 * Add support for Otuna and MLFlow
 * Add support for installing Python packages when starting Jupyter (`JUPYTER_python_packages`)
 * Add detail pages for some services linked from the **List of Services** page rendered by the Markdown viewer

### Bug Fixes 

  * fix error "panic: runtime error: slice bounds out of range" in `schema-registry-ui` and `kafka-connect-ui` by allowing the mapping the `resolv.conf` into the container. It is enabled by default.


## What's new in 1.12.1

The Modern Data Platform version 1.12.1 contains the following bug fixes and enhancements:

### Version upgrades  

 * Update `NiFi` to `1.13.2` 
 * Update `DataHub` to `v0.8.0` 
 * Update `ksqlDb` to `0.18.0` 
 * Update `Jupyter` to `spark-3.1.1`

### Bug Fixes 
 
 * Fix Thrift Server which did not work in previous release due to Spark images which are based on Alpine Linux

## What's new in 1.12.0

The Modern Data Platform version 1.12.0 contains the following new services and enhancements:

### New Services

 * Prometheus Nodeexporter
 * Kafka Lag Exporter
 * EventStore DB
 * Camunda Zeebe + Operate + ZeeQs
 * Hazelcast IMDG + Managment Center
 * Apache Pinot
 * LakeFS
 * EMQ-X MQTT Broker
 * QuestDB Timeseries DB
 * Materialize
 * Debezium UI
 
### New Cookbook Recipes
 
 * [Creating and visualizing ADRs with log4brains](../cookbooks/recipes/creating-adr-with-log4brains)
 * [Using Dev Simulator Orgin to simulate streaming data](../cookbooks/recipes/using-dev-simulator-origin)
 * [Using private (Trivadis) Oracle XE image](../cookbooks/recipes/using-private-oracle-xe-image)    
 * [Using private (Trivadis) Oracle EE image](../cookbooks/recipes/using-private-oracle-ee-image)
 * [Using public Oracle XE image](../cookbooks/recipes/using-public-oracle-xe-image)
 
### Version upgrades  

 * Update `Azkarra` to `0.9.1`
 * Update `Hasura` to `v2.0.0-alpha.9`
 * Update `Marquez` to `0.14.2` 
 * Update `Grafana` to `7.5.2`
 * Update `Axonserver` to `4.5`
 * Update `Streamsheets` to `2.3-milestone`
 * Update `Streamsets` to `3.22.2`
 * Update `Trino` to `356`
 * Update `Starburstdata Presto` to `356-e.1` (using new `starburst-enterprise` image)
 * Update `PrestoDB` to `0.253`
 * Update `Ahana` to `0.253`
 * Update `DataHub` to `0.7.1`
 * Update `InfluxDB2` to `2.0.4`
 * Update `Telegraf` to `1.18`
 * Update `MongoDB` to `4.4`
 * Update `Elasticsearch` to `7.12.0`
 * Update `Kibana` to `7.12.0`
 * Update `Neo4J` to `4.2.5`
 * Update `ksqlDB` to `0.17.0`
 * Update `Druid`to `0.21.0`
 * Update `HiveMQ 4` to `4.6.1`
 * Update `Airflow` to `2`

### Enhancements 
  
 * Added support for Kafka Monitoring using JMX and Prometheus/Grafana (with input from this [confluent github project](https://github.com/confluentinc/jmx-monitoring-stacks)
 * use official Cloudbeaver docker image and no longer the trivadis one
 * [solution documentend](https://github.com/TrivadisPF/platys/blob/master/documentation/docker-compose-without-internet.md) on how to use a Platys-generated Platform without internet on the target infrastructure
 
## What's new in 1.11.0

The Modern Data Platform version 1.11.0 contains the following new services and enhancements:

### New Services

 * Watchtower added
 * Hasura added
 * Dgraph added
 * File Browser added
 * MinIO MC CLI added
 * Kafka UI added
 * Adminio UI added
 * MinIO Console added
 * S3 Manager added
 * Filestash added
 * SQLPad added
 * GraphQL Mesh added
 * Streams Explorer added
 * Thingsboard Community added
 * Postman added
 * Keyclock added
 * Microcks added
 * Dataiku Data Science Studio added
 * Kafka Eagle added
 * Trino added
 * GraphDB added
 * PostgREST added
 * Log4brains added
 
### New Cookbook Recipes

 * [Spark with PostgreSQL](../cookbooks/recipes/spark-with-postgresql) 
 * [Querying S3 data (MinIO) using MinIO](../cookbooks/recipes/querying-minio-with-trino/)
 * [Querying Kafka data using Trino](../cookbooks/recipes/querying-kafka-with-trino/)
 
### Version upgrades  

* Update `Elasticsearch` to `7.10.1`
* Update `Kibana` to `7.10.1`
* Update `HiveMQ4`to `4.5.0`
* Update `Streamsets Transformer` to `3.17.0`
* Update `Axon Server` to `4.4.5`
* Switch to official `Streamsets DataCollector` of `3.21.0`
* Update `Marquez` to `0.12.2`
* Update `Cedalo Management Center` to `2.1` 
* Update `Confluent Platform` to `6.1.0`
* Update `ksqlDB` to `0.15.0`
* Update `APICurio Registry` to `1.3.2`
* Update `Starburstdata Presto` to `350-e.5`
* Update `Ahana PrestoDB` to `0.249`
* Update `PrestoDB` to `0.249`
* Update `DataHub` to `0.7.0`
 
### Enhancements 
* Allow configuring the additional StreamSets stage libraries to be installed upon starting StreamSets (we no longer use the Trivadis docker images)
* Support automatically installing StreamSets pipelines upon starting StreamSets
* Support for Trino added (renamed PrestoSQL project) in parallel to PrestoDB (the other fork of Presto)

## What's new in 1.10.0

The Modern Data Platform version 1.10.0 contains the following new services and enhancements:


### New Services
 * Spring Cloud Data Flow

### New Cookbook Recipes
 * [Using additional Kafka Connect Connector](../cookbooks/recipes/using-additional-kafka-connect-connector) 
 * [Custom UDF and ksqlDB](../cookbooks/recipes/custom-udf-and-ksqldb) 
 * [Using Confluent MQTT Proxy](../cookbooks/recipes/using-mqtt-proxy/)
 * [Spark with internal S3 (using on minIO)](..cookbooks//recipes/spark-with-internal-s3)
 * [Spark with external S3](../cookbooks/recipes/spark-with-extern-s3)

### Version upgrades  

* Update `ksqlDB` to `0.14.0`
* Update `Streamsheets` to `2.2`
* Update `Zeppelin` to `0.9.0`
* Update `Confluent` to `6.0.1`
* Update `Presto` to `348-e`
* Update `Stardog` to `7.4.5-java11-preview` and `Stardog Studio` to `1.30.0`
 
### Enhancements 

* add the option to change the port of the markdown viewer to `8000`, with the default still being port `80`. 
* add an option to use the content of the `DOCKER_HOST_IP` variable instead of the `PUBLIC_IP` variable for the web links to services.
* change `minio` image to the one from `bitnami`, which allows for creating buckets upon start of the service
* allow configuration of `spark.max.cores` and `spark.executor.memory` in Zeppelin
* allow configuration of `SPARK_MASTER_OPTS` and `SPARK_WORKER_OPTS`, `SPARK_WORKER_CORES`, `SPARK_WORKER_MEMORY` for Spark
* support for switching between Spark 2 and Spark 3 added
* change default of `KAFKA_delete_topic_enable` to `true`
* add `KAFKA_SCHEMA_REGISTRY_UI_use_public_ip` to change between public and docker host IP Address for Schema Registry UI
* make admin user and "normal" user configurable in Zeppelin
* configuration files for Zeppelin are no longer mapped from the `conf` folder into the container, it is now "prebuild" into the new zeppelin docker image.
* support for Spark 3.0 added
* add support for enabling Zeppelin cron scheduler on each notebook

### Bug fix

* fix bug with internal S3 (minIO) introduced in `1.9.0`


## What's new in 1.9.0

The Modern Data Platform version 1.9.0 contains the following new services and enhancements:

### New Services

* Redis Insight
* WebTTY
* Markdown Viewer (enabled by default, rendering documentation about the platform)
* NiFi Registry

### Version upgrades  

* Change `Redis` to bitnami image
* Update `DataHub` to `0.6.1`
* Update `Portainer` to `2.0.0`
* Update `CAdvisor` to `v0.36.0`
* Update `Marquez` to `0.11.3` and Marquez UI to `0.7.0`
* Update `Apache NiFi` to `1.12.1`
* Update `StreamSets Data Collector` to `3.19.0`
* Update `ksqlDB` to `0.13.0`
* Update `Hue` to `4.8.0`
* Update `Amundsen-Frontend` to `3.0.0`
* Update `Amundsen-Metadata` to `3.0.0`
* Update `Amundsen-Search` to `2.4.1`
* Update `Presto` to `347-e`
* Update `Dremio` to `4.9`
* Update `MongoDB` to `4.4.2`
* Update `MongoDB` to `4.2.0`
* Update `InfluxDB 2.0` to `v2.0.2`
* Update `Druid` to `0.20.0`
* Update `Memcached` to `1.6.9`
* Update `Kudu` to `1.13`
* Update `Prometheus` to `v2.23.0` and `Prometheus-Pushgateway` to `v1.3.0`
* Update `Tile38` to `1.22.5`
* Update `Grafana` to `7.3.4`
* Update `Stardog` to `7.4.4-java11-preview` and `Stardog Studio` to `1.29.1`
* Update `Yugabyte` to `2.5.0.0-b2`
* Update `Axon` to `4.4.5`
* Update `Presto` to `346-e`
* Update `Dremio` to `11.0`
* Update `HiveMQ3` to `3.4.7` and `HiveMQ4` to `4.4.3`
* Update `Vault` to `1.6.0`
* Update `Airflow` to `1.10.13`
* Update `Atlas` to `2.1.0`
* Update `Ranger` to `2.1.0`
* Update `Mosquitto` to `2.0`
* Update `Streamsheets` to `2.1-milestone`

### Enhancements 

* support Master/Slave Redis setup
* automatically set the name of the docker network to the value of the `platform-name` property from the `config.yml`
* Allow adding `ConfigProvider` classes to the `kafka-connect` service supporting the use of variables in connector configurations that are dynamically resolved when the connector is (re)started.
* Rendering markdown files with information on the generated platform
* Add configuration property to `ksqldb-server` to enable new suppress functionality and to use a query file
* support external `Kafka` cluster (was in preview in 1.8) and `S3` object storage with the new `external` section
* support setting access key and secret key to be used for `minio` in the `config.yml` using the same default values as before
* support volume mapping for data and logs folder of `nifi` service

### Breaking Changes

* Update docker-compose version to `3.5` (requiring Docker Engine version 17.12.0 and higher)
* Volume mapped `data` folder in Streamsets (`STREAMSETS_volume_map_data=true`) is now mapped to `container-volume/streamsets-1/data` and no longer to `container-volume/streamsets-1`
* No longer use the `KAFKA_bootstrap_servers` to configure external kafka, but `external['KAFKA_enable']` property in `config.yml`

### Bug Fixes 

* Fix for the error when using the `STREAMSETS_volume_map_data` feature

## What's new in 1.8.0

The Modern Data Platform version 1.8.0 contains the following new services and enhancements:

### New Services

* Apicurio Registry
* Smashing Dashbaord
* Tipboard Dashboard
* Chartboard Dashboard
* Azkarra Streams

### Version upgrades  
* update `DataHub` to `0.5.0-beta`
* update `StreamSheets` to `2.0-milestone`
* update `StreamSets` to `3.18.1`
* update `Confluent Platfrom` to `6.0.0`
* update `ksqlDB` to `0.12.0`

### Enhancements 
* make Postgreqsql user, password and database configurable
* support configuration of `KAFKA_MQTTPROXY_topic_regex_list` on `KAFKA_MQTTPROXY`
* automatically create the `default-bucket` in Minio if `MINIO_ENABLE` is `true`
* support various additional Kafka broker properties such as `KAFKA_message_timestamp_type`, `KAFKA_replica_selector_class`, `KAFKA_min_insync_replicas`, `KAFKA_log_segement_bytes`, `KAFKA_log_retention_ms`, `KAFKA_log_retention_hours`, `KAFKA_log_retention_bytes`, `KAFKA_compression_type` and `KAFKA_confluent_log_placement_constraints`
* support Kafka Tiered Storage with `confluent.tier.xxxx` properties
* support `STREAMSETS_volume_map_security_policy` property in `streamsets` service

### Breaking Changes

* default user for the Postgresql service has been changed to `demo` and the database to `demodb`.
* change service name of `redis` to `redis-1`
* change property `RANGER_POSTGRESQL_volume_map_data ` to `RANGER_postgresql_volume_map_data` for the `RANGER` service

### Bug Fixes 
* support for the `hive` option in SPARK has been fixed so that Spark can use the Hive Metastore instead of the default, built-in metastore

## What's new in 1.7.0

**Note:** you have to install the latest version of [`platys`](http://github/trivadispf/platys) (> 2.3.0)  to use this new version of the platform stack. 

The Modern Data Platform version 1.7.0 contains the following new services and enhancements:

### New Services

* Redash
* Memcached
* Stardog & Stardog Studio

### Enhancements / Changes

* Added JMX monitoring to ksqldb-server-X services
* Allow enabling basic authentication in Cluster Manager for Apache Kafka (CMAK) service
* refactored the platys properties (`platform-stack` and `platform-stack-version`) to match with [version 2.3.0](https://github.com/TrivadisPF/platys/blob/master/documentation/changes.md#whats-new-in-230) of `platys`.

## What's new in 1.6.0

The Modern Data Platform version 1.6.0 contains the following new services and enhancements:

### New Services

* Quix Database UI (Notebook-style)
* Penthao Webspoon
* Hawtio
* RabbitMQ
* Cloudbeaver
* Swagger Editor & Swagger UI
* Kafkacat
* StreamSheets
* Confluent Replicator
* Presto CLI
* Apache Ranger (preview)

### Enhancements / Changes

* Only display verbose output from docker-compose-templer generator if the `-v` flag is passed on the `platys` command line
* Upgrade `ksqlDB` default version to latest `0.9.0`
* Support automatic installation of Confluent Hub connectors into Kafka Connect upon startup
* Support for Presto Clusters together with single Presto instance
* Support for Prestosql and Prestodb open source Presto forks as well as new Ahana Prestodb subscription

## What's new in 1.5.2

1.5.2 is just a but fix release with no new services.

### Enhancements / Changes

* add possibility to specify a private maven repository for downloading maven packages in Spark, Livy and Zeppelin
* Allow to specify additional runtime environment properties in `spark-defaults.conf`

### Bug Fixes

* Fix generation of Burrow and Zookeeper Navigator service
* Fix the non-working link to Spark UI from the Spark Master UI

## What's new in 1.5.1

1.5.1 is just a but fix release with no new services.

### Bug Fixes

* Fix Hadoop service

## What's new in 1.5.0

The Modern Data Platform version 1.5.0 contains the following new services and enhancements:

### New Services

* Oracle XE (only through private docker image) added
* Oracle EE (only through private docker image) added
* Oracle REST Data Service (only through private docker image) added
* Hashicorp Vault added 
* Yugabyte Database added 
* Marquez added
* Apache Ranger added

### Enhancements / Changes

* change `drill`, `dremio` and `presto` to include the service instance number, i.e. `<service>-1` to prepare to support multiple instances
* support for changing the timezone globally for all docker images (`use_timezone`)
* new configuration setting (`private_docker_repository_name `) for changing the the private repository to use for private docker images
* fixed the JMX ports of the Kafka service
* support for additional Kafka properties added

## What's new in 1.4.0

The Modern Analytical Data Platform Stack version 1.4.0 contains the following new services and enhancements:

### New Services

* Kafka Topics UI added
* Apache Drill added
* DataHub added
* Apache Druid added (currently supports only single-server Sandbox)
* Apache Superset added

### Enhancements / Changes

* Elastisearch UIs (Kibana, DejaVu, Cerebro, ElasticHQ) are independent of Elasticsearch

## What's new in 1.3.0

The Modern Analytical Data Platform Stack version 1.3.0 contains the following new services and enhancements:

### New Services

* Apache Airflow
* Apache Sqoop (previously part of `hadoop-client` service)
* Code-Server (VS Code IDE in Browser) 

### Enhancements / Changes

* Some first simple Tutorials added, showing how to use the services
* Hadoop images changed to the ones from Big Data Europe
* Service Kafka Manger is now CMAK (due to the name change at Yahoo GitHub)
* KafkaHQ has been renamed to AKHQ by the developer and we now use this image

## What's new in 1.2.0

The Modern Analytical Data Platform Stack version 1.2.0 contains the following new services and enhancements:

### New Services

* Confluent Enterprise as an Edition for Kafka
* Streamsets Data Collector Edge
* Streamsets Transformer
* Apache NiFi
* various Jupyter services
* Node RED
* Influx Data Tick Stack (influxdb, chronograf, kapacitor)
* Influx DB 2.0-alpha

### Enhancements / Changes

* refactor some ports back to original ports
* rename all properties from `XXXX_enabled` to `XXXX_enable` 
* rename all properties from 'XXXX_yyyy_enabled` to 'XXXX_YYYY_enabled` to clearly distinguish between product/service and the properties 
* Rename `connect-n` service to `kafka-connect-n` to be more clear
* Rename `broker-n` service to `kafka-n` to be more clear
* Upgrade to Confluent Platform 5.4.0
* Add [concept of edition](service-design.md) for Kafka and Jupyter services

	