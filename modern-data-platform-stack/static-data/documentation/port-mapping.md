# `modern-data-platform` - Port Mappings - 1.12.1

This table reserves the external ports for the various services. Not all services have to be used in the platform at a given time. But by reserving, we can assure that there are no conflicts if a service is added at a later time.

## "Original" Ports

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
21 | 21 | ftp |
80 | 80 | markdown-viewer or firefox |
1433 | 1433 | sqlserver |
1521 | 1521 | oracledb |
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
2182 | 2181 | zookeeper-2 |
2183 | 2181 | zookeeper-3 |
3000 | 3000 | grafana |
3001 | 3000 | wetty |
3005 | 3000 | marquez-web |
3010 | 3000 | postman |
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
5000 | 5000 | amundsenfrontend |
5001 | 5000 | amundsensearch |
5002 | 5000 | amundsenmetadata |
5010 | 5000 | marquez |
5011 | 5001 | marquez |
5050 | 5050 | zeppelin |
5500 | 5500 | oracledb |
\-     | 5432 | hive-metastore-db |
\-     | 5432 | hue-db |
5432 | 5432 | postgresql |
5433 | 5432 | timescaledb |
5434 | 5432 | marquez-db |
5601 | 5601 | kibana |
5602 | 5601 | datahub-kibana |
5672 | 5672 | activemq |
5673 | 5672 | rabbitmq (amqp) |
5701 | 5701 | hazelcast	-1 | 
5705 | 5701 | zeebe-1 | 
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
6875 | 6875 | materialize-1 |
7000 | 7000 | yb-master |
7050 | 7050 | kudu-tserver-1 |
7051 | 7051 | kudo-master-1 |
7077 | 7077 | spark-master |
7199 | 7199 | cassandra-1 |
7200 | 7199 | cassandra-2 |
7201 | 7199 | cassandra-3 |
7474 | 7474 | neo4j-1 |
7475 | 7474 | neo4j-2 |
7476 | 7474 | neo4j-3 |
7577 | 7577 | spring-skipper-server |
7687 | 7687 | neo4j-1 |
7688 | 7687 | neo4j-2 |
7689 | 7687 | neo4j-3 |
8000 | 80 | markdown-viewer |
8024 | 8024 | axon-server |
8047 | 8047 | drill |
8048 | 8048 | kafka-eagle |
8050 | 8050 | kudu-tserver-1 |
8051 | 8051 | kudo-master-1 |
8070 | 8070 | nuclio |
8080 | 8080 | spark-master |
8081 | 8081 | schema-registry-1     |
8082 | 8081 | schema-registry-2     |
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
8787 | 8787 | r-studio |
8812 | 8812 | questdb |
8888 | 8888 | hue |
8978 | 8978 | cloudbeaver |
8983 | 8983 | solr |
8998 | 8998 | livy |
9000 | 9000 | minio |
9001 | 9001 | mosquitto-1 |
9002 | 9002 | mosquitto-2 |
9003 | 9003 | mosquitto-3 |
9009 | 9009 | questdb |
9042 | 9042 | dse-1 |
9043 | 9042 | dse-2 |
9044 | 9042 | dse-3 |
9047 | 9047 | dremio |
9200 | 9200 | elasticsearch-1 |
9300 | 9300 | elasticsearch-1 |
9160 | 9160 | cassandra-1 |
9161 | 9160 | cassandra-2 |
9162 | 9160 | cassandra-3 |
9083 | 9083 | hive-metastore |
9021 | 9021 | control-center | 
9090 | 9090 | prometheus-1 |
9091 | 9091 | prometheus-pushgateway |
9092 | 9092 | kafka-1     |
9093 | 9093 | kafka-2     |
9094 | 9094 | kafka-3     |
9095 | 9095 | kafka-4     |
9096 | 9096 | kafka-5     |
9097 | 9097 | kafka-6     |
9393 | 9393 | spring-dataflow-server |
9411 | 9411 | zipkin |
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
9999 | 9999 | influxdb2 |
10000 | 10000 | hive-server |
10001 | 10001 | hive-server |
10002 | 10002 | hive-server |
10005 | 10000 | nifi |
11211 | 11211 | memcached |
15433 | 5433| yb-tserver-1 |
15672 | 15672 | rabbitmq (ui) |
16379 | 6379| yb-tserver-1 |
17200 | 7200 | graphdb-1 |
17474 | 7474 | amundsen-neo4j |
17687 | 7687 | amundsen-neo4j |
17475 | 7474 | datahub-neo4j |
17688 | 7687 | datahub-neo4j |
18080 | 18080 | nifi-1 |
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
19630 | 19630 | streamsets-transformer-1 | 
19631 | 19630 | streamsets-transformer-1 | 
19632 | 19630 | streamsets-transformer-1 | 
21000 | 21000 | atlas |
26500 | 26500 | zeebe-1 |
27017 | 27017 | mongodb-1 |
27018 | 27017 | mongodb-2 |
27019 | 27017 | mongodb-3 |
28080 | 8080 | zeppelin |
28081 | 8080 | presto-1 |
28082 | 8080 | trino-1 |
28085 | 8080 | azkarra-worker-1 |
28888 | 8888 | jupyter |
29000 | 9000 | apicurio-registry-1 |
29001 | 9000 | apicurio-registry-2 |
29002 | 9000 | apicurio-registry-3 |
29042 | 9042 | cassandra-1 |
29043 | 9042 | cassandra-1 |
29044 | 9042 | cassandra-1 |
29092 | 29092 | kafka-1 (docker-host)   |
29093 | 29093 | kafka-2 (docker-host    |
29094 | 29094 | kafka-3 (docker-host)   |
29095 | 29095 | kafka-4 (docker-host)   |
29096 | 29096 | kafka-5 (docker-host)   |
29097 | 29097 | kafka-6 (docker-host)   |
31010 | 31010 | dremio |
45678 | 45678 | dremio |
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
28104 | 9000 | cmak |
28105 | 9020 | kafdrop     |
28106 | 8080 | kadmin     |
28107 | 8080 | akhq     |
28108 | 3000 | burrow-ui |
28109 | 80 | burrow-dashboard |
28110 | 8000 | burrow |
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
28153 | 8888 | oracle-rest-1 |
28154 | 8080 | penthao |
28155 | 8080 | hawtio |
28156 | 8080 | swagger-editor |
28157 | 8080 | swagger-ui |
28158 | 8081 | streamsheets |
28159 | 8081 | quix-backend |
28160 | 8081 | quix-frontend |
28161 | 5000 | redash-server |
28162 | 8080 | apicurio-registry-1 |
28163 | 8080 | apicurio-registry-2 |
28164 | 8080 | apicurio-registry-3 |
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
28204 | 8080 | keyclock |
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

## Ports > 28500

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
28500 - 28510 | 28500 - 28510 | streamsets-1 (additional ports) |
28520 - 28600 | any | reserved for applications |

An overview of the URL for the various web-based UIs can be found [here](./environment/README.md).