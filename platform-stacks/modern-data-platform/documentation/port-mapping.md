## Port to Service Mappings

This table reserves the external ports for the various services. Not all services have to be used in the platform at a given time. But by reserving, we can assure that there are no conflicts if a service is added at a later time.

### Internal Port

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
21 | 21 | ftp |
1433 | 1433 | sqlserver |
1521 | 1521 | oracle-db |
1880 | 1880 | nodered |
3306 | 3306 | mysql |
5500 | 5500 | oracle-db |
5432 | 5432 | postgresql |
- | 5432 | hue-db |
5433 | 5432 | timescaledb |
6379 | 6379 | redis |
6066 | 6066 | spark-master |
7077 | 7077 | spark-master |
7687 | 7687 | neo4j |
8088 | 8088 | resourcemanager |
8042 | 8042 | nodemanager |
2181 | 2181 | zookeeper-1 |
2182 | 2181 | zookeeper-2 |
2183 | 2181 | zookeeper-3 |
9090 | 9090 | prometheus-1 |
9092 | 9092 | broker-1     |
9093 | 9093 | broker-2     |
9094 | 9094 | broker-3     |
27017 | 27017 | mongodb |
9200 | 9200 | elasticsearch-1 |
9300 | 9300 | elasticsearch-1 |
9851 | 9851 | tile38 |
9999 | 9999 | influxdb2 |
21000 | 21000 | atlas |

### External Ports

Container Port(s) | Internal Port(s)           | Service (alternatives) |
--------------------|------------------|-----------------------|
28000 | 1358 | dejavu |
28001 | 1882 | kafka-mqtt-1 |
28002 | 1882 | kafka-mqtt-2 |
28003 | 5000 | amundsenfrontend
28004 | 5000 | amundsensearch
28005 | 5000 | amundsenmetadata
28006 | 5601 | kibana |
28007 | 5672 | activemq (amqp)    |
28008 | 5800 | filezilla (ftp browser based UI)  |
28009 | 5900 | filezilla (ftp browser based UI)  |
28010 | 8024 | axon-server |
28011 | 8047 | drill |
28012 | 8086 | kafka-rest-1 |
28013 | 8083 | connect-1 |
28014 | 8084 | connect-2 |
28015 | 8085 | connect-3 |
28016 | 8086 | rest-proxy-1 |
28017 | 8080 | presto |
28018 | 8124 | axon-server |
28019 | 8161 | activemq (ui)    |
28020 | 8188 | historyserver |
28021 | 8998 | livy |
28022 | 8888 | oracle-rest-1 |
28023 | 9001 | mosquitto-1 |
28024 | 8080 | mqtt-1 |
28025 | 9047 | dremio |
28026 | 9083 | hive-metastore |
28027 | 10000 | hive-server |
28028 | 10002 | hive-server |
28029 | 18630 | streamsets     |
28030 | 8081 | schema-registry-1     |
28031 | 8081 | schema-registry-2     |
28033 | 9000 | portainer |
28034 | 8088 | ksqldb-server-1 |
28035 | 8089 | ksqldb-server-2 |
28036 | 8089 | ksqldb-server-3 |
28038 | 8000 | kafka-connect-ui     |
28039 | 8000 | schema-registry-ui     |
28040 | 8080 | kadmin     |
28041 | 8080 | adminer     |
28042 | 8080 | kafkahq     |
28043 | 8888 | hue |
28044 | 9000 | kafka-manager     |
28045 | 9020 | kafdrop     |
28046 | 9021 | control-center |
28047 | 8010 | zoonavigator-web     |
28048 | 9010 | zoonavigator-api     |
28049 | 80 | mqtt-ui |
28050 | 31010 | dremio | 
28051 | 1234 | admin-mongo |
28052 | 5000 | elastichq |
28053 | 3000 | cassandra-web |
28054 | 8080 | nifi     |
28055 | 8080 | zeppelin, zeppelin-spark     |
28056 | 8081 | mongo-express |
28057 | 8081 | redis-commander |
28058 | 8080 | webspoon (penthao) | 
28059 | 8080 | hawtio |
28060 | 8888 | jupyter |
28061 | 9000 | cerebro |
28062 | 9042 | cassandra-atlas |
28063 | 9091 | dse-studio |
28064 | 9160 | cassandra-atlas |
28065 | 9200 | elasticsearch-atlas |
28066 | 45678 | dremio |
28067 | 8888 | opscenter |
28068 | 61613 | activemq (stomp)    |
28069 | 61614 | activemq (ws)    |
28070 | 61616 | activemq (jms)    |
28071 | 9000 | portainer |
28072 | 18080 | spark-history |
28073 | 10000 | spark-thrift-server |
28076 | 8080 | spark-master |
28077 | 8081 | spark-worker-1 |
28078 | 8081 | spark-worker-2 |
28079 | 8081 | spark-worker-3 |
28080 | 7474 | neo4j |
28081 | 8983 | solr |
28082 | 80 | mqtt-ui |
28083 | 9000 | minio |
28084 | 9870 | namenode |
28085 | 9864 | datanode-1 |
28086 | 9864 | datanode-2 |
28087 | 9864 | datanode-3 |
28090 | 9042 | cassandra-1 |
28091 | 7199 | cassandra-1 |
28092 | 9160 | cassandra-1 |
28093 | 9042 | cassandra-2 |
28094 | 7199 | cassandra-2 |
28095 | 9160 | cassandra-2 |
28096 | 9042 | cassandra-3 |
28097 | 7199 | cassandra-3 |
28098 | 9160 | cassandra-3 |
28099 | 3000 | grafana |
28100 | 1883 | mosquitto-1 |
28101 | 1883 | mqtt-1 |
28102 | 3000 | burrow-ui |
28103 | 80 | burrow-dashboard |
28104 | 8000 | burrow |
28150 | 8086 | influxdb |
28150 | 8086 | influxdb |
28151 | 80 | influxdb-ui |
28152 | 8888 | chronograf |
28153 | 9092 | kapacitor |
28160 | 8080 | cadvisor |
28170 | 9091 | datastax-studio |

An overview of the URL for the various web-based UIs can be found [here](./environment/README.md).