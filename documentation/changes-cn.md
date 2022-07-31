# `modern-data-platform`- 有什么新内容？

看[升级到新的平台堆栈版本](https://github.com/TrivadisPF/platys/blob/master/documentation/upgrade-platform-stack.md)有关如何升级到较新版本的信息。

## 1.14.0 中的新增功能

新式数据平台版本 1.14.0 包含以下错误修复和增强功能：

### 新服务

*   孔西尔
*   Apicurio Registry
*   Streamset DataOps Platform
*   格拉法娜·洛基
*   格拉法纳·普罗姆泰尔
*   阿夫罗工具
*   卡夫卡魔术
*   流管
*   雷莫拉
*   元数据库
*   冀口
*   杈
*   耶格尔
*   OTEL收集器（开放式测量）
*   卡蒙达 BPM 平台
*   卡蒙达优化
*   镜头盒
*   Tempo & Tempo Query
*   门尾

### 新的食谱食谱

*   [Apicurio Registry with SQL Storage （PostgreSQL）
    ](../cookbooks/recipes/apicurio-with-database-storage)

*   [在平台上自动管理 Kafka 主题](../cookbooks/recipes/jikkou-automate-kafka-topics-management/README.md)

*   [在一台机器上模拟多直流设置](../cookbooks/recipes/simulated-multi-dc-setup/README.md)

*   [使用 Platys 创建自我管理的 StreamSet 数据运维环境](../cookbooks/recipes/streamsets-dataops-creating-environment/README.md)

*   [在容器启动时加载流集管道](../cookbooks/recipes/streamsets-loading-pipelines/README.md)

*   [使用 Tipboard 和 Kafka](../cookbooks/recipes/tipboard-and-kafka/README.md)

*   [从Trino（以前称为PrestoSQL）在Kafka中查询数据](../cookbooks/recipes/querying-kafka-with-trino/README.md)

*   [使用不在 Confluent Hub 中的 Kafka Connect Connector](../cookbooks/recipes/using-kafka-connector-not-in-confluent-hub/README.md)

### 版本升级

*   更新`DataHub`自`0.8.25`
*   更新`Trino`自`371`
*   更新`Starburst Enterprise`自`369-e`
*   更新`Apache NiFi`自`1.15.0`
*   更新`Hasura`自`v2.0.0-beta.2`
*   更新`ksqlDB`自`0.23.1`
*   更新`Zeppelin`自`0.10.0`
*   更新`Livy`自`0.7.1-incubating`
*   更新`Spark 3`自`3.2`
*   更新`Streamsheets`自`2.5-milestone`
*   更新`Neo4J`自`4.4`
*   更新`Confluent`自`7.0.1`
*   更新`NiFi`自`1.15.2`和`NiFi Registry`自`1.15.1`
*   更新`Marquez`自`0.20.0`
*   更新`Amundsen Frontend`自`4.0.0`和`Amundsen Search`自`3.0.0`
*   更新`InfluxDB 2`自`2.1.1`
*   更新`EventStore`自`21.10.1-buster-slim`
*   更新`Keycloak`自`16.1.1`
*   更新`Dremio`自`20.0`
*   更新`Minio`自`RELEASE.2022-02-01T18-00-14Z`
*   更新`lakeFS`自`0.58.0`
*   更新`Vault`自`1.9.3`
*   更新`Ranger`自`2.2.0`
*   更新`Materialize`自`v0.19.0`
*   更新`kcat`自`1.7.1`
*   更新`Debezium`自`1.8.0.Final`
*   更新`Datastax`自`6.8.19`
*   更新`Elasticsearch`自`7.17.0`
*   更新`Node-RED`自`2.2.0`
*   更新`Spring Dataflow`自`2.9.2`和`Skipper`自`2.8.2`
*   更新`MLflow`自`1.23.1`
*   更新`Optuna Dashboard`自`0.5.0`
*   更新`Kie-Server`自`7.61.0.Final`
*   更新`Grafana`自`8.3.4`
*   更新`Kibana`自`7.17.0`
*   更新`Memchached`自`1.6.13`
*   更新`Solr`自`8.11`
*   更新`DGraph`自`v21.12.0`
*   更新`Stardog`自`7.8.3-java11-preview`
*   更新`GraphDB`自`9.10.1`
*   更新`QuestDB`自`6.2`
*   更新`Druid`自`0.22.1`
*   更新`Pinot`自`0.9.3`
*   更新`Prometheus`自`v2.33.1`和`pushgateway`自`v1.4.2`和`nodeexporter`自`v1.3.1`
*   更新`Tile38`自`1.27.1`
*   更新`Axon`自`4.5.10`
*   更新`Hasura`自`v2.2.0`
*   更新`Emq`自`4.3.11`
*   更新`Cedalo Mgmt Center`自`2.2`
*   更新`Thingsboard`自`3.3.3`
*   更新`RabbitMQ`自`3.9-management`
*   更新`Watchtower`自`1.4.0`

### 重大更改

*   InfluxDB现在正在监听`19999`而不是`9999`
*   都`KAFKA_SCHEMA_REGISTRY_xxxx`重命名为`CONFLUENT_SCHEMA_REGISTRY_xxxx`
*   都`KAFKA_SCHEMA_REGISTRY_UI_xxxx`重命名为`SCHEMA_REGISTRY_UI_xxxx`
*   为本地主机添加其他 Kafka Advertisingd 监听器（端口 39092 - 39099），并将其与 Docker 监听器（$DOCKER_HOST_IP 上，端口为 29092 - 29099）区分开来
*   允许在外部和DOCKER_HOST监听器之间切换 Kafka 标准端口用法（配置参数`KAFKA_use_standard_port_for_external_interface`)
*   `KAFKA_BURROW_enable`重命名为`BURROW_enable`
*   `conf-override`重命名为`custom-conf`为了更好地反映这样一个事实，即此文件夹仅用于重新生成平台时不会被覆盖的配置文件
*   如果手动复制 Kafka Connect 连接器，则不再将它们放入`plugins/kafka-connect`但`plugins/kafka-connect/connectors`
*   重命名`python`配置设置 （`PYTHON_artefacts_folder`和`PYTHON_script_file`)

