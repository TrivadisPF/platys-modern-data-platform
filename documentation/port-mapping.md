# `modern-data-platform` - Port Mappings - 1.15.0

This table reserves the external ports for the various services. Not all services have to be used in the platform at a given time. But by reserving, we can assure that there are no conflicts if a service is added at a later time.

## "Original" Ports

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
21 | 21 | ftp |
80 | 80 | markdown-viewer or firefox |
1433 | 1433 | sqlserver |
1521 | 1521 | oracledb-ee |
1522 | 1521 | oracledb-xe |
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
2113 | 2113 | eventstore |
2181 | 2181 | zookeeper-1 |
2182 | 2182 | zookeeper-2 |
2183 | 2183 | zookeeper-3 |
2184 | 2184 | zookeeper-4 |
2185 | 2185 | zookeeper-5 |
2186 | 2186 | zookeeper-6 |
3000 | 3000 | grafana |
3001 | 3000 | wetty (dc1) |
3002 | 3000 | wetty (dc2 |
3005 | 3000 | marquez-web |
3010 | 3000 | postman |
3006 | 3000 | retool-api |
3030 | 3030 | lenses |
3100 | 3100 | loki |
3200 | 3200 | tempo |
3306 | 3306 | mysql |
3307 | 3306 | datahub-mysql |
3838 | 3838 | shiny-server |
4000 | 4000 | graphql-mesh |
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
4317 | 4317 | otel-collector |
5000 | 5000 | amundsenfrontend |
5001 | 5000 | amundsensearch |
5002 | 5000 | amundsenmetadata |
5010 | 5000 | marquez |
5011 | 5001 | marquez |
5050 | 5050 | zeppelin |
5500 | 5500 | oracledb-ee |
5501 | 5500 | oracledb-xe |
\-     | 5432 | hive-metastore-db |
\-     | 5432 | hue-db |
5432 | 5432 | postgresql |
5433 | 5432 | timescaledb |
5434 | 5432 | marquez-db |
5601 | 5601 | kibana |
5602 | 5601 | datahub-kibana |
5603 | 5601 | opensearch-dashboards |
5672 | 5672 | activemq |
5673 | 5672 | rabbitmq (amqp) |
5701 | 5701 | hazelcast	-1 |
5705 | 5701 | zeebe-1 |
5778 | 5778 | jaeger (config) |
5800 | 5800 | filezilla |
5801 | 5800 | firefox |
5820 | 5820 | stardog-1 |
5900 | 5900 | filezilla |  
6060 | 6060 | zeppelin |
6066 | 6066 | spark-master |
6080 | 6080 | ranger-admin |
6379 | 6379 | redis-1 |
6380 | 6379 | redis-replica-1 |
6381 | 6379 | redis-replica-1 |
6382 | 6379 | redis-replica-1 |
6385 | 6379 | redash-redis |
6386 | 6379 | tyk-redis |
6831 | 6831 | jaeger (udp) |
6749 | 6749 | curity |
6832 | 6832 | jaeger (udp) |
6875 | 6875 | materialize-1 |
7000 | 7000 | yb-master |
7050 | 7050 | kudu-tserver-1 |
7051 | 7051 | kudo-master-1 |
7077 | 7077 | spark-master |
7199 | 7199 | cassandra-1 |
7200 | 7199 | cassandra-2 |
7201 | 7199 | cassandra-3 |
7202 | 7199 | cassandra-4 |
7203 | 7199 | cassandra-5 |
7474 | 7474 | neo4j-1 |
7475 | 7474 | neo4j-2 |
7476 | 7474 | neo4j-3 |
7577 | 7577 | spring-skipper-server |
7687 | 7687 | neo4j-1 |
7688 | 7687 | neo4j-2 |
7689 | 7687 | neo4j-3 |
8000 | 8000 | kong (proxy) |
8001 | 8001 | kong (admin api) |
8002 | 8002 | kong (admin gui) |
8008 | 80 | markdown-viewer |
8024 | 8024 | axon-server |
8047 | 8047 | drill |
8048 | 8048 | kafka-eagle |
8050 | 8050 | kudu-tserver-1 |
8051 | 8051 | kudo-master-1 |
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
8124 | 8124 | axon-server |
8161 | 8161 | activemq |
8200 | 8200 | vault |
8443 | 8443 | kong (proxy ssl) |
8444 | 8444 | kong (admin api ssl) |
8446 | 8443 | curity |
8787 | 8787 | r-studio |
8812 | 8812 | questdb |
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
9101 | 9001 | mosquitto-1 |
9102 | 9002 | mosquitto-2 |
9103 | 9003 | mosquitto-3 |
9200 | 9200 | elasticsearch-1 |
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
9393 | 9393 | spring-dataflow-server |
9411 | 9411 | zipkin |
9412 | 9412 | jaeger |
9413 | 9413 | pitchfork |
9600 | 9600 | zeebe-1 |
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
11211 | 11211 | memcached |
11212 | 11211 | ignite-1 |
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
17474 | 7474 | amundsen-neo4j |
17687 | 7687 | amundsen-neo4j |
17475 | 7474 | datahub-neo4j |
17688 | 7687 | datahub-neo4j |
18080 | 8080 | nifi-1 |
18081 | 8080 | nifi-2 |
18082 | 8080 | nifi-3 |
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
19092 | 19092 | kafka-1 (docker-host)   |
19093 | 19093 | kafka-2 (docker-host    |
19094 | 19094 | kafka-3 (docker-host)   |
19095 | 19095 | kafka-4 (docker-host)   |
19096 | 19096 | kafka-5 (docker-host)   |
19097 | 19097 | kafka-6 (docker-host)   |
19098 | 19098 | kafka-7 (docker-host)   |
19099 | 19099 | kafka-8 (docker-host)   |
19630 | 19630 | streamsets-transformer-1 |
19631 | 19630 | streamsets-transformer-1 |
19632 | 19630 | streamsets-transformer-1 |
19999 | 9999 | influxdb2 |
21000 | 21000 | atlas |
26500 | 26500 | zeebe-1 |
27017 | 27017 | mongodb-1 |
27018 | 27017 | mongodb-2 |
27019 | 27017 | mongodb-3 |
27020 | 27017 | mongodb-3 |
28080 | 8080 | zeppelin |
28081 | 8080 | presto-1 |
28082 | 8080 | trino-1 |
28085 | 8080 | azkarra-worker-1 |
28888 | 8888 | jupyter |
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
39092 | 29092 | kafka-1 (localhost)   |
39093 | 29093 | kafka-2 (localhost    |
39094 | 29094 | kafka-3 (localhost)   |
39095 | 29095 | kafka-4 (localhost)   |
39096 | 29096 | kafka-5 (localhost)   |
39097 | 29097 | kafka-6 (localhost)   |
39098 | 29098 | kafka-7 (localhost)   |
39099 | 29099 | kafka-8 (localhost)   |
78 | 45678 | dremio |
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
28107 | 8080 | akhq (dc2)     |
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
28120 | 3000 | cassandra-web |
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
28139 | 8080 | airflow |
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
28178 | 80 | filebrowser |
28179 | 8080 | kafka-ui |
28180 | 8080 | dgraph-1 |
28181 | 9080 | dgraph-1 |
28182 | 8000 | dgraph-1 |
28190 | 80 | adminio_ui |
28191 | 8080 | adminio_api |
28192 | 8334 | filestash |
28193 | 9090 | minio-console |
28194 | 3000 | sqlpad |
28195 | 80 | streams-explorer |
28200 | 9090 | thingsbaord (http) |
28201 | 1883 | thingsbaord (mqtt) |
28202 | 5683 | thingsbaord (coap) |
28203 | 8080 | microcks |
28204 | 8080 | keycloak |
28205 | 10000 | dataiku-dss |
28206 | 3000 | postgrest |
28207 | 8080 | operate |
28208 | 9000 | zeeqs |
28209 | 8080 | hazelcast-mc |
28210 | 9000 | pinot-controller |
28211 | 8099 | pinot-broker-1 |
28212 | 8098 | pinot-server-1 |
28220 | 8000 | lakefs |
28221 | 8081 | emqx-1 |
28222 | 8083 | emqx-1 |
28223 | 8084 | emqx-1 |
28224 | 8883 | emqx-1 |
28225 | 18083 | emqx-1 |
28226 | 9000 | questdb |
28227 | 8080 | debezium-ui |
28228 | 9998 | tikka-server |
28229 | 5000 | mlflow-server |
28230 | 8080 | optuna-dashboard |
28231 | 80 | excalidraw |
28232 | 8080 | reaper (app UI) |
28233 | 8081 | reaper (admin UI) |
28234 | 8080 | kie-server (drools) |
28235 | 8001 | business-central (drools) |
28236 | 8080 | business-central (drools) |
28237 | 8081 | flink-jobmanager |
28238 | 8081 | nussknacker-designer |
28239 | 8080 | kowl |
28240 | 8080 | ignite-1 |
28241 | 8080 | ignite-2 |
28242 | 8080 | ignite-3 |
28243 | 8080 | ignite-4 |
28244 | 8080 | ignite-5 |
28245 | 8008 | gridgain-cc-frontend |
28246 | 8080 | debezium-server |
28247 | 80 | pgadmin |
28250 | 8888 | oracle-ee |
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

## Ports > 28500

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
28500 - 28510 | 28500 - 28510 | streamsets-1 (additional ports) |
28520 - 28600 | any | reserved for applications |

An overview of the URL for the various web-based UIs can be found [here](./environment/README.md).
