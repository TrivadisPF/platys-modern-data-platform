# Provision of MDP Platform 

The Analytics Stack can be provisioned to various environments. Find the options and description here:

  * [AWS Lightsail](./Lightsail.md) - AWS Lightsail is a service in Amazon Web Services (AWS) with which we can easily startup an environment and provide all the necessary bootstrapping as a script. Monthly price of USD 80.- (16GB RAM) or USD 160.- (32 GB RAM).
  * [Azure VM (t.b.d.)]() - Run it inside an Azure VM
  * [Local Docker](./LocalDocker.md) - you have a local Docker and Docker Compose setup in place, either on Windows, on Mac or Linux, which you want to use
  * [Local Virtual Machine with Docker](./LocalVirtualMachine) - a Virtual Machine with Docker and Docker Compose pre-installed will be distributed at by the course infrastructure. You will need 50 GB free disk space.


## Post Provisioning

These steps are necessary after the starting the docker environment. 

### Add entry to local `/etc/hosts` File

To simplify working with the Streaming Platform and for the links below to work, add the following entry to your local `/etc/hosts` file. 

```
40.91.195.92	analyticsplatform
```

Replace the IP address by the public IP address of the Docker host. 

### Browser Bookmarks für Chrome

In the folder `browser-bookmarks` you can find a file which can be imported into Google Chrome to get bookmarks for all the Web-based GUIs which are part of the stack. In order for them to work you have to add the alias `analyticsplatform` to the `/etc/hosts` file (as shown before)

## Services accessible on Analytics Platform
The following service are available as part of the Analytics platform. 

Type | Service | Url
------|------- | -------------
Development | StreamSets Data Collector | <http://analyticsplatform:28029>
Development | Apache NiFi | <http://analyticsplatform:28054/nifi>
Development | Zeppelin  | <http://analyticsplatform:28055>
Development | Jupyter  | <http://analyticsplatform:28060>
Development | Datastax Studio  | <http://analyticsplatform:28063>
Development | Dejavu (Elasticsearch) | <http://analyticsplatform:28000>
Development | Kibana | <http://analyticsplatform:28006>
Development | Redis Commander | <http://analyticsplaform:28057>
Development | Neo4j | <http://analyticsplatform:28080>
Development | Cassandra Web |  <http://analyticsplatform:28053>
Runtime | Rest Proxy API  | <http://analyticsplatform:28022>
Runtime | Oracle REST Database Service | <http://analyticsplatform:28022/ords>
Runtime | Livy | <http://analyticsplatform:28021>
Governance | Schema Registry Rest API  | <http://analyticsplatform:28030>
Governance | Schema Registry UI  | <http://analyticsplatform:28039>
Governance | Atlas | <http://analyticsplatform:28034>
Management | Kafka Connect UI | <http://analyticsplatform:28038>
Management | Kafka Manager  | <http://analyticsplatform:28044>
Management | Kafdrop  | <http://analyticsplatform:28045>
Management | Kadmin  | <http://analyticsplatform:28040>
Management | KafkaHQ  | <http://analyticsplatform:28042>
Management | Zoonavigator  | <http://analyticsplatform:28047>
Management | Spark UI  | <http://analyticsplatform:28076>
Management | Hue  | <http://analyticsplatform:28043>
Management | ActiveMQ  | <http://analyticsplatform:28019>
Management | Adminer (RDBMS)  | <http://analyticsplatform:28041>
Management | Axon Server Dashboard | <http://anayticsplatform:28018>
Management | Admin Mongo | <http://analyticsplatform:28051>
Management | Mongo Express | <http://analyticsplatform:28056>
Management | ElasticHQ | <http://analyticsplatform:28052>
Management | Solr UI | <http://analyticsplatform:28081>
Management | Minio UI | <http://analyticsplaform:28083>
Management | MQTT UI | <http://analyticsplatform:28082>
Management | Hive Web UI | <http://analyticsplatform:28028>
Management | Namenode UI | <http://analyticsplatform:28084>
Management | Resourcemanager UI | <http://analyticsplatform:8088>
Management | Nodemanager UI | <http://analyticsplatform:8042>
Management | Presto UI | <http://analyticsplatform:28017>
Management | Dremio UI | <http://analyticsplatform:28025>
Management | Portainer | <http://analyticsplatform:28071>
Management | Filezilla | <http://analyticsplatform:28008>