### 增强

*   Apicurio Schema Registry 作为 Confluent Schema Registry 的直接替代品
*   “服务列表标记”页面（http://dataplatform/services）中的所有服务都包含指向其主页的链接
*   配置页面也链接到 serice 主页
*   支持通过密钥保护在 Apicurio 注册表中进行身份验证和授权
*   添加了对在运行 之前要安装的 PIP 包的支持`python`容器
*   支持将 docker 日志发送到 Grafana Loki

### 错误修复

*   修复了陋居服务的错误
*   `KEYCLOCK`更改为`KEYCLOAK`以反映正确的名称

## 1.13.0 中的新增功能

现代数据平台版本 1.13.0 包含以下错误修复和增强功能：

### 新服务

*   努克利奥·法斯
*   火狐浏览器
*   齐普金
*   Apache Tika Server
*   RStudio
*   闪亮服务器
*   MLflow 服务器
*   奥普图纳
*   Optuna Dashboard
*   Excalidraw
*   Drools KIE Server
*   Drools Business Central Workbench
*   眨眼
*   努斯克纳克设计师
*   九龙
*   Apache Ignite
*   Debezium Server
*   pgAdmin
*   甲骨文XE

### 新的食谱食谱

*   [支持流集数据收集器激活](../cookbooks/recipes/streamsets-oss-activation)

### 版本升级

*   更新`Confluent`自`6.2.0`
*   更新`Marquez`自`0.19.0`
*   更新`Trino`自`363`
*   更新`Starburstdata`自`363-e`
*   更新`DataHub`自`0.8.15`
*   更新`Minio`自`RELEASE.2021-06-17T00-10-46Z`
*   更新`ksqlDB`自`0.20.0`
*   更新`tile38`自`1.25.2`
*   更新`kcat`自`1.7.0`（曾经是`kafkacat`)
*   更新`Elasticsearch`自`7.14.0`
*   更新`Kibana`自`7.14.0`
*   更新`Cassandra`自`3.11`
*   更新`DSE-Server`自`6.8.14`
*   更新`MongoDB`自`5.0`
*   更新`Neo4J`自`4.2`
*   更新`Stardog`自`7.7.1-java11-preview`
*   更新`Stardog-Studio`自`current`
*   更新`Chronograf`自`1.9`
*   更新`Telegraf`自`1.19`
*   更新`Influxdb2`自`2.0.8`（切换到官方 Docker 镜像）
*   更新`Kudu`自`1.15`
*   更新`Pinot`自`0.8.0`
*   更新`Pinot`自`0.8.0`
*   更新`Prometheus`自`v2.29.1`
*   更新`Prometheus Pushgateway`自`v1.4.1`
*   更新`Prometheus Nodeexporter`自`v1.2.2`
*   更新`Yugabyte`自`2.4.6.0-b10`
*   更新`GraphDB`自`9.9.0`
*   更新`Druid`自`0.21.1`
*   更新`Solr`自`8.9`
*   更新`Redis`自`6.2`
*   更新`Memcached`自`1.6.10`
*   更新`Grafana`自`8.2.0`
*   更新`QuestDB`自`6.0.4`
*   更新`Spark`自`3.1.1`
*   更新`Minio`自`RELEASE.2021-09-15T04-54-25Z`
*   更新`Axon Server`自`4.5.7`
*   更新`Hazelcast`自`5.0`
*   更新`Apache Atlas`自`2.2.0`
*   更新`LakeFS`自`0.52.2`
*   更新`Amundsen-Frontend`自`3.13.0`
*   更新`Amundsen-Metadata`自`3.10.0`
*   更新`Amundsen-Search`自`2.11.1`

### 重大更改

*   改变`HAZELCAST_IMDG_xxxxxx`自`HAZELCAST_xxxxxx`
*   改变`ORACLE_xxxxxx`自`ORACLE_EE_xxxxxx`
*   已更改的默认值`KAFKA_CONNECT_nodes`从`2`自`1`
*   改变`KAFKA_EAGLE_enable`自`KAFKA_EFAK_enable`

### 增强

*   文档降价页面被复制到生成的平台中，并在降价查看器中提供
*   支持KRaft模式下的无动物园管理员卡夫卡设置（`KAFKA_use_kraft_mode`)
*   支持设置`SDC ID`设置为 StreamSets 的固定值，以便在重新创建`streamsets-1`泊坞窗容器
*   从切换`cp-enterprise-kafka`自`cp-server`Confluent Enterprise 的图片
*   在单个 Posgresql 容器中支持多个数据库
*   重命名`kafkacat`自`kcat`（以反映 GitHub 项目）
*   添加对 Cassandra 3 和 Cassandra 4 的支持
*   向汇合架构注册表添加其他配置属性
*   支持在启动Jupyter时安装Python软件包
*   在 ksqlDB Server 中添加对嵌入式 Kafka Connect 服务器的支持（set`KAFKA_KSQLDB_use_embedded_connect`自`true`)
*   添加额外的 Kafka UI （Kowl）
*   添加对 Flink 的支持
*   添加对流氓的支持
*   添加对 Ignite 和 Hazelcast 的支持
*   添加对 Otuna 和 MLFlow 的支持
*   添加对启动 Jupyter 时安装 Python 包的支持 （`JUPYTER_python_packages`)
*   为从**服务列表**由 Markdown 查看器呈现的页面

### 错误修复

*   修复错误“死机：运行时错误：切片边界超出范围”`schema-registry-ui`和`kafka-connect-ui`通过允许映射`resolv.conf`放入容器中。默认情况下，它处于启用状态。

## 1.12.1 中的新增功能

现代数据平台版本 1.12.1 包含以下错误修复和增强功能：

### 版本升级

*   更新`NiFi`自`1.13.2`
*   更新`DataHub`自`v0.8.0`
*   更新`ksqlDb`自`0.18.0`
*   更新`Jupyter`自`spark-3.1.1`

### 错误修复

*   修复了由于基于Alpine Linux的Spark映像而无法在先前版本中工作的Thrift服务器

## 1.12.0 中的新增功能

现代数据平台版本 1.12.0 包含以下新服务和增强功能：

### 新服务

*   普罗米修斯节点导出器
*   Kafka Lag Exporter
*   事件存储数据库
*   Camunda Zeebe + Operation + ZeeQs
*   Hazelcast IMDG + 管理中心
*   阿帕奇皮诺
*   湖FS
*   EMQ-X MQTT 经纪商
*   QuestDB Timeseries DB
*   实现
*   Debezium UI

### 新的食谱食谱

