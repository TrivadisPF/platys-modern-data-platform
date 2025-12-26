# `modern-data-platform` - What's new?

See [Upgrade to a new platform stack version](https://github.com/TrivadisPF/platys/blob/master/documentation/upgrade-platform-stack.md) for how to upgrade to newer version.

## What's new in 1.19.0

The Modern Data Platform version 1.18.0 contains the following bug fixes and enhancements:

### New Services

 * Garage
 * Garage WebUI
 * MCP Toolbox for Databases
 * MCP Trino
 * CentralMind API/MCP Gateway
 * Trino Gateway
 * Trino LB (Load Balancer)
 * Platys MDP Docker Deploy
 * Presidio Analyzer
 * Presidio Anonymizer
 * Lakekeeper
 * MCP Inspector
 * Allure Report
 * Nimtable
 * EHRBase
 * OpenEHR Tool
 * Polaris
 * RisingWave Console
 * Gravitino
 * Gravitino Iceberg Rest Server
 * Puppy Graph
 * Azurite
 * Cruise Control
 * Confluent Control Center Next Generation
 * XTDB
 * Shadow Traffic
 * PyIceberg
 
### Version upgrades

 * Update `milvus` to `v2.5.12` 
 * Update `langflow` to `1.5.0`
 * Update `n8n` to `2.0.2`
 * Update `minio` to `RELEASE.2025-09-07T16-13-09Z`
 * Update `dgraph` to `v24.1.3`
 * Update `memgraph` to `3.2.1`
 * Update `airflow` to `2.11.0` and `3.0.1`
 * Update `nifi` to `2.5.0`
 * Update `nifi-registry` to `2.5.0`
 * Update `nifi-toolkit` to `2.5.0`
 * Update `ollama` to `0.9.0`
 * Update `local-ai` to `v2.29.0`
 * Update `anaconda` to `2024.10-1`
 * Update `grafana` to `12.0.1`
 * Update `memcached` to `1.6`
 * Update `flowise` to `3.0.1`
 * Update `trino` to `479`
 * Update `starburstdata` to `477-e.2`
 * Update `risingwave` to `v2.6.1`
 * Update `confluent-platform` to `8.1.0`
 * Update `apicurio-registry` to `2.6.11.Final`
 * Update `materialize` to `v0.146.1`
 * Update `arroyo` to `0.14.0`
 * Update `sqlflow` to `0.6.0`
 * Update `timeplus-enterprise` to `2.8.1`
 * Update `timeplus-proton` to `1.6.16-r`
 * Update `burrow` to `v1.9.4`
 * Update `debezium-server` to `3.0.0.Final`
 * Update `tika` to `3.2.0.0-full`
 * Update `opa` to `1.6.0-dev`
 * Update `enterprise-opa` to `1.41.1-23-debug`
 * Update `datahub` to `head`
 * Update `openmetadata` to `1.8.1`
 * Update `amundsen-frontend` to `4.3.0`
 * Update `amundsen-search` to `4.2.0`
 * Update `amundsen-metadata` to `3.13.0`
 * Update `data-product-portal` to `0.3.1`
 * Update `marquez` to `0.51.1`
 * Update `ckan` to `2.10`
 * Update `ckan-datapusher` to `0.0.21`
 * Update `mage-ai` to `0.9.76`
 * Update `kestra` to `v0.22.13`
 * Update `mlfow` to `v2.22.1`
 * Update `dataiku` to `13.4.1`
 * Update `tyk-gateway` to `v5.7`
 * Update `tykio/tyk-pump-docker-pub` to `v1.12`
 * Update `kong-gateway` to `3.10`
 * Update `s3fs` to `1.95`
 * Update `spring-boot-admin` to `3.4.1`
 * Update `sqlserver` to `2022-latest`
 * Update `dremio` to `26.0`
 * Update `presto` to `0.294`
 * Update `streampipes` to `0.98.0-SNAPSHOT`
 * Update `nessie` to `0.105.7`
 * Update `unity-catalog` to `v0.3.0`
 * Update `unity-catalog-main` to `main`
 * Update `flink` to `2.1.0-scala_2.12-java17`
 * Update `postgresql` to `18` 
 * Update `oracle-free` to `23.26.0.0`
 * Update `oracle-adb` to `25.7.5.2-23ai`
 * Update `kafka` to `4.1.0`
 
### Enhancements

 * Additional data can be copied into `/data-transfer` folder when using the `PROVISIONING_DATA_enable` functionality by specifying the folder in `PROVISIONING_DATA_additional_data_folder` setting
 * Add Support for Airflow 3.x
 * Add Support for writing the Airflow logs to S3 (MinIO) by setting `AIRFLOW_logging_strategy` to `s3`.
 * Add support for external Snowflake
 * Add support for additional Trino connectors: `prometheus`, `jmx`, `opensearch`, `clickhouse`, `gsheets`, `ignite`, `singlestore`, `loki`, `snowflake` and `duckdb`
 * only create the sub-folders for the enabled services (based on service name) within the `applications`, `conf`, `container-volume`, `custom-conf`, `licenses`, `init`, `plugins`, `scripts` and `security` folders.
 * Maven dependency download now also supports downloading transitive dependency (using strategy `coursier`). Currently only used with Flink.
 * set default for `HIVE_METASTORE_transactional_event_listeners` to be empty. You now have to explicitely set it to `org.apache.hive.hcatalog.listener.DbNotificationListener` or any custom listener implementation you can add to the classpath by using the new config setting `HIVE_METASTORE_plugin_jars`
 * Add `inkless` as a new option for `KAFKA_edition` (Aiven's fork of preview of KIP-1150 - Diskless Kafka)
 * Add support for `schema-registry` table descriptor supplier strategy to Trino's Kafka connector implementation

### Breaking Changes

 * `minio-console` removed as docker image is no longer available
 * `MINIO_browser_enable` renamed to `MINIO_browser_enabled` to be conforment with naming convention
 * Change internal port of `docker-registry` from `5000` to `5020`
 * Any config setting which does not enable a service renamed from `XXXX_ddd_enable` to `XXXX_ddd_enabled`
 * Change all bitnami images to the `bitnamilegacy` docker repository, due to all the bitnami images no longer be available for free
 * Change default values of `MINIO_access_key` and `MINIO_secret_key` to a more memorable value
 * Default value for `LAKEFS_use_as_drop_in_replacement_for_s3` changed to `false`
 * Change Oracle REST Data Service (ORDS) to use the official oracle docker image
 * `KAFKA_CCC_enable` renamed to `CONFLUENT_CCC_enable`

## What's new in 1.18.1

### Bug Fixes

 * fix error with service list no longer being rendered by markdown-renderer
 * fix problem with healthchecks in spark and airflow services

## What's new in 1.18.0

The Modern Data Platform version 1.18.0 contains the following bug fixes and enhancements:

### New Services

 * Langflow 
 * Langfuse
 * Kyuubi
 * NeoDash
 * Fluent Bit
 * NATS
 * MQTTX Web & MQTTX CLI
 * Web Protégé
 * Jena-Fuseki
 * Rancher
 * NLM Ingestor
 * Weaviate Verba
 * Unstructured API
 * gpt-researcher
 * Docker Exec Web Console
 * n8n
 * Arroyo
 * Data Contract CLI
 * Data Contract Manager (CE)
 * Data Mesh Manager (CE)
 * Glances
 * Starrocks
 * CrewAI Studio 
 * Jikkou Server
 * SearXNG
 * Draw.io
 * Unity Catalog & Unity Catalog UI
 * RAGFlow 
 * Valkey
 * Authelia
 * Infinity
 * SFTPgo
 * Ofelia
 * Cedar Agent
 * Open Policy Administration Layer (OPAL)
 * Oracle Database Free (Oracle official)
 * Oracle Autonomous Database Free
 * Git Web
 * LangWatch
 * LangEvals
 * Agent Zero
 * Data Product Portal
 * Mage AI
 * Timeplus
 * Aspire
 * OpenLIT
 * ClickHouse
 * Kestra
 * ngrok
 * Arize Phoenix
 * Crawl4AI
 * Whisper
 * Audio-Transcriber
 * Nvidia NIMs
 * No Language Left Behind (NLLB)
 * Local Deep Researcher
 * DbGate
 * DuckDB (optionally with UI)
 * ClickHouse UI
 * Docker in Docker (DinD)
 * Jenkins
 * InfluxDB 3 Core
 * InfluxDB 3 Explorer (UI)

### New/Updated Cookbook Recipes

 * [Schedule and execute commands in Docker containers using Ofelia](../cookbooks/recipes/scheduling-commands-on-docker-containers-with-ofelia/README.md)
 * [Git for Data with LakeFS](../cookbooks/recipes/git-for-data-with-lakefs/README.md)

### Version upgrades

 * Update `postgresql` to `17` 
 * Update `mongo` to `8.0` 
 * Update `solr` to `9.5` 
 * Update `janusgraph` to `1.0.0-20231010-065545.e3799d4`
 * Update `neo4j` to `5.26` and `2025`
 * Update `memgraph` to `2.16.0`
 * Update `memgraph-mage` to `1.16-memgraph-2.16-dev`
 * Update `arcadedb` to `24.2.1`
 * Update `dgraph` to `v23.1.1`
 * Update `graphdb-free` to `10.8.4`
 * Update `graphdb` to `10.8.5`
 * Update `questdb` to `7.4.0`
 * Update `kudu` to `1.17`
 * Update `chroma` to `0.4.25.dev139`
 * Update `qdrant` to `v1.8.4`
 * Update `weaviate` to `1.24.10`
 * Update `druid` to `29.0.1`
 * Update `pinot` to `1.1.0`
 * Update `prometheus` to `v2.51.2`
 * Update `prometheus-pushgateway` to `v1.8.0`
 * Update `prometheus-alertmanager` to `v0.27.0`
 * Update `tile38` to `1.32.2`
 * Update `yugabyte` to `2.14.16.0-b17`
 * Update `single-store` to `0.2.18`
 * Update `timescaledb` to `2.14.2-pg16`
 * Update `hazelcast` to `5.4`
 * Update `trino` to `475`
 * Update `starburstdata` to `472-e`
 * Update `prestodb` to `0.286`
 * Update `ahana` to `0.286`
 * Update `dremio` to `25.2`
 * Update `hasura` to `v2.38.1-ce`
 * Update `marquez` and `marquez-web` to `0.50.0`
 * Update `datastax` to `6.8.44`
 * Update `elasticsearch` to `7.17.28` and `8.17.4`
 * Update `kibana` to `7.17.28` and `8.17.4`
 * Update `memcached` to `1.6.26`
 * Update `redis-stack` to `7.2.0-v10`
 * Update `stardog` to `latest`
 * Update `minio` to `RELEASE.2025-04-22T22-12-26Z`
 * Update `minio-kes` to `2025-01-30T09-41-53Z`
 * Update `datahub` to `v1.0.0rc1`
 * Update `risingwave` to `v2.1.0`
 * Update `portainer` to `alpine-sts`
 * Update `flowise` to `2.2.5`
 * Update `nifi` to `2.2.0`
 * Update `nifi` to `1.28.1`
 * Update `flink` to `2.0.0-scala_2.12-java17`
 * Update `Confluent Platform` to `7.8.0`
 * Update `milvus` to `v2.4.11`
 * Update `attu` to `v2.4.8`
 * Update `postgresql` to `17`
 * Update `dataverse` to `alpha`
 * Update `airflow` to `2.10.2`
 * Update `marquez` to `0.49.0`
 * Update `spark` to `3.5.3`
 * Update `projectnessie` to `0.100.0`
 * Update `lakefs` to `1`
 * Update `vault` to `1.18`
 * Update `opa` to `1.4.0`
 * Update `styra` to `1.39.1-83-debug`
 * Update `jikkou` to `main` - to support Mac M1
 * Update `telegraf` to `1.34`
 * Update `cassandra` to `5.0`
 * Update `iceberg-rest-catalog` to `1.6.0`

### Enhancements

 * a `README.md` file is generated which lists all the services contained in the `docker-compose.yml` file
 * Refactored Spark (Master, Worker, History and Thriftserver) to use the bitnami docker images
 * Refactored Zeppelin to use the Dockerfile provided by the Apache Zeppelin project
 * Option to overrite the Postgres standard, official image by one with an additional extension, such as `PGVector` or `age` or with your own docker image
 * Support for the deployment of Dataverse previewers added (see `DATAVERSE_previewers_xxxx` config settings)
 * Support for `valkey` as an edition to the Redis service, to use Valkey (the fork of Redis with open source license) to use as a drop-in replacement
 * Update LakeFS to the latest version and add more configuration options
 * NiFi 2.0.0 can be run it in parallel to a 1.x version (`NIFI2_enable` config setting)
 * Kafka Open Source docker images are now supported (use `KAFKA_edition` = `oss`)
 * Hive Metastores docker image is now based on the `apache/hive` image and with that the underlying database can either be an embedded Derby or a separate Postgresql (using the standard docker image).
 * `markdown-renderer` also includes a `docker-compose.override.yml` file for services to be rendered in the services list (if there are `com.platys.***` labels used). 

### Breaking Changes

 * Remove `NEO4J_dbms_logs_debug_level` setting from Neo4J
 * Change to config settings to configure memory in Neo4J: `NEO4J_server_memory_pagecache_size`, `NEO4J_server_memory_heap_initial_size` and `NEO4J_server_memory_heap_max_size`
 * Lenses no longer uses external port `3030` but `28369`
 * `wetty` is no longer enabled by default in the initial `config.yml` file
 * Neo4J config setting `NEO4J_plugins` renamed to `NEO4J_download_plugins` and added `NEO4J_mount_plugins` 
 * Memgraph no longer uses external port `7690 ` but `7699`
 * change default value for `TRINO_edition` to `oss`
 * `dataverse` port changed to `28394` (used to be `28294` and by taht conflicting with `ckan`)
 * Support for Spark versions `2.4`, `3.1` and `3.2` removed
 * Remove the `NIFI_major_version` config setting, as there is now support to run both NiFi v1 and v2 in parallel (`NIFI_enable` vs. `NIFI2_enable`)
 * both in Apache NiFi v1 and v2 support, the `/plugins/nifi/jars/` / `/plugins/nifi2/jars/` is now mapped to `/opt/nifi/nifi-current/addl-jars/` and no longer to `/extra-jars` inside the docker container.
 * Rename config setting `PYTHON_script_file` to `PYTHON_script_to_run`
 * Rename `ORACLE_FREE_xxx` to `ORACLE_OCI_FREE_xxx` and use `ORACLE_FREE_xxx` for the Oracle official docker image. 
 * Rename config setting `NEO4J_admin_password` to `NEO4J_password`
 * Rename config setting `STREAMLIT_environment` to `STREAMLIT_env_variables`
 * Ollama WebUI renamed to Open WebUI (`OPEN_WEBUI_xxx` and no longer `OLLAMA_WEBUI_xxx`)
 * `KAFKA_use_kraft_mode` now defaults to `true`
 * `cassandra` default major version set to `5`
 * `cassandra-web` has been removed due to missing support for latest Cassandra versions
 
## What's new in 1.17.1

The Modern Data Platform version 1.17.1 contains no new services but a few small enhancements:

### Enhancements

 * VectorAdmin uses postgresql default database and enables it automatically
 * default value for external Ollama endpoint

## What's new in 1.17.0

The Modern Data Platform version 1.17.0 contains the following bug fixes and enhancements:

### New Services

 * Minio Web
 * ActiveMQ Artemis
 * HStreamDB
 * Kafka Init
 * Docker Registry
 * Docker Registry UI
 * Splunk
 * Klaw
 * FluentD
 * Raneto
 * Markdown Madness
 * Kadeck
 * MailDev
 * Mailpit
 * MailHog
 * Dataverse
 * CKAN
 * AsyncAPI Studio
 * Taiga
 * Taskcafé
 * Cetusguard
 * etcd & etcd-browser
 * Risingwave
 * MonitoFi
 * IOEvent Cockpit
 * Redis (Metrics) Exporter
 * S3FS
 * Prometheus Alertmanager
 * Pact Broker
 * Cribl Stream
 * Cribl Edge
 * Blaze (FHIR Server)
 * LinuxForHealth (FHIR Server)
 * HAPI FHIR Server
 * FileBeat
 * Open Policy Agent (OPA)
 * Styra Enterprise OPA
 * ToolJet
 * Miracum FHIR Gateway
 * LiteLLM
 * MindsDB
 * Ollama
 * Ollama WebUI
 * Alpaca WebUI
 * Chroma
 * Milvus & Attu
 * Flowise
 * Streamlit Applications
 * Anything LLM
 * Vector Admin
 * SingleStore
 * Qdrant
 * Redis Stack
 * Weaviate
 * Big-AGI
 * LocalAI
 * Solace PubSub+
 * Solace Kafka Proxy
 * Softproject X4 Server
 * MariaDB
 * Minio KES
 * AutoGen Studio

### Removed Services
 
 * Azkarra Worker

### New/Updated Cookbook Recipes

 * [Collecting Docker Logs with Loki](../cookbooks/recipes/collecting-docker-logs-with-loki/README.md)
 * [Kafka SASL/SCRAM Authentication](../cookbooks/recipes/kafka-sasl-scram-authentication/README.md)
 * [Serving a static Web application from MinIO](../cookbooks/recipes/serving-static-html-app-from-minio/README.md)

 
### Version upgrades

 * Update `zeebe` to `8.2.5`
 * Update `druid` to `26.0.0`
 * Update `trino` to `443`
 * Update `starbrustdata` to `435-e.2`
 * Update `jikkou` to `0.21.0`
 * Update `minio` to `RELEASE.2024-03-21T23-13-43Z`
 * Update `nifi` to `1.25.0`
 * Update `ksqldb` to `0.29.0`
 * Update `datahub` to `v0.13.0`
 * Update `Confluent Platform` to `7.6.0`
 * Update `portainer-ce` to `2.18.4-alpine`
 * Update `activemq-classic` to `5.18.2`
 * Update `materialize` to `v0.64.0`
 * Update `jikkou` to `latest`
 * Update `keycloak` to `22.0`
 * Update `marquez` to `0.41.0`
 * Update `flink` to `1.18-scala_2.12-java17`
 * Update `airflow` to `2.7.3`
 * Update `zeebe` to `8.3.1`
 * Update `grafana` to `10.2.0`
 * Update `prometheus` to `v2.28.1`
 * Update `prometheus-pushgateway` to `v1.6.2`
 * Update `prometheus-nodeexporter` to `v1.7.0`
 * Update `redis` to `7.2`
 * Update `vault` to `1.15`
 * Update `influxdb` to `1.8` (latest OSS version)
 * Update `kapacitor` to `1.7`
 * Update `telegraf` to `1.28`
 * Update `tile38` to `1.32.0`
 * Update `hasura` to `v2.35.1`
 * Update `materialize` to `v0.91.0`
 * Update `cadvisor` to `v0.47.2`
 * Update `portainer` to `2.19.4-alpine`
 * Update `elasticsearch` to `8.11.3`
 * Update `kibana` to `8.11.3`
 * Update `hasura` to `v2.37.0-ce`
 * Update `risingwave` to `v1.6.0`

### Enhancements

 * support for configuring Airflow authentication backends via `AIRFLOW_auth_backends` config setting
 * support ActiveMQ Artemis as an ActiveMQ edition
 * add support for multiple trino event listener plugins (rename `TRINO_event_listener` to `TRINO_event_listeners`)
 * support for NEO4J major version 4 and 5 with `NEO4J_major_version` setting
 * Markdown Viewer implementation has been changed to use `markdown-madness` instead of `markdown-web` (because it supports images and also has a nicer look&feel). This is now the default option, but you can revert back to the previous one by changing the value of the `MARKDOWN_VIEWER_edition` config setting to `markdown-web`.
 * Watchtower now supports a lot more options and is no longer hardcoded to one single behaviour.
 * support for Kafka SASL/PLAIN authentication for traditional and KRaft setups
 * support for Kafka SASL/SCRAM (256 + 512) authentication for traditional and KRaft setups
 * support for Kafka authorisation for traditional and KRaft setups
 * support for authentication in AKHQ
 * removed JAR's from the plugin folder to decrease the size of the docker image
 * added multi-arch docker build to also build the docker image of the generator as an arm64 type
 * the "preview" version is no longer tagged as `1.nn.nn-preview` but as `develop`, so to get the development version, just use `platys init -n demo-platform --stack trivadis/platys-modern-data-platform --stack-version develop --structure flat`
 * Add property (`NIFI_major_version`) to chose between NiFi Version 1 and Version 2
 * Markdown-Viewer service comes with a redesigned service list now also visualising the exposed ports and the description of each service. This is `v2`, you can switch back to `v1` by configuring `MARKDOWN_VIEWER_services_list_version` and set it to `1`.

### Breaking Changes

 * Remove usage of `$PUBLIC_IP` from the labels section in the `docker-compose.yml` to make it more stable to changing the value of the environment variable with a stack running (`docker compose up -d` will cause less harm)
 * Rename Trino configuration setting `TRINO_additional_connectors` to `TRINO_additional_plugins`
 * Keycloak is no longer using the "legacy" version but the new Quarkus-based one 
 * Dataiku now maps to port `28315` and no longer to `28205`
 * Change `KAFKA_KSQLDB_xxxxx` to `KSQLDB_xxxxx`
 * Change `FTP_xxxxx` to `PURE_FTPD_xxxxx` to control the Pure FTPd server
 * Config `ATLAS_install_hive_hook` has been replaced by `ATLAS_hive_hook_enable` and the JARs for the hook are no longer included and need to be downloaded manually  
 * Config `KAFKA_jmx_monitoring_prometheus_enable` replaced by global configuration property `jmx_monitoring_with_prometheus_enable` as it doesn't apply to just the Kafka cluster

## What's new in 1.16.0

The Modern Data Platform version 1.16.0 contains the following bug fixes and enhancements:

### New Services

 * Kong API Gateway
 * Kong decK
 * Konga
 * Kong Map
 * Kong Admin UI
 * Tyk API Gateway
 * Tyk Dashboard
 * Tyk Pump
 * Kafka Connector Board
 * Kaskade
 * kpow
 * JupyterHub
 * Conduktor Platform
 * Memgraph
 * Curity
 * Anaconda
 * Redpanda Console (previously kowl, old version of kowl still supported)
 * Iceberg REST Catalog
 * JanusGraph
 * Gremlin Console
 * Invana Engine and Invana Studio
 * ArcadeDB
 * Spring Boot Admin Server
 * CKAN
 * Benthos
 * OpenLDAP + phpLDAPadmin + LDAP User Manager
 * SFTP
 * Project Nessie
 * Directus
 * Baserow
 * Querybook
 * Oracle Database Free
 * Kafka CLI (Kafka software without a running broker)
 * Kafkistry
 * Parquet Tools
 * SQL Chat

### New/Updated Cookbook Recipes

 * [NiFi ExecuteScript Processor with Python](../cookbooks/recipes/nifi-execute-processor-with-python/README.md)
 * [NiFi Registry with Git Flow Persistence Provider](../cookbooks/recipes/nifi-registry-with-git/README.md)
 * [Handle Serialization Errors in ksqlDB](../cookbooks/recipes/ksqldb-handle-deserializaion-error/README.md) 
 * [Using Jupyter notebook with Spark and Avro](../cookbooks/recipes/jupyter-spark/README.md)
 * [Using Dev Simulator Origin to simulate streaming data](../cookbooks/recipes/using-dev-simulator-origin/README.md) - updated with diagrams and additional samples
 * [Spark with Delta Lake](../cookbooks/recipes/delta-lake-with-spark/README.md) 
 * [Spark with Iceberg](../cookbooks/recipes/iceberg-with-spark/README.md) 
 * [Neo4J and yFiles graphs for Jupyter](../cookbooks/recipes/neo4j-jupyter-yfiles/README.md)
 * [Schedule and Run Simple Python Application with Airflow](../cookbooks/recipes/airflow-schedule-python-app/README.md) - updated to show the new support of Airflow
 * [Using MLflow from Jupyter](../cookbooks/recipes/using-mflow-from-jupyter/README.md)
 * [Trino Security](../cookbooks/recipes/trino-security/README.md)
 * [Azure Event Hub as external Kafka](../cookbooks/recipes/azure-event-hub-as-external-kafka/README.md)

### New Tutorial

 * [IoT Vehicle Tracking](../tutorials/iot-vehicle-tracking/README.md)

### Version upgrades

 * Update `DataHub` to `v0.10.3`
 * Update `Trino` to `418`
 * Update `Starburst Enterprise` to `413-e`
 * Update `dremio` to `24.0`
 * Update `Jikkou` to `0.14.0`
 * Update `Hasura` to `v2.16.1`
 * Update `Confluent Platform` to `7.4.0`
 * Update `ksqldb` to `0.28.2`
 * Update `datastax` to `6.8.34`
 * Update `datastax-opscenter` to `6.8.26`
 * Update `minio` to `RELEASE.2023-04-20T17-56-55Z`
 * Update `confluent platform` to `7.3.3`
 * Update `influxdb2` to `2.7`
 * Update `kapacitor` to `1.6`
 * Update `chronograf` to `1.10`
 * Update `telegraf` to `1.26`
 * Update `burrow` to `v1.5.0`
 * Update `graphdb` to `10.1.2`
 * Update `nifi` to `1.21.0`
 * Update `jikkou` to `0.13.0`
 * Update `spark` to `3.1.3`, `3.2.4` and `3.3.2` and `3.4.0`
 * Update `materialize` to `v0.52.2`
 * Update `neo4j` to `5.7`
 * Update `eventstoredb` to `22.10.0-buster-slim`
 * Update `flink` to `1.17-scala_2.12`
 * Update `tika-server` to `2.6.0.0-full`
 * Update `marquez` and `marquez-web` to `0.33.0`
 * Update `airbyte` to `0.40.33`
 * Update `mlflow-server` to `2.1.0`
 * Update `minio` to `RELEASE.2023-01-20T02-05-44Z`
 * Update `grafana` to `9.3.11`
 * Update `kibana` to `7.17.9` and `8.7.0`
 * Update `elasticsearch` to `7.17.9` and `8.7.0`
 * Update `memchached` to `1.6.19`
 * Update `mongodb` to `6.0`
 * Update `solr` to `9.1`
 * Update `quine` to `1.5.1`
 * Update `dgraph` to `v22.0.2`
 * Update `stardog` to `8.2.2-java11-preview`
 * Update `kudu` to `1.16`
 * Update `druid` to `25.0.0`
 * Update `prometheus` to `v2.41.0` and `gateway` to `v1.5.1` and `node-exporter` to `v1.5.0`
 * Update `tile38` to `1.30.1`
 * Update `yugabyte` to `2.8.11.0-b6`
 * Update `hazelcast` to `5.2.3`
 * Update `ignite` to `2.14.0`
 * Update `axon-server` to `4.6.7
 * Update `drill` to `1.20.2`
 * Update `hasura` to `v2.23.0`
 * Update `cedalo-management-center` to `2.5.8`
 * Update `lakefs` to `0.101.0`
 * Update `vault` to `1.13.1`
 * Update `portainer` to `2.16.2-alpine`
 * Update `watchtower` to `1.5.1`
 * Update `ahana` to `0.278`
 * Update `apicurio-schema-registry` to `2.4.2.Final`
 * Update `debezium-server` to `2.2.0-Final`
 * Update `Amundsen Frontend` to `4.2.0` and `Amundsen Search` to `4.0.2` and `Amundsen Metadata` to `3.11.0`
 * Update `nodered` to `2.2.3`
 * Update `dataiku-dss` to `11.2.0`
 * Update `postgres` to `15`
 * Update `Airflow` to `2.6.1` with default python `3.10`
 * Update `TimescaleDB` to `2.10.2-pg15`
 * Update `Pinot` to `0.12.1`
 * Update `Jupyter-spark` to `spark-3.3.2` and `spark-3.4.0`
 * Update `Hue` to `4.11.0`

### Bug Fixes

 * ksqlDB processing log now also works with the open source edition (`      KAFKA_KSQLDB_edition: 'oss'`).

### Breaking Changes

 * if markdown viewer cannot run on port 80 (`MARKDOWN_VIEWER_use_port_80` is set to `false`), port 8008 is used and no longer port 8000
 * Burrow changed to use image from LinkedIn and no longer the one from Trivadis
 * Change `KAFKA_CMAK_xxxxx` to `CMAK_xxxxx`
 * Change `KAFKA_AKHQ_xxxxx` to `AKHQ_xxxxx`
 * Change `KAFKA_KAFDROP_xxxxx` to `KAFDROP_xxxxx`
 * Change `KAFKA_KADMIN_xxxxx` to `KADMIN_xxxxx`
 * Change `KAFKA_EFAK_xxxxx` to `EFAK_xxxxx` 
 * Change the docker image for Airflow from the Bitnami to the official Apache one
 * Support the two major versions 7 and 8 of Elasticsearch
 * Ember Frontend for Datahub removed (as React is the new standard UI)
 * Rename `SPARK_THRIFT_enable` to `SPARK_THRIFTSERVER_enable`
 * Rename folder `./init/oraclexe` to `./init/oracle-xe`
 * Spark Master UI now runs on port `28304` and no longer on standard `8080`
 * Change `FLINK_NUSSKNACKER_enable` to `NUSSKNACKER_enable`
 * Change `MINIO_default_buckets` to `MINIO_buckets`

### Enhancements

 * make `spark.sql.warehouse.dir` configurable in `config.yml`
 * added first tutorials showing more complete walk-through of using Platys
 * allow to add roles when specifying multiple databases and users with PostgreSQL
 * allow to specify that the Starburstdata license file should be mapped into the containers, when `TRINO_edition` is set to `starburstdata`. This enables the additional security features, more connectors, a cost-based query optimizer and much more.
 * added catalog for `iceberg`, `delta-lake`, `elasticsearch`, `mongo`, `mysql`, `sqlserver`, `pinot` and `druid` to trino/starburst
 * added options to further configure AKHQ 
 * support Trino security with password file and access control file
 * support for multiple Airflow workers if `celery` executor mode is used
 * support for custom Trino catalogs and connectors
 * add concept of an environment to a platys stack, so that the same docker-compose can be run multiple time on different machines, but having a separate environment.
 
## What's new in 1.15.0

The Modern Data Platform version 1.15.0 contains the following bug fixes and enhancements:

### New Services

 * dbt
 * Quine
 * NiFi Toolkit
 * Conduit
 * ReTool
 * Airbyte
 * Oracle SQLcl
 * MockServer
 * Kafka WebView
 * OpenSearch & OpenSearch Dashboards
 * ElasticVue
 * NocoDB
 * Azure CLI
 * Azure Storage Explorer
 * Zilla
 * NocoDB
 * kafkactl

### New Cookbook Recipes

 * [Querying data in Azure Data Lake Storage Gen2 from Trino](../cookbooks/recipes/querying-adls-with-trino)

### Version upgrades

 * Update `Apache NiFi` to `1.15.3` and `Apache NiFi Registry` to `1.15.3`
 * Update `Trino` to `391`
 * Update `Starburst Enterprise` to `391-e`
 * Update `dremio` to `20.1`
 * Update `Debezium Server` to `1.9`
 * Update `DataHub` to `v0.8.40`
 * Update `ksqldb` to `0.27.1`
 * Update `spring-cloud-dataflow-server` to `2.9.3`
 * Update `spring-cloud-skipper-server` to `2.8.3`
 * Update `streamsheet` to `2.5.3-milestone`
 * Update `thingsboard` to `3.3.4.1`
 * Update `datahub` to `v0.8.31`
 * Update `nifi` to `1.17.0` and `nifi-registry` to `1.17.0`
 * Update `minio` to `RELEASE.2022-08-08T18-34-09Z`
 * Update `spark` to `3.1.3`
 * Update `zeppelin` to `0.10.1`
 * Update `Confluent Platform` to `7.1.2`
 * Update `Materialize` to `v0.26.0`
 * Update `lakeFS` to `0.63.0`
 * Update `Pinot` to `0.10.0`
 * Update `Marquez` to `0.23.0`
 * Update `DataStax` to `6.8.25`

### Breaking Changes

 * `KAFKA_CONNECT_UI_use_public_ip` option has been removed, as now `kafka-connect-ui` is using the internal service name to connect to kafka-connect.
 * `SPARK_major_version` has been replaced by `SPARK_base_version` to be able to set the major and minor version for the Spark version to use.

### Enhancements

 * Add support for Nifi Cluster (setting the new config seeting `NIFI_create_cluster` to `true`
 * Apache NiFi is now secure by default, so you have to use https to get to the UI and then authenticate using the user and password specified.
 * Zeppelin images are now in Sync with Spark version (all 3 digits x.x.x).
 * Option for installing Adventureworks demo database with SQL Server
 * Externalize version of the container used when `PROVISIONING_DATA_enable` is activated
 * Support external property file for configuration values in `streamsets`
 * Support for Cassandra cluster and set default major version to `4`

### Bug Fixes

 * fix bug in `markdown-renderer` on Apple Silicon (M1)
 * fix bug if a kafka-connect cluster is used
 * update zeppelin docker container to download spark without hadoop to fix a bug when writing to S3

## What's new in 1.14.0

The Modern Data Platform version 1.14.0 contains the following bug fixes and enhancements:

### New Services

 * Kouncil
 * Apicurio Registry
 * Streamsets DataOps Platform
 * Grafana Loki
 * Grafana Promtail
 * Avro Tools
 * Kafka Magic
 * StreamPipes
 * Remora
 * Metabase
 * Jikkou
 * Pitchfork
 * Jaeger
 * OTEL Collector (OpenTelemetry)
 * Camunda BPM Platform
 * Camunda Optimize
 * Lenses Box
 * Tempo & Tempo Query
 * Promtail

### New Cookbook Recipes

 * [Apicurio Registry with SQL Storage (PostgreSQL)
](../cookbooks/recipes/apicurio-with-database-storage)
 * [Automate managment of Kafka topics on the platform](../cookbooks/recipes/jikkou-automate-kafka-topics-management/README.md)  
 * [Simulated Multi-DC Setup on one machine](../cookbooks/recipes/simulated-multi-dc-setup/README.md)
 * [Creating a self-managed StreamSets DataOps Environment using Platys](../cookbooks/recipes/streamsets-dataops-creating-environment/README.md)
 * [Loading Streamsets Pipeline(s) upon start of container](../cookbooks/recipes/streamsets-loading-pipelines/README.md)
 * [Working with Tipboard and Kafka](../cookbooks/recipes/tipboard-and-kafka/README.md)
 * [Querying data in Kafka from Trino (formerly PrestoSQL)](../cookbooks/recipes/querying-kafka-with-trino/README.md)
 * [Using a Kafka Connect Connector not in Confluent Hub](../cookbooks/recipes/using-kafka-connector-not-in-confluent-hub/README.md)


### Version upgrades

 * Update `DataHub` to `0.8.25`
 * Update `Trino` to `371`
 * Update `Starburst Enterprise` to `369-e`
 * Update `Apache NiFi` to `1.15.0`
 * Update `Hasura` to `v2.0.0-beta.2`
 * Update `ksqlDB` to `0.23.1`
 * Update `Zeppelin` to `0.10.0`
 * Update `Livy` to `0.7.1-incubating`
 * Update `Spark 3` to `3.2`
 * Update `Streamsheets` to `2.5-milestone`
 * Update `Neo4J` to `4.4`
 * Update `Confluent` to `7.0.1`
 * Update `NiFi` to `1.15.2` and `NiFi Registry` to `1.15.1`
 * Update `Marquez` to `0.20.0`
 * Update `Amundsen Frontend` to `4.0.0` and `Amundsen Search` to `3.0.0`
 * Update `InfluxDB 2` to `2.1.1`
 * Update `EventStore`to `21.10.1-buster-slim`
 * Update `Keycloak` to `16.1.1`
 * Update `Dremio` to `20.0`
 * Update `Minio` to `RELEASE.2022-02-01T18-00-14Z`
 * Update `lakeFS` to `0.58.0`
 * Update `Vault` to `1.9.3`
 * Update `Ranger` to `2.2.0`
 * Update `Materialize` to `v0.19.0`
 * Update `kcat` to `1.7.1`
 * Update `Debezium` to `1.8.0.Final`
 * Update `Cassandra` to `4.1`
 * Update `Datastax` to `6.8.19`
 * Update `Elasticsearch` to `7.17.0`
 * Update `Node-RED` to `2.2.0`
 * Update `Spring Dataflow` to `2.9.2` and `Skipper` to `2.8.2`
 * Update `MLflow` to `1.23.1`
 * Update `Optuna Dashboard` to `0.5.0`
 * Update `Kie-Server` to `7.61.0.Final`
 * Update `Grafana` to `8.3.4`
 * Update `Kibana` to `7.17.0`
 * Update `Memchached` to `1.6.13`
 * Update `Solr` to `8.11`
 * Update `DGraph` to `v21.12.0`
 * Update `Stardog` to `7.8.3-java11-preview`
 * Update `GraphDB` to `9.10.1`
 * Update `QuestDB` to `6.2`
 * Update `Druid` to `0.22.1`
 * Update `Pinot` to `0.9.3`
 * Update `Prometheus` to `v2.33.1` and `pushgateway` to `v1.4.2` and `nodeexporter` to `v1.3.1`
 * Update `Tile38` to `1.27.1`
 * Update `Axon` to `4.5.10`
 * Update `Hasura` to `v2.2.0`
 * Update `Emq` to `4.3.11`
 * Update `Cedalo Mgmt Center` to `2.2`
 * Update `Thingsboard` to `3.3.3`
 * Update `RabbitMQ` to `3.9-management`
 * Update `Watchtower` to `1.4.0`

### Breaking Changes

 * InfluxDB is now listening on `19999` instead of `9999`
 * All `KAFKA_SCHEMA_REGISTRY_xxxx` renamed to `CONFLUENT_SCHEMA_REGISTRY_xxxx`
 * All `KAFKA_SCHEMA_REGISTRY_UI_xxxx` renamed to `SCHEMA_REGISTRY_UI_xxxx`
 * Add additional Kafka Advertised Listener for localhost (port 39092 - 39099) and distinguish it from the Docker Listener (on $DOCKER_HOST_IP with port 29092 - 29099)
 * allow to switch Kafka standard port usage between EXTERNAL and DOCKER_HOST Listener (config parameter `KAFKA_use_standard_port_for_external_interface`)
 * `KAFKA_BURROW_enable` renamed to `BURROW_enable`
 * `conf-override` renamed to `custom-conf` to better reflect the fact, that this folder is only for cusotmized configuration files which will not be overwritten when re-generating the platform
 * If manually copying Kafka Connect connectors, then no longer place them into `plugins/kafka-connect` but `plugins/kafka-connect/connectors`
 * Rename of the `python` configuration settings (`PYTHON_artefacts_folder` and `PYTHON_script_file`)

### Enhancements

 * Apicurio Schema Registry as a drop-in replacement for the Confluent Schema Registry
 * All services in the Services List Markdown page (http://dataplatform/services) contain a link to their homepage
 * Configuration page also links to the serice homepage
 * Support Authentication and Authorization in Apicurio Registry via Keycloak
 * Added support for PIP packages to be installed before running the `python` container
 * Support sending docker logs to Grafana Loki

### Bug Fixes

 * fixed error with Burrow service
 * `KEYCLOCK` changed to `KEYCLOAK` to reflect the right name

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
 * Update `Redis` to `7.0`
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
	