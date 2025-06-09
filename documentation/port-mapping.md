# `modern-data-platform` - Port Mappings - 1.18.1

This table reserves the external ports for the various services. Not all services have to be used in the platform at a given time. But by reserving, we can assure that there are no conflicts if a service is added at a later time.

## "Original" Ports

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
21 | 21 | ftp |
80 | 80 | markdown-viewer, markdown-viewer-dc1 or firefox |
81 | 80 | markdown-viewer-dc2 |
82 | 80 | markdown-viewer-dc3 |
1222 | 1222 | risingwave | 
1234 | 1234 | kafka-1 (prometheus exporter) | 
1235 | 1234 | kafka-2 (prometheus exporter) | 
1236 | 1234 | kafka-3 (prometheus exporter) | 
1237 | 1234 | kafka-4 (prometheus exporter) | 
1238 | 1234 | kafka-5 (prometheus exporter) | 
1239 | 1234 | kafka-6 (prometheus exporter) | 
1240 | 1234 | zookeeper-1 (prometheus exporter) | 
1241 | 1234 | zookeeper-2 (prometheus exporter) | 
1242 | 1234 | zookeeper-3 (prometheus exporter) | 
1250 | 1250 | risingwave | 
1260 | 1260 | risingwave | 
1270 | 1234 | nifi-1 (prometheus exporter) | 
1271 | 1234 | nifi-2 (prometheus exporter) | 
1272 | 1234 | nifi-3 (prometheus exporter) | 
1273 | 1234 | nifi2-1 (prometheus exporter) | 
1274 | 1234 | nifi2-2 (prometheus exporter) | 
1275 | 1234 | nifi2-3 (prometheus exporter) | 
1337 | 1337 | konga | 
1433 | 1433 | sqlserver |
1522 | 1521 | oracledb-xe |
1523 | 1521 | oracledb-oci-free |
1524 | 1521 | oracledb-free |
1525 | 1521 | oracle-adb |
1526 | 1522 | oracle-adb |
1530 | 1521 | oracledb-ee-1 |
1531 | 1521 | oracledb-ee-2 |
1532 | 1521 | oracledb-ee-3 |
1095 | 1095 | ksqldb-server-1 (jmx) |
1096 | 1096 | ksqldb-server-2 (jmx) |
1097 | 1097 | ksqldb-server-3 (jmx) |
1113 | 1113 | eventstore |
1880 | 1880 | nodered-1 |
1882 | 1882 | kafka-mqtt-1 |
1883 | 1883 | mosquitto-1 |
1884 | 1883 | mosquitto-2 |
1885 | 1883 | mosquitto-3 |
1886 | 1883 | hivemq3-1 |
1887 | 1883 | hivemq3-2 |
1888 | 1883 | hivemq4-1 |
1889 | 1883 | hivemq4-2 |
1890 | 1883 | activemq |
1891 | 1883 | emqx-1 |
1892 | 1883 | solace-pubsub |
2022 | 2022 | sftpgo (sftp) |
2024 | 2024 | ollama-deep-researcher |
2113 | 2113 | eventstore |
2181 | 2181 | zookeeper-1 |
2182 | 2182 | zookeeper-2 |
2183 | 2183 | zookeeper-3 |
2184 | 2184 | zookeeper-4 |
2185 | 2185 | zookeeper-5 |
2186 | 2186 | zookeeper-6 |
2222 | 22 | sftp |
2376 | 2376 | docker-dind |
2379 | 2379 | etcd-1 (client req) |
2380 | 2380 | etcd-1 (peer comm) |
2381 | 2381 | etcd-1 (metrics) |
2424 | 2424 | arcadedb |
2480 | 5432 | arcadedb (postgresql port) |
2481 | 6379 | arcadedb (redis port) |
2482 | 2480 | arcadedb (mongodb port) |
2483 | 27017 | arcadedb |
3000 | 3000 | grafana |
3001 | 3000 | wetty (dc1) |
3002 | 3000 | wetty (dc2 |
3003 | 3003 | opik-backend |
3005 | 3000 | marquez-web |
3010 | 3000 | postman |
3006 | 3000 | retool-api |
3007 | 3000 | gpt-researcher-nextjs |
3030 | 3030 | jena-fuseki |
3100 | 3100 | loki |
3200 | 3200 | tempo |
3218 | 3218 | proton-server (HTTP streaming)
3306 | 3306 | mysql |
3307 | 3306 | datahub-mysql |
3308 | 3306 | single-store |
3309 | 3306 | mariadb |
3310 | 3306 | openmetadata-mysql |
3333 | 3333 | taskcafe |
3355 | 3355 | vector-admin | 
3838 | 3838 | shiny-server |
3900 | 3900 | garage |
3901 | 3901 | garage |
3902 | 3902 | garage |
3903 | 3903 | garage |
3909 | 3909 | garage-webui |
4000 | 4000 | graphql-mesh |
4001 | 4000 | supabase-analytics |
4002 | 4000 | litellm |
4004 | 4004 | log4brains |
4040 | 4040 | spark-master (ui) |
4041 | 4041 | spark-master (ui) |
4042 | 4042 | spark-master (ui) |
4043 | 4043 | spark-master (ui) |
4044 | 4044 | spark-master (ui) |
4050 | 4050 | zeppelin (spark ui) |
4051 | 4051 | zeppelin (spark ui) |
4052 | 4052 | zeppelin (spark ui) |
4053 | 4053 | zeppelin (spark ui) |
4054 | 4054 | zeppelin (spark ui) |
4195 | 4195 | benthos-1 |
4196 | 4196 | benthos-server |
4200 | 4200 | cribl-master |
4222 | 4222 | nats-1 |
4317 | 4317 | otel-collector |
4318 | 4317 | arize-phoenix |
4466 | 4466 | curity |
4566 | 4566 | risingwave |
5000 | 5000 | amundsenfrontend |
5001 | 5000 | amundsensearch |
5002 | 5000 | amundsenmetadata |
5005 | 5005 | neodash |
5010 | 5000 | marquez |
5011 | 5001 | marquez |
5020 | 5020 | docker-registry |
5050 | 5050 | zeppelin |
5051 | 5050 | data-product-portal-nginx |
5115 | 5115 | arroyo |
5173 | 5173 | opik-frontend |
5432 | 5432 | postgresql |
5433 | 5432 | timescaledb |
5434 | 5432 | marquez-db |
5435 | 5432 | dataverse-postgresql |
5436 | 5432 | infinity (postgresql) |
5437 | 5432 | openmetadata-postgresql |
5438 | 5432 | langwatch-postgresql |
5439 | 5432 | data-product-portal-postgresql |
5440 | 5432 | proton-server (postgres batch) |
5441 | 5432 | supabase-db |
5442 | 5432 | hive-metastore-db |
5500 | 5500 | oracledb-ee-1 |
5501 | 5500 | oracledb-ee-1 |
5502 | 5500 | oracledb-ee-1 |
5521 | 5521 | clickhouse-ui |
\-     | 5432 | hive-metastore-db |
\-     | 5432 | hue-db |
5555 | 5555 | airflow-flower |
5560 | 5560 | langwatch-app |
5601 | 5601 | kibana |
5602 | 5601 | datahub-kibana |
5603 | 5601 | opensearch-dashboards |
5690 | 5690 | risingwave |
5691 | 5691 | risingwave |
5672 | 5672 | activemq |
5673 | 5672 | rabbitmq (amqp) |
5674 | 5672 | solace-pubsub (amqp) |
5678 | 5678 | n8n |
5701 | 5701 | hazelcast	-1 |
5705 | 5701 | zeebe-1 |
5778 | 5778 | jaeger (config) |
5800 | 5800 | filezilla |
5801 | 5800 | firefox |
5820 | 5820 | stardog-1 |
5900 | 5900 | filezilla |  
6006 | 6006 | arize-phoenix |
6060 | 6060 | zeppelin |
6066 | 6066 | spark-master |
6080 | 6080 | ranger-admin |
6222 | 6222 | nats-1 |
6333 | 6333 | qdrant |
6334 | 6334 | qdrant |
6379 | 6379 | redis-1 |
6380 | 6379 | redis-replica-1 |
6381 | 6379 | redis-replica-2 |
6382 | 6379 | redis-replica-3 |
6385 | 6379 | redis-stack-1 |
6385 | 6379 | redash-redis |
6386 | 6379 | tyk-redis |
6387 | 6379 | ragflow-redis |
6388 | 6379 | langwatch-redis |
6389 | 6379 | valkey-1 (if not redis ports are used) |
6390 | 6379 | valkey-replica-1 |
6391 | 6379 | valkey-replica-2 |
6392 | 6379 | valkey-replica-3 |
6543 | 6543 | supabase-supavisor |
6570 | 6570 | hserver-1 |
6831 | 6831 | jaeger (udp) |
6749 | 6749 | curity |
6789 | 6789 | mage-ai |
6832 | 6832 | jaeger (udp) |
6875 | 6875 | materialize-1 |
7000 | 7000 | yb-master |
7002 | 7002 | opal-server |
7050 | 7050 | kudu-tserver-1 |
7051 | 7051 | kudo-master-1 |
7077 | 7077 | spark-master |
7199 | 7199 | cassandra-1 |
7200 | 7199 | cassandra-2 |
7201 | 7199 | cassandra-3 |
7202 | 7199 | cassandra-4 |
7203 | 7199 | cassandra-5 |
7373 | 7373 | minio-kes |
7444 | 7444 | memgraph-platform |
7474 | 7474 | neo4j-1 |
7475 | 7474 | neo4j-2 |
7476 | 7474 | neo4j-3 |
7477 | 7474 | neo4j-4 |
7577 | 7577 | spring-skipper-server |
7587 | 7587 | proton-server (TCP batch)
7687 | 7687 | neo4j-1 |
7688 | 7687 | neo4j-2 |
7689 | 7687 | neo4j-3 |
7690 | 7687 | neo4j-4 |
7699 | 7687 | memgraph-platform |
7860 | 7860 | langflow|
8000 | 8000 | kong (proxy) |
8001 | 8001 | kong (admin api) |
8002 | 8002 | kong (admin gui) |
8008 | 80 | markdown-viewer, markdown-viewer-dc1 |
8009 | 80 | markdown-viewer-dc2 |
8010 | 80 | markdown-viewer-dc3 |
8024 | 8024 | axon-server |
8047 | 8047 | drill |
8048 | 8048 | kafka-eagle |
8050 | 8050 | kudu-tserver-1 |
8051 | 8051 | kudo-master-1 |
8055 | 8055 | directus |
8070 | 8070 | nuclio |
8080 | 8080 | spark-master |
8081 | 8081 / 8080 | schema-registry-1 / apicurio-registry-1    |
8082 | 8081 / 8080 | schema-registry-2 / apicurio-registry-2    |
8083 | 8083 | connect-1 |
8084 | 8084 | connect-2 |
8085 | 8085 | connect-3 |
8086 | 8086 | influxdb |
8088 | 8088 | ksqldb-server-1 |
8089 | 8088 | ksqldb-server-2 |
8090 | 8088 | ksqldb-server-3 |
8100 | 8100 | kong-map |
8123 | 8123 | proton-server (HTTP batch) |
8124 | 8124 | axon-server |
8161 | 8161 | activemq |
8182 | 8182 | janusgraph |
8200 | 8200 | vault |
8222 | 8222 | nats-1 |
8288 | 8288 | vector-admin |
9380 | 9380 | ragflow |
8443 | 8443 | kong (proxy ssl) |
8444 | 8444 | kong (admin api ssl) |
8446 | 8443 | curity |
8447 | 8443 | oracle-adb |
8463 | 8463 | proton-server (TCP streaming)
8501 | 8501 | crewai-studio | 
8585 | 8585 | openmetadata-server |
8586 | 8586 | openmetadata-server |
8686 | 8686 | supabase-vector |
8761 | 8761 | ioevent-cockpit-api |
8787 | 8787 | r-studio |
8812 | 8812 | questdb |
8815 | 8815 | quackflight |
8888 | 8888 | hue |
8978 | 8978 | cloudbeaver |
8983 | 8983 | solr |
8998 | 8998 | livy |
9000 | 9000 | minio-1 |
9001 | 9000 | minio-2 |
9002 | 9000 | minio-3 |
9003 | 9000 | minio-4 |
9009 | 9009 | questdb |
9010 | 9010 | minio-1 ui |
9011 | 9011 | minio-2 ui |
9012 | 9012 | minio-3 ui |
9013 | 9013 | minio-4 ui |
9042 | 9042 | dse-1 |
9043 | 9042 | dse-2 |
9044 | 9042 | dse-3 |
9047 | 9047 | dremio |
9097 | 9097 | mcp-trino |
9101 | 9001 | mosquitto-1 |
9102 | 9002 | mosquitto-2 |
9103 | 9003 | mosquitto-3 |
9121 | 9121 | redis-exporter |
9200 | 9200 | elasticsearch-1 |
9201 | 9200 | langwatch-opensearch |
9300 | 9300 | elasticsearch-1 |
9160 | 9160 | cassandra-1 |
9161 | 9160 | cassandra-2 |
9162 | 9160 | cassandra-3 |
9163 | 9160 | cassandra-4 |
9164 | 9160 | cassandra-5 |
9083 | 9083 | hive-metastore |
9021 | 9021 | control-center (dc1) |
9022 | 9021 | control-center (dc2) |
9090 | 9090 | prometheus-1 |
9091 | 9091 | prometheus-pushgateway |
9092 | 9092 | kafka-1     |
9093 | 9093 | kafka-2     |
9094 | 9094 | kafka-3     |
9095 | 9095 | kafka-4     |
9096 | 9096 | kafka-5     |
9097 | 9097 | kafka-6     |
9098 | 9098 | kafka-7     |
9099 | 9099 | kafka-8     |
9192 | 9192 | lenses-box     |
9292 | 9292 | pact-broker     |
9343 | 9343 | klaw-cluster-api |
9363 | 9363 | proton-server (Prometheus Metrics) |
9393 | 9393 | spring-dataflow-server |
9411 | 9411 | zipkin |
9412 | 9412 | jaeger |
9413 | 9413 | pitchfork |
9443 | 9443 | lfh-fhir |
9600 | 9600 | zeebe-1 |
9601 | 9600 | langwatch-opensearch  |
9851 | 9851 | tile38 |
9870 | 9870 | namenode |
9864 | 9864 | datanode-1 |
9865 | 9864 | datanode-2 |
9866 | 9864 | datanode-3 |
9867 | 9864 | datanode-4 |
9868 | 9864 | datanode-5 |
9869 | 9864 | datanode-6 |
9992 | 9992 | kafka-1 (jmx) |
9993 | 9993 | kafka-2 (jmx) |
9994 | 9994 | kafka-3 (jmx) |
9995 | 9995 | kafka-4 (jmx) |
9996 | 9996 | kafka-5 (jmx) |
9997 | 9997 | kafka-6 (jmx) |
9998 | 9998 | kafka-7 (jmx) |
9999 | 9999 | kafka-8 (jmx) |
10000 | 10000 | hive-server |
10001 | 10001 | hive-server |
10002 | 10002 | hive-server |
10005 | 10000 | nifi-1 |
10006 | 10000 | nifi-2 |
10007 | 10000 | nifi-3 |
10015 | 10000 | nifi2-1 |
10016 | 10000 | nifi2-2 |
10017 | 10000 | nifi2-3 |
10009 | 10009 | kyuubi |
10099 | 10099 | kyuubi |
11211 | 11211 | memcached |
11212 | 11211 | ignite-1 |
11235 | 11235 | crawl4ai |
11434 | 11434 | ollama |
12222 | 2222 | risingwave |
13133 | 13133 | otel-collector |
14250 | 14250 | jaeger (model.proto port)
14271 | 14271 | jaeger (admin port) |
14040 | 4040 | jupyter (spark ui) |
14041 | 4041 | jupyter (spark ui) |
14042 | 4042 | jupyter (spark ui) |
14043 | 4043 | jupyter (spark ui) |
14044 | 4044 | jupyter (spark ui) |
15433 | 5433| yb-tserver-1 |
15672 | 15672 | rabbitmq (ui) |
16379 | 6379| yb-tserver-1 |
16686 | 16686 | jaeger |
17200 | 7200 | graphdb-1 |
17300 | 7300 | graphdb-1 |
17474 | 7474 | amundsen-neo4j |
17687 | 7687 | amundsen-neo4j |
17475 | 7474 | datahub-neo4j |
17688 | 7687 | datahub-neo4j |
18080 | 8080 | nifi-1 |
18081 | 8080 | nifi-2 |
18082 | 8080 | nifi-3 |
18083 | 8080 | nifi2-1 |
18084 | 8080 | nifi2-2 |
18085 | 8080 | nifi2-3 |
18088 | 8088 | resourcemanager |
18042 | 8042 | nodemanager |
18083 | 8083 | replicator-1 |
18086 | 8086 | kafka-rest-1 |
18087 | 8086 | kafka-rest-2 |
18088 | 8086 | kafka-rest-3 |
18188 | 8188 | historyserver |
18620 | 18629 | streamsets-1     |
18621 | 18629 | streamsets-2     |
18622 | 18629 | streamsets-3     |
18630 | 18630 | streamsets-1     |
18631 | 18630 | streamsets-2     |
18632 | 18630 | streamsets-3     |
18633 | 18633 | streamsets-edge-1 |
19000 | 9000 | yb-tserver-1 |
19042 | 9042 | cassandra-atlas |
19043 | 9042 | cassandra-atlas |
19090 | 19090 | nifi-registry |
19160 | 9160 | cassandra-atlas |
19200 | 9200 | elasticsearch-atlas |
19201 | 9200 | amundsen-elasticsearch |
19202 | 9200 | datahub-elasticsearch |
19203 | 9200 | openmetadata-elasticsearch |
19092 | 19092 | kafka-1 (docker-host)   |
19093 | 19093 | kafka-2 (docker-host    |
19094 | 19094 | kafka-3 (docker-host)   |
19095 | 19095 | kafka-4 (docker-host)   |
19096 | 19096 | kafka-5 (docker-host)   |
19097 | 19097 | kafka-6 (docker-host)   |
19098 | 19098 | kafka-7 (docker-host)   |
19099 | 19099 | kafka-8 (docker-host)   |
19120 | 19120 | nessie |
19121 | 9000 | nessie (management port) |
19630 | 19630 | streamsets-transformer-1 |
19631 | 19630 | streamsets-transformer-1 |
19632 | 19630 | streamsets-transformer-1 |
19999 | 9999 | influxdb2 |
21000 | 21000 | atlas |
23817 | 23817 | infinity (thrift) |
23820 | 23820 | infinity (http) |
24224 | 24224 | fluentd |
24225 | 24224 | fluent-bit |
26500 | 26500 | zeebe-1 |
27017 | 27017 | mongodb-1 |
27018 | 27017 | mongodb-2 |
27019 | 27017 | mongodb-3 |
27020 | 27017 | mongodb-3 |
27022 | 27017 | oracle-adb |
28080 | 8080 | zeppelin |
28081 | 8080 | presto-1 |
28082 | 8080 | trino-1 |
28083 | 8080 | trino-2 |
28084 | 8080 | trino-3 |
28087 | 8443 | trino-1 (tls) |
28088 | 8443 | trino-2 (tls) |
28089 | 8443 | trino-3 (tls) |
28888 | 8888 | jupyter |
28889 | 8888 | anaconda |
29042 | 9042 | cassandra-1 |
29043 | 9042 | cassandra-2 |
29044 | 9042 | cassandra-3 |
29045 | 9042 | cassandra-4 |
29046 | 9042 | cassandra-5 |
29092 | 29092 | kafka-1 (docker-host)   |
29093 | 29093 | kafka-2 (docker-host    |
29094 | 29094 | kafka-3 (docker-host)   |
29095 | 29095 | kafka-4 (docker-host)   |
29096 | 29096 | kafka-5 (docker-host)   |
29097 | 29097 | kafka-6 (docker-host)   |
29098 | 29098 | kafka-7 (docker-host)   |
29099 | 29099 | kafka-8 (docker-host)   |
29200 | 9200 | opensearch-1 |
29600 | 9600 | opensearch-1 |
31010 | 31010 | dremio |
32010 | 32010 | dremio |
39092 | 29092 | kafka-1 (localhost)   |
39093 | 29093 | kafka-2 (localhost    |
39094 | 29094 | kafka-3 (localhost)   |
39095 | 29095 | kafka-4 (localhost)   |
39096 | 29096 | kafka-5 (localhost)   |
39097 | 29097 | kafka-6 (localhost)   |
39098 | 29098 | kafka-7 (localhost)   |
39099 | 29099 | kafka-8 (localhost)   |
47334 | 47334 | mindsdb |
47335 | 47335 | mindsdb |
47336 | 47336 | mindsdb |
45678 | 45678 | dremio |
50000 | 50000 | jenkins |
50051 | 50051 | weaviate |
50092 | 50092 | solace-kafka-proxy |
61613 | 61613 | activemq (stomp) |
61614 | 61614 | activemq (ws) |
61616 | 61616 | activemq (jms) |

## Ports > 28100

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
28100 | 8010 | zoonavigator-web     |
28101 | 9010 | zoonavigator-api     |
28102 | 8000 | schema-registry-ui   |
28103 | 8000 | kafka-connect-ui     |
28104 | 9000 | cmak (dc1) |
28105 | 9000 | cmak (dc2) |
28106 | 8080 | kadmin     |
28107 | 8080 | akhq (dc1)    |
28108 | 8080 | akhq (dc2)     |
28110 | 9020 | kafdrop     |
28111 | 28111 | spark-worker-1 |
28112 | 28112 | spark-worker-2 |
28113 | 28113 | spark-worker-3 |
28114 | 28114 | spark-worker-4 |
28115 | 28115 | spark-worker-5 |
28116 | 28116 | spark-worker-6 |
28117 | 18080 | spark-history |
28118 | 10000 | spark-thriftserver |
28119 | 8081 | redis-commander |
28120 | 3000 | dbgate |
28121 | 9091 | dse-studio |
28122 | 8888 | dse-opscenter |
28123 | 8081 | mongo-express |
28124 | 1234 | admin-mongo |
28125 | 1358 | dejavu |
28126 | 9000 | cerebro |
28127 | 5000 | elastichq |
28128 | 80 | influxdb-ui |
28129 | 8888 | chronograf |
28130 | 9092 | kapacitor |
28131 | 8080 | adminer |
28132 | 8080 | hivemq3-1 |
28133 | 8000 | hivemq3-1 |
28134 | 8080 | hivemq4-1 |
28135 | 8000 | hivemq4-1 |
28136 | 80 | mqtt-ui |
28137 | 9000 | portainer |
28138 | 8080 | cadvisor |
28139 | 8080 | airflow (2.x) or airflow-apiserver (3.x) |
28140 | 8080 | code-server |
28141 | 8000 | kafka-topics-ui |
28142 | 8080 | datahub-gms |
28143 | 9001 | datahub-frontend-ember |
28144 | 9002 | datahub-frontend |
28145 | 9091 | datahub-mae-consumer |
28146 | 9092 | datahub-mce-consumer |
28150 | 8888 | druid-router |
28150 | 8888 | druid-sandbox |
28151 | 8088 | superset |
28152 | 8080 | superset |
28154 | 8080 | penthao |
28155 | 8080 | hawtio |
28156 | 8080 | swagger-editor |
28157 | 8080 | swagger-ui |
28158 | 8081 | streamsheets |
28159 | 8081 | quix-backend |
28160 | 8081 | quix-frontend |
28161 | 5000 | redash-server |
28170 | 80 | stardog-studio |
28171 | 3030 | smashing |
28172 | 3030 | tipboard |
28173 | 3030 | chartboard |
28174 | 8001 | redis-insight |
28175 | 8088 | cedalo-management-center |
28176 | 8080 | s3manager |
28177 | 8080 | hasura |
28178 | 8080 | file-browser |
28179 | 8080 | kafka-ui |
28180 | 8080 | dgraph-1 |
28181 | 9080 | dgraph-1 |
28182 | 8000 | dgraph-1 |
28190 | 80 | adminio_ui |
28191 | 8080 | adminio_api |
28192 | 8334 | filestash |
28193 | 5000 | mcp-toolbox-for-dbs |
28194 | 3000 | sqlpad |
28195 | 80 | streams-explorer |
28200 | 9090 | thingsbaord (http) |
28201 | 1883 | thingsbaord (mqtt) |
28202 | 5683 | thingsbaord (coap) |
28203 | 8080 | microcks |
28204 | 8080 | keycloak |
28205 | 8443 | keycloak (https) |
28206 | 3000 | postgrest |
28207 | 8080 | operate |
28208 | 9000 | zeeqs |
28209 | 8080 | hazelcast-mc |
28210 | 9000 | pinot-controller |
28211 | 8099 | pinot-broker-1 |
28212 | 8098 | pinot-server-1 |
28213 | 8098 | pinot-server-2 |
28214 | 8098 | pinot-server-3 |
28220 | 8000 | lakefs |
28221 | 5000 | lakefs-webhook |
28222 | 9000 | whisper |
28223 | 80 | audio-transcriber |
28224 | 8082 | centralmind-gateway  |
28225 | |  |
28226 | 9000 | questdb |
28227 | 8080 | debezium-ui |
28228 | 9998 | tikka-server |
28229 | 5000 | mlflow-tracking-server |
28230 | 8080 | mlflow-artifacts-server |
28231 | 8080 | optuna-dashboard |
28232 | 8080 | reaper (app UI) |
28233 | 8081 | reaper (admin UI) |
28234 | 8080 | kie-server (drools) |
28235 | 8001 | business-central (drools) |
28236 | 8080 | business-central (drools) |
28237 | 8081 | flink-jobmanager |
28238 | 8083 | flink-sqlgateway |
28239 | 8080 | kowl |
28240 | 8080 | ignite-1 |
28241 | 8080 | ignite-2 |
28242 | 8080 | ignite-3 |
28243 | 8080 | ignite-4 |
28244 | 8080 | ignite-5 |
28245 | 8008 | gridgain-cc-frontend |
28246 | 8080 | debezium-server |
28247 | 80 | pgadmin |
28250 | 80 | gitweb |
28251 | 8888 | oracle-xe |
28252 | 8888 | oracle-rest-1 |
28253 | 8888 | kouncil |
28254 | 80 | kafka-magic |
28255 | 80 | streampipes-ui |
28256 | 80 | remora |
28257 | 80 | metabase |
28258 | 3000 | burrow-ui |
28259 | 80 | burrow-dashboard |
28260 | 8000 | burrow |
28261 | 8888 | otel-collector |
28262 | 8889 | otel-collector |
28263 | 8889 | bpm-platform |
28264 | 8090 | optimize |
28265 | 80 | tempo |
28267 | 16686 | tempo (jaeger ui) |
28268 | 8080 | quine-1 |
28269 | 8080 | conduit |
28270 | 8001 | airbyte-server |
28271 | 80 | airbyte-webapp |
28272 | 7233 | airbyte-temporal |
28273 | 1090 | mockserver |
28274 | 8080 | kafka-webviewer |
28275 | 8080 | elasticvue |
28276 | 8080 | nocodb |
28277 | 8080 | zilla |
28278 | 9090 | zilla |
28279 | 80 | azure-storage-explorer |
28280 | 8080 | tyk-gateway |
28281 | 3000 | tyk-dashboard |
28282 | 80 | kafka-connector-board |
28283 | 3000 | kpow |
28284 | 8000 | jupyterhub |
28285 | 80 | conduktor-platform |
28286 | 80 | kong-admin-ui |
28287 | 8181 | iceberg-rest |
28288 | 3000 | memgraph-platform |
28289 | 8080 | redpanda-console |
28290 | 80 | excalidraw |
28291 | 8200 | invana-engine |
28292 | 8300 | invana-studio |
28293 | 8080 | spring-boot-admin |
28294 | 5000 | ckan |
28295 | 8800 | ckan-datapusher |
28296 | 443 | phpldapadmin |
28297 | 80 | ldap-user-manager |
28298 | 4040 | spark-thriftserver (Spark UI) |
28299 | 80 | baserow |
28300 | 443 | baserow |
28301 | 10001 | querybook |
28302 | 8081 | nussknacker-designer |
28303 | 8080 | kafkistry |
28304 | 8080 | spark-master |
28305 | 3000 | sqlchat |
28306 | 8080 | minio-web |
28307 | 80 | docker-registry-ui |
28308 | 8000 | splunk |
28309 | 9097 | klaw-core |
28310 | 8080 | etcd-keeper |
28311 | 3000 | raneto |
28312 | 3000 | markdown-madness |
28313 | 80 | kadeck |
28314 | 8080 | watchtower |
28315 | 10000 | dataiku-dss |
28316 | 1080 | maildev |
28317 | 25 | maildev |
28318 | 8025 | mailpit |
28319 | 25 | mailpit |
28320 | 25 | akhq (dc1) |
28321 | 25 | akhq (dc1) |
28322 | 80 | asyncapi-studio |
28323 | 80 | taiga-front |
28324 | 80 | taiga-gateway |
28325 | 8025 | mailhog |
28326 | 25 | mailhog |
28327 | 3000 | ioevent-cockpit-ui |
28328 | 9093 | prometheus-alertmanager |
28329 | 9000 | cribl-master |
28330 | 9420 | cribl-edge |
28331 | 8080 | blaze-fhir |
28332 | 8181 | opa |
28333 | 8181 | styra-eopa |
28334 | 80 | tooljet |
28335 | 8080 | fhir-gateway |
28336 | 8080 | hapi-fhir |
28337 | 8080 | openmetadata-ingestion |
28338 | 8080 | open-webui |
28339 | 8000 | chroma |
28340 | 3000 | flowise |
28341 | 19530 | milvus (grpc) |
28342 | 9091 | milvus (metric) |
28343 | 3000 | attu |
28344 | 3001 | anything-llm |
28345 | 80 | streamlit-1 |
28346 | 80 | streamlit-2 |
28347 | 80 | streamlit-3 |
28348 | 80 | streamlit-4 |
28349 | 80 | streamlit-5 |
28350 | 3001 | vector-admin |
28351 | 8000 | single-store |
28352 | 9000 | single-store |
28353 | 8000 | gpt-researcher |
28354 | 8080 | weaviate |
28355 | 3000 | big-agi |
28356 | 8080 | local-ai |
28357 | 8008 | solace-pubsub (web transport) |
28358 | 8080 | solace-pubsub (http) |
28359 | 9000 | solace-pubsub (rest) |
28360 | 55555 | solace-pubsub (smf) |
28361 | 8080 | x4-server |
28362 | 8085 | x4-keycloak |
28363 | 9200 | datahub-opensearch |
28364 | 8080 | autogen-studio |
28365 | 3000 | alpaca-webui |
28366 | 3000 | langfuse |
28367 | 80 | mqttx-web |
28368 | 8080 | web-protege |
28369 | 3030 | lenses |
28370 | 80 | rancher |
28371 | 443 | rancher |
28372 | 5001 | nlm-ingestor |
28373 | 8000 | verba |
28374 | 8000 | unstructured-api |
28375 | 8888 | docker-exec-webconsole |
28376 | 4040 | jupyter (spark UI)  |
28377 | 4041 | jupyter (spark UI)  |
28378 | 4042 | jupyter (spark UI)  |
28379 | 4043 | jupyter (spark UI)  |
28380 | 4044 | jupyter (spark UI)  |
28381 | 8080 | data-mesh-manager  |
28382 | 8080 | data-contract-manager  |
28383 | 61208 | glances  |
28384 | 61209 | glances  |
28385 | 4040 | kyuubi (spark ui)  |
28386 | 4041 | kyuubi (spark ui)  |
28387 | 4042 | kyuubi (spark ui)  |
28388 | 8080 | jikkou-server  |
28389 | 8080 | searxng  |
28390 | 8080 | drawio | 
28391 | 8443 | drawio | 
28392 | 8080 | unity-catalog  |
28393 | 3000 | unity-catalog-ui  |
28394 | 8080 | dataverse  |
28395 | 80 | dataverse-previewer-provider  |
28396 | 80 | ragflow  |
28397 | 443 | ragflow |
28398 | 5678 | ragflow |
28399 | 9091 | authelia |
28400 | 8081 | emqx-1 |
28401 | 8083 | emqx-1 |
28402 | 8084 | emqx-1 |
28403 | 8883 | emqx-1 |
28404 | 18083 | emqx-1 |
28405 | 3001 | perplexica-backend |
28406 | 3001 | perplexica-frontend |
28407 | 7000 | opal-client |
28408 | 8181 | opal-client |
28409 | 8180 | cedar |
28410 | 8080 | oracledb-ee-1 |
28411 | 8080 | oracledb-ee-2 |
28412 | 8080 | oracledb-ee-3 |
28413 | 8000 | focalboard |
28414 | 8000 | neo4j-kg-builder-backend |
28415 | 8000 | neo4j-kg-builder-frontend |
28416 | 8080 | langwatch-nlp |
28417 | 8000 | langevals |
28418 | 80 | agent-zero |
28419 | 8080 | data-product-portal-nginx |
28420 | 8080 | sftpgo (webui) |
28421 | 8000 | timeplus (enterprise) |
28242 | 3000 | openlit |
28243 | 8123 | clickhouse |
28244 | 9000 | clickhouse |
28245 | 8080 | kestra |
28246 | 8081 | kestra |
28247 | 4040 | ngrok |
28248 | 3002 | firecrawl-api |
28249 | 8443 | duckdb-ui |
28250 | 4040 | nvidia-nim-1 |
28251 | 4040 | nvidia-nim-2 |
28252 | 4040 | nvidia-nim-3 |
28253 | 4040 | nvidia-nim-4 |
28254 | 4040 | nvidia-nim-5 |
28256 | 4040 | nvidia-nim-6 |
28257 | 7860 | nllb |
28258 | 8000 | supabase-kong |
28259 | 8443 | supabase-kong |
28260 | 8082 | supabase-studio |
28261 | 8123 | quackflight |
28262 | 8080 | jenkins |
28263 | 8181 | influxdb3 |
28264 | 8888 | influxdb3-explorer |
28265 | 8000 | graphiti |
28266 | 8000 | graphiti-mcp |
28267 | 8080 | trino-lb (http) |
28268 | 8443 | trino-lb (https) |
28269 | 9090 | trino-lb (prometheus) |
28270 | 8080 | trino-gateway |

## Ports > 28500

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
28500 - 28510 | 28500 - 28510 | streamsets-1 (additional ports) |
28510 - 28520 | 28510 - 28520 | nifi-1 (additional ports |
28520 - 28530 | 28520 - 28530 | nifi2-1 (additional ports |
28530 - 28600 | any | reserved for applications |

An overview of the URL for the various web-based UIs can be found [here](./environment/README.md).