*   [使用 log4brains 创建和可视化 ADR](../cookbooks/recipes/creating-adr-with-log4brains)
*   [使用开发模拟器 Orgin 模拟流数据](../cookbooks/recipes/using-dev-simulator-origin)
*   [使用私有 （Trivadis） Oracle XE 映像](../cookbooks/recipes/using-private-oracle-xe-image)
*   [使用私有 （Trivadis） Oracle EE 映像](../cookbooks/recipes/using-private-oracle-ee-image)
*   [使用公共 Oracle XE 映像](../cookbooks/recipes/using-public-oracle-xe-image)

### 版本升级

*   更新`Azkarra`自`0.9.1`
*   更新`Hasura`自`v2.0.0-alpha.9`
*   更新`Marquez`自`0.14.2`
*   更新`Grafana`自`7.5.2`
*   更新`Axonserver`自`4.5`
*   更新`Streamsheets`自`2.3-milestone`
*   更新`Streamsets`自`3.22.2`
*   更新`Trino`自`356`
*   更新`Starburstdata Presto`自`356-e.1`（使用新的`starburst-enterprise`图像）
*   更新`PrestoDB`自`0.253`
*   更新`Ahana`自`0.253`
*   更新`DataHub`自`0.7.1`
*   更新`InfluxDB2`自`2.0.4`
*   更新`Telegraf`自`1.18`
*   更新`MongoDB`自`4.4`
*   更新`Elasticsearch`自`7.12.0`
*   更新`Kibana`自`7.12.0`
*   更新`Neo4J`自`4.2.5`
*   更新`ksqlDB`自`0.17.0`
*   更新`Druid`自`0.21.0`
*   更新`HiveMQ 4`自`4.6.1`
*   更新`Airflow`自`2`

### 增强