Please make sure that you add an entry to your `/etc/hosts` file with the alias `analyticsplatform` and pointing to the IP address of the docker host.

## Troubleshooting

Want to see the configurations for Hive

`docker-compose logs -f hive-server`

```
hive-server                  | Configuring core
hive-server                  |  - Setting hadoop.proxyuser.hue.hosts=*
hive-server                  |  - Setting fs.defaultFS=hdfs://namenode:8020
hive-server                  |  - Setting hadoop.proxyuser.hue.groups=*
hive-server                  |  - Setting hadoop.http.staticuser.user=root
hive-server                  | Configuring hdfs
hive-server                  |  - Setting dfs.permissions.enabled=false
hive-server                  |  - Setting dfs.webhdfs.enabled=true
hive-server                  | Configuring yarn
hive-server                  |  - Setting yarn.resourcemanager.fs.state-store.uri=/rmstate
hive-server                  |  - Setting yarn.timeline-service.generic-application-history.enabled=true
hive-server                  |  - Setting yarn.resourcemanager.recovery.enabled=true
hive-server                  |  - Setting yarn.timeline-service.enabled=true
hive-server                  |  - Setting yarn.log-aggregation-enable=true
hive-server                  |  - Setting yarn.resourcemanager.store.class=org.apache.hadoop.yarn.server.resourcemanager.recovery.FileSystemRMStateStore
hive-server                  |  - Setting yarn.resourcemanager.system-metrics-publisher.enabled=true
hive-server                  |  - Setting yarn.nodemanager.remote-app-log-dir=/app-logs
hive-server                  |  - Setting yarn.resourcemanager.resource.tracker.address=resourcemanager:8031
hive-server                  |  - Setting yarn.resourcemanager.hostname=resourcemanager
hive-server                  |  - Setting yarn.timeline-service.hostname=historyserver
hive-server                  |  - Setting yarn.log.server.url=http://historyserver:8188/applicationhistory/logs/
hive-server                  |  - Setting yarn.resourcemanager.scheduler.address=resourcemanager:8030
hive-server                  |  - Setting yarn.resourcemanager.address=resourcemanager:8032
hive-server                  | Configuring httpfs
hive-server                  | Configuring kms
hive-server                  | Configuring mapred
hive-server                  | Configuring hive
hive-server                  |  - Setting hive.metastore.uris=thrift://hive-metastore:9083
hive-server                  |  - Setting datanucleus.autoCreateSchema=false
hive-server                  |  - Setting javax.jdo.option.ConnectionURL=jdbc:postgresql://hive-metastore-postgresql/metastore
hive-server                  |  - Setting javax.jdo.option.ConnectionDriverName=org.postgresql.Driver
hive-server                  |  - Setting javax.jdo.option.ConnectionPassword=hive
hive-server                  |  - Setting javax.jdo.option.ConnectionUserName=hive
hive-server                  | Configuring for multihomed network
hive-server                  | [1/100] check for hive-metastore:9083...
hive-server                  | [1/100] hive-metastore:9083 is not available yet
hive-server                  | [1/100] try in 5s once again ...
hive-server                  | [2/100] check for hive-metastore:9083...
hive-server                  | [2/100] hive-metastore:9083 is not available yet
hive-server                  | [2/100] try in 5s once again ...
hive-server                  | [3/100] hive-metastore:9083 is available.
hive-server                  | mkdir: `/tmp': File exists
hive-server                  | 2019-05-10 15:45:28: Starting HiveServer2
hive-server                  | SLF4J: Class path contains multiple SLF4J bindings.
```