*   添加了对使用JMX和Prometheus/Grafana的Kafka监控的支持（来自此的输入[汇合 github 项目](https://github.com/confluentinc/jmx-monitoring-stacks)
*   使用官方的Cloudbeaver Docker图像，不再是琐事
*   [解决方案文档结束](https://github.com/TrivadisPF/platys/blob/master/documentation/docker-compose-without-internet.md)关于如何在目标基础设施上使用Platys生成的平台，而无需互联网

## 1.11.0 中的新增功能

现代数据平台版本 1.11.0 包含以下新服务和增强功能：

### 新服务

*   增加了了望塔
*   哈苏拉已添加
*   已添加 Dgraph
*   已添加文件浏览器
*   添加了 MinIO MC CLI
*   Kafka UI 已添加
*   Adminio UI 已添加
*   添加了 MinIO 控制台
*   S3 管理器已添加
*   文件标记已添加
*   SQLPad 已添加
*   添加了 GraphQL 网格
*   流资源管理器已添加
*   已添加事物板社区
*   邮递员已添加
*   已添加按键
*   添加了微克
*   数据科学工作室已添加
*   卡夫卡鹰添加
*   特里诺添加
*   图形数据库已添加
*   已添加 PostgREST
*   添加了 Log4brains

### 新的食谱食谱

*   [Spark with PostgreSQL](../cookbooks/recipes/spark-with-postgresql)
*   [使用最小 IO 查询 S3 数据 （MinIO）](../cookbooks/recipes/querying-minio-with-trino/)
*   [使用 Trino 查询 Kafka 数据](../cookbooks/recipes/querying-kafka-with-trino/)

### 版本升级

*   更新`Elasticsearch`自`7.10.1`
*   更新`Kibana`自`7.10.1`
*   更新`HiveMQ4`自`4.5.0`
*   更新`Streamsets Transformer`自`3.17.0`
*   更新`Axon Server`自`4.4.5`
*   切换到官方`Streamsets DataCollector`之`3.21.0`
*   更新`Marquez`自`0.12.2`
*   更新`Cedalo Management Center`自`2.1`
*   更新`Confluent Platform`自`6.1.0`
*   更新`ksqlDB`自`0.15.0`
*   更新`APICurio Registry`自`1.3.2`
*   更新`Starburstdata Presto`自`350-e.5`
*   更新`Ahana PrestoDB`自`0.249`
*   更新`PrestoDB`自`0.249`
*   更新`DataHub`自`0.7.0`

### 增强

*   允许在启动 StreamSet 时配置要安装的其他 StreamSets 阶段库（我们不再使用 Trivadis docker 映像）
*   支持在启动流集时自动安装流集管道
*   支持Trino与PrestoDB（Presto的另一个分支）并行添加（重命名为PrestoSQL项目）

## 1.10.0 中的新增功能

现代数据平台版本 1.10.0 包含以下新服务和增强功能：

### 新服务

*   春季云数据流

### 新的食谱食谱

*   [使用其他 Kafka 连接连接器](../cookbooks/recipes/using-additional-kafka-connect-connector)
*   [Custom UDF 和 ksqlDB](../cookbooks/recipes/custom-udf-and-ksqldb)
*   [使用汇合 MQTT 代理](../cookbooks/recipes/using-mqtt-proxy/)
*   [具有内部 S3 的火花（在 minIO 上使用）](..cookbooks//recipes/spark-with-internal-s3)
*   [带外部 S3 的火花](../cookbooks/recipes/spark-with-extern-s3)

### 版本升级

*   更新`ksqlDB`自`0.14.0`
*   更新`Streamsheets`自`2.2`
*   更新`Zeppelin`自`0.9.0`
*   更新`Confluent`自`6.0.1`
*   更新`Presto`自`348-e`
*   更新`Stardog`自`7.4.5-java11-preview`和`Stardog Studio`自`1.30.0`

### 增强

*   添加将降价查看器的端口更改为的选项`8000`，默认值仍为端口`80`.
*   添加一个选项以使用`DOCKER_HOST_IP`变量而不是`PUBLIC_IP`变量，用于指向服务的 Web 链接。
*   改变`minio`图像到一个从`bitnami`，允许在服务启动时创建存储桶
*   允许配置`spark.max.cores`和`spark.executor.memory`（齐柏林）
*   允许配置`SPARK_MASTER_OPTS`和`SPARK_WORKER_OPTS`,`SPARK_WORKER_CORES`,`SPARK_WORKER_MEMORY`对于火花
*   添加了对在 Spark 2 和 Spark 3 之间切换的支持
*   更改默认值`KAFKA_delete_topic_enable`自`true`
*   加`KAFKA_SCHEMA_REGISTRY_UI_use_public_ip`在架构注册表 UI 的公共和 Docker 主机 IP 地址之间进行更改
*   使管理员用户和“普通”用户可在齐柏林飞艇中配置
*   齐柏林飞艇的配置文件不再从`conf`文件夹进入容器，它现在是“预构建”到新的齐柏林飞艇 Docker 映像。
*   添加了对 Spark 3.0 的支持
*   添加对在每个笔记本上启用齐柏林飞艇 cron 调度程序的支持

### 错误修复

*   修复了 中引入的内部 S3 （minIO） 的错误`1.9.0`

## 1.9.0 中的新增功能

现代数据平台版本 1.9.0 包含以下新服务和增强功能：

### 新服务

*   Redis Insight
*   薇琪
*   Markdown 查看器（默认情况下启用，呈现有关平台的文档）
*   镍铁注册

### 版本升级

*   改变`Redis`到比特纳米图像
*   更新`DataHub`自`0.6.1`
*   更新`Portainer`自`2.0.0`
*   更新`CAdvisor`自`v0.36.0`
*   更新`Marquez`自`0.11.3`和 Marquez UI 到`0.7.0`
*   更新`Apache NiFi`自`1.12.1`
*   更新`StreamSets Data Collector`自`3.19.0`
*   更新`ksqlDB`自`0.13.0`
*   更新`Hue`自`4.8.0`
*   更新`Amundsen-Frontend`自`3.0.0`
*   更新`Amundsen-Metadata`自`3.0.0`
*   更新`Amundsen-Search`自`2.4.1`
*   更新`Presto`自`347-e`
*   更新`Dremio`自`4.9`
*   更新`MongoDB`自`4.4.2`
*   更新`MongoDB`自`4.2.0`
*   更新`InfluxDB 2.0`自`v2.0.2`
*   更新`Druid`自`0.20.0`
*   更新`Memcached`自`1.6.9`
*   更新`Kudu`自`1.13`
*   更新`Prometheus`自`v2.23.0`和`Prometheus-Pushgateway`自`v1.3.0`
*   更新`Tile38`自`1.22.5`
*   更新`Grafana`自`7.3.4`
*   更新`Stardog`自`7.4.4-java11-preview`和`Stardog Studio`自`1.29.1`
*   更新`Yugabyte`自`2.5.0.0-b2`
*   更新`Axon`自`4.4.5`
*   更新`Presto`自`346-e`
*   更新`Dremio`自`11.0`
*   更新`HiveMQ3`自`3.4.7`和`HiveMQ4`自`4.4.3`
*   更新`Vault`自`1.6.0`
*   更新`Airflow`自`1.10.13`
*   更新`Atlas`自`2.1.0`
*   更新`Ranger`自`2.1.0`
*   更新`Mosquitto`自`2.0`
*   更新`Streamsheets`自`2.1-milestone`

### 增强

*   支持主/从 Redis 设置
*   自动将 docker 网络的名称设置为`platform-name`属性从`config.yml`
*   允许添加`ConfigProvider`类到`kafka-connect`服务支持在连接器配置中使用在连接器配置中动态解析的变量。
*   使用生成的平台上的信息渲染降价文件
*   将配置属性添加到`ksqldb-server`启用新的抑制功能并使用查询文件
*   支持外部`Kafka`群集（在 1.8 中处于预览状态）和`S3`使用新的对象存储`external`部分
*   支持设置访问密钥和要使用的密钥`minio`在`config.yml`使用与以前相同的默认值
*   支持数据和日志文件夹的卷映射`nifi`服务

### 重大更改

*   将 docker-compose 版本更新为`3.5`（需要 Docker 引擎版本 17.12.0 及更高版本）
*   映射的卷`data`文件夹 （`STREAMSETS_volume_map_data=true`） 现在映射到`container-volume/streamsets-1/data`并且不再`container-volume/streamsets-1`
*   不再使用`KAFKA_bootstrap_servers`配置外部 kafka，但`external['KAFKA_enable']`属性在`config.yml`

### 错误修复

*   修复了使用`STREAMSETS_volume_map_data`特征

## 1.8.0 中的新增功能

现代数据平台版本 1.8.0 包含以下新服务和增强功能：

### 新服务

*   Apicurio Registry
*   粉碎达什堡
*   提示板仪表板
*   图表板仪表板
*   阿兹卡拉溪流

### 版本升级

*   更新`DataHub`自`0.5.0-beta`
*   更新`StreamSheets`自`2.0-milestone`
*   更新`StreamSets`自`3.18.1`
*   更新`Confluent Platfrom`自`6.0.0`
*   更新`ksqlDB`自`0.12.0`

### 增强

*   使Postgreqsql用户，密码和数据库可配置
*   支持配置`KAFKA_MQTTPROXY_topic_regex_list`上`KAFKA_MQTTPROXY`
*   自动创建`default-bucket`在 米尼奥 如果`MINIO_ENABLE`是`true`
*   支持各种附加的 Kafka 代理属性，例如`KAFKA_message_timestamp_type`,`KAFKA_replica_selector_class`,`KAFKA_min_insync_replicas`,`KAFKA_log_segement_bytes`,`KAFKA_log_retention_ms`,`KAFKA_log_retention_hours`,`KAFKA_log_retention_bytes`,`KAFKA_compression_type`和`KAFKA_confluent_log_placement_constraints`
*   支持 Kafka 分层存储`confluent.tier.xxxx`性能
*   支持`STREAMSETS_volume_map_security_policy`属性在`streamsets`服务

### 重大更改

*   Postgresql 服务的默认用户已更改为`demo`和数据库`demodb`.
*   更改服务名称`redis`自`redis-1`
*   更改属性` RANGER_POSTGRESQL_volume_map_data  `自`RANGER_postgresql_volume_map_data`对于`RANGER`服务

### 错误修复

*   支持`hive`已修复 SPARK 中的选项，以便 Spark 可以使用 Hive 元存储，而不是默认的内置元存储

## 1.7.0 中的新增功能

**注意：**您必须安装最新版本的[`platys`](http://github/trivadispf/platys)（> 2.3.0）以使用此新版本的平台堆栈。

现代数据平台版本 1.7.0 包含以下新服务和增强功能：

### 新服务

*   雷达什
*   Memcached
*   Stardog & Stardog Studio

### 增强功能/更改

*   将 JMX 监视添加到 ksqldb-server-X 服务
*   允许在 Apache Kafka 的群集管理器 （CMAK） 服务中启用基本身份验证
*   重构了平台属性 （`platform-stack`和`platform-stack-version`） 以匹配[版本 2.3.0](https://github.com/TrivadisPF/platys/blob/master/documentation/changes.md#whats-new-in-230)之`platys`.

## 1.6.0 中的新增功能

现代数据平台版本 1.6.0 包含以下新服务和增强功能：

### 新服务

*   Quix Database UI （Notebook-style）
*   彭索网勺
*   霍蒂奥
*   兔子MQ
*   云海狸
*   Swagger Editor & Swagger UI
*   卡夫卡卡特
*   流表
*   融合复制器
*   Presto CLI
*   Apache Ranger （preview）

### 增强功能/更改

*   仅当`-v`标志传递在`platys`命令行
*   升级`ksqlDB`默认版本到最新版本`0.9.0`
*   支持在启动时自动将 Confluent Hub 连接器安装到 Kafka Connect 中
*   支持 Presto 集群和单个 Presto 实例
*   支持Prestosql和Prestodb开源Presto分叉以及新的Ahana Prestodb订阅

## 1.5.2 中的新增功能

1.5.2 只是一个没有新服务的修复版本。

### 增强功能/更改

*   添加指定私有 maven 存储库的可能性，用于在 Spark、Livy 和 Zeppelin 中下载 maven 包
*   允许在 中指定其他运行时环境属性`spark-defaults.conf`

### 错误修复

*   修复一代陋居和动物园管理员导航器服务
*   修复从 Spark Master UI 到 Spark UI 的非工作链接

## 1.5.1 中的新增功能

1.5.1 只是一个没有新服务的修复版本。

### 错误修复

*   修复 Hadoop 服务

## 1.5.0 中的新增功能

现代数据平台版本 1.5.0 包含以下新服务和增强功能：

### 新服务

*   添加了 Oracle XE（仅通过私有 Docker 映像）
*   添加了 Oracle EE（仅通过私有 Docker 映像）
*   添加了 Oracle REST Data Service（仅通过私有 Docker 映像）
*   Hashicorp Vault 已添加
*   已添加 Yugabyte 数据库
*   马尔克斯添加
*   Apache Ranger 已添加

### 增强功能/更改

*   改变`drill`,`dremio`和`presto`以包括服务实例编号，即`<service>-1`准备支持多个实例
*   支持全局更改所有 Docker 映像的时区 （`use_timezone`)
*   新配置设置 （` private_docker_repository_name  `） 以更改私有存储库以用于私有 Docker 映像
*   修复了 Kafka 服务的 JMX 端口
*   添加了对其他 Kafka 属性的支持

## 1.4.0 中的新增功能

现代分析数据平台堆栈版本 1.4.0 包含以下新服务和增强功能：

### 新服务

*   添加了 Kafka Topics UI
*   Apache Drill 已添加
*   数据中心已添加
*   添加了 Apache Druid（目前仅支持单服务器沙盒）
*   添加了 Apache 超集

### 增强功能/更改

*   Elastisearch UI（Kibana，DejaVu，Cerebro，ElasticHQ）独立于Elasticsearch。

## 1.3.0 中的新增功能

现代分析数据平台堆栈版本 1.3.0 包含以下新服务和增强功能：

### 新服务

*   阿帕奇气流
*   Apache Sqoop（以前是`hadoop-client`服务）
*   代码服务器（与浏览器中的代码 IDE 相对）

### 增强功能/更改

*   添加了一些第一个简单的教程，展示了如何使用这些服务
*   Hadoop图像更改为来自欧洲大数据的图像
*   服务Kafka Manger现在是CMAK（由于Yahoo GitHub的名称更改）
*   KafkaHQ已被开发人员重命名为AKHQ，我们现在使用此映像

## 1.2.0 中的新增功能

现代分析数据平台堆栈版本 1.2.0 包含以下新服务和增强功能：

### 新服务

*   Confluent Enterprise as a Edition for Kafka
*   Streamset Data Collector Edge
*   流集变压器
*   Apache NiFi
*   各种 Jupyter 服务
*   节点红色
*   Influx Data Tick Stack （influxdb， chronograf， kapacitor）
*   流入 DB 2.0-alpha

### 增强功能/更改

*   将某些端口重构回原始端口

*   重命名以下位置的所有属性`XXXX_enabled`自`XXXX_enable`

*   重命名“XXXX_yyyy_enabled中的所有属性`  to 'XXXX_YYYY_enabled `明确区分产品/服务和属性

*   重命名`connect-n`服务到`kafka-connect-n`更清晰

*   重命名`broker-n`服务到`kafka-n`更清晰

*   升级到 Confluent Platform 5.4.0

*   加[版本概念](service-design.md)用于卡夫卡和朱皮特服务
