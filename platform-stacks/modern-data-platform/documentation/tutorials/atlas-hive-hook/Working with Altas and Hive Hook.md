# Working with Altas and Hive Hook

This tutorial will show the Hive Hook and Atlas in Action.

## Initialise a platform with Atlas and Hive

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled in the `config.yml`

```
      KAFKA_enable: true
      HADOOP_enable: true
      HIVE_enable: true
      ATLAS_enable: true
      HUE_enable: true
```

Additionally make sure that the Atlas Hive hook is installed into the hive server:

```
      ATLAS_install_hive_hook: true
```

Now generate and start the data platform. 

## Listen on the ATLAS_HOOK

Before we create a table in Hive, let's listen on the Kafka topic `ATLAS_HOOK` to see the event raised by the Hive hook. 

In a terminal window, either use the `kafka-console-consumer` inside the running docker container

```
docker exec -ti kafka-1 kafka-console-consumer --topic ATLAS_HOOK --bootstrap-server kafka-1:9092
```

or using a local installation of `kafkacat`

```
kafkacat -b dataplatform -t ATLAS_HOOK
```

## Create a table in Hive

On the docker host, start the Hive CLI 

```
docker exec -ti hive-server hive
```

and create a new database `atlas_test` and in that database a table `person`:

```
create database atlas_test;
use atlas_test;

create table person (id integer, first_name string, last_name string);
```

## Check data in ATLAS_HOOK

Check that an event has been raised on the `ATLAS_HOOK` Kafka topic for both the database and the table.

The event for the database looks like that 

```
{
   "version":{
      "version":"1.0.0",
      "versionParts":[
         1
      ]
   },
   "msgCompressionKind":"NONE",
   "msgSplitIdx":1,
   "msgSplitCount":1,
   "msgSourceIP":"172.22.0.3",
   "msgCreatedBy":"root",
   "msgCreationTime":1581758536220,
   "message":{
      "type":"ENTITY_CREATE_V2",
      "user":"root",
      "entities":{
         "referredEntities":{

         },
         "entities":[
            {
               "typeName":"hive_db",
               "attributes":{
                  "owner":"root",
                  "ownerType":"USER",
                  "qualifiedName":"atlas_test@primary",
                  "clusterName":"primary",
                  "name":"atlas_test",
                  "location":"hdfs://namenode:9000/user/hive/warehouse/atlas_test.db",
                  "parameters":{

                  }
               },
               "guid":"-16210780182593",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "proxy":false
            },
            {
               "typeName":"hive_db_ddl",
               "attributes":{
                  "serviceType":"hive",
                  "qualifiedName":"atlas_test@primary:1581758534989",
                  "execTime":1581758534989,
                  "queryText":"create database atlas_test",
                  "name":"create database atlas_test",
                  "userName":"root"
               },
               "guid":"-16210780182594",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "db":{
                     "guid":"-16210780182593",
                     "typeName":"hive_db",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test@primary"
                     },
                     "relationshipType":"hive_db_ddl_queries"
                  }
               },
               "proxy":false
            }
         ]
      }
   }
}
```

and here is the event for the table:


```
{
   "version":{
      "version":"1.0.0",
      "versionParts":[
         1
      ]
   },
   "msgCompressionKind":"NONE",
   "msgSplitIdx":1,
   "msgSplitCount":1,
   "msgSourceIP":"172.22.0.3",
   "msgCreatedBy":"root",
   "msgCreationTime":1581758588041,
   "message":{
      "type":"ENTITY_CREATE_V2",
      "user":"root",
      "entities":{
         "referredEntities":{
            "-16210780182595":{
               "typeName":"hive_db",
               "attributes":{
                  "owner":"root",
                  "ownerType":"USER",
                  "qualifiedName":"atlas_test@primary",
                  "clusterName":"primary",
                  "name":"atlas_test",
                  "location":"hdfs://namenode:9000/user/hive/warehouse/atlas_test.db",
                  "parameters":{

                  }
               },
               "guid":"-16210780182595",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "proxy":false
            },
            "-16210780182598":{
               "typeName":"hive_column",
               "attributes":{
                  "owner":"root",
                  "qualifiedName":"atlas_test.person.id@primary",
                  "name":"id",
                  "comment":null,
                  "position":0,
                  "type":"int"
               },
               "guid":"-16210780182598",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "table":{
                     "guid":"-16210780182596",
                     "typeName":"hive_table",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary"
                     },
                     "relationshipType":"hive_table_columns"
                  }
               },
               "proxy":false
            },
            "-16210780182597":{
               "typeName":"hive_storagedesc",
               "attributes":{
                  "qualifiedName":"atlas_test.person@primary_storage",
                  "storedAsSubDirectories":false,
                  "location":"hdfs://namenode:9000/user/hive/warehouse/atlas_test.db/person",
                  "compressed":false,
                  "inputFormat":"org.apache.hadoop.mapred.TextInputFormat",
                  "parameters":{

                  },
                  "outputFormat":"org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
                  "serdeInfo":{
                     "typeName":"hive_serde",
                     "attributes":{
                        "serializationLib":"org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe",
                        "name":null,
                        "parameters":{
                           "serialization.format":"1"
                        }
                     }
                  },
                  "numBuckets":-1
               },
               "guid":"-16210780182597",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "table":{
                     "guid":"-16210780182596",
                     "typeName":"hive_table",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary"
                     },
                     "relationshipType":"hive_table_storagedesc"
                  }
               },
               "proxy":false
            },
            "-16210780182600":{
               "typeName":"hive_column",
               "attributes":{
                  "owner":"root",
                  "qualifiedName":"atlas_test.person.last_name@primary",
                  "name":"last_name",
                  "comment":null,
                  "position":2,
                  "type":"string"
               },
               "guid":"-16210780182600",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "table":{
                     "guid":"-16210780182596",
                     "typeName":"hive_table",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary"
                     },
                     "relationshipType":"hive_table_columns"
                  }
               },
               "proxy":false
            },
            "-16210780182599":{
               "typeName":"hive_column",
               "attributes":{
                  "owner":"root",
                  "qualifiedName":"atlas_test.person.first_name@primary",
                  "name":"first_name",
                  "comment":null,
                  "position":1,
                  "type":"string"
               },
               "guid":"-16210780182599",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "table":{
                     "guid":"-16210780182596",
                     "typeName":"hive_table",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary"
                     },
                     "relationshipType":"hive_table_columns"
                  }
               },
               "proxy":false
            }
         },
         "entities":[
            {
               "typeName":"hive_table",
               "attributes":{
                  "owner":"root",
                  "tableType":"MANAGED_TABLE",
                  "temporary":false,
                  "lastAccessTime":1581758587000,
                  "createTime":1581758587000,
                  "qualifiedName":"atlas_test.person@primary",
                  "name":"person",
                  "comment":null,
                  "parameters":{
                     "totalSize":"0",
                     "rawDataSize":"0",
                     "numRows":"0",
                     "COLUMN_STATS_ACCURATE":"{\"BASIC_STATS\":\"true\",\"COLUMN_STATS\":{\"first_name\":\"true\",\"id\":\"true\",\"last_name\":\"true\"}}",
                     "numFiles":"0",
                     "transient_lastDdlTime":"1581758587",
                     "bucketing_version":"2"
                  },
                  "retention":0
               },
               "guid":"-16210780182596",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "sd":{
                     "guid":"-16210780182597",
                     "typeName":"hive_storagedesc",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary_storage"
                     },
                     "relationshipType":"hive_table_storagedesc"
                  },
                  "columns":[
                     {
                        "guid":"-16210780182598",
                        "typeName":"hive_column",
                        "uniqueAttributes":{
                           "qualifiedName":"atlas_test.person.id@primary"
                        },
                        "relationshipType":"hive_table_columns"
                     },
                     {
                        "guid":"-16210780182599",
                        "typeName":"hive_column",
                        "uniqueAttributes":{
                           "qualifiedName":"atlas_test.person.first_name@primary"
                        },
                        "relationshipType":"hive_table_columns"
                     },
                     {
                        "guid":"-16210780182600",
                        "typeName":"hive_column",
                        "uniqueAttributes":{
                           "qualifiedName":"atlas_test.person.last_name@primary"
                        },
                        "relationshipType":"hive_table_columns"
                     }
                  ],
                  "partitionKeys":[

                  ],
                  "db":{
                     "guid":"-16210780182595",
                     "typeName":"hive_db",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test@primary"
                     },
                     "relationshipType":"hive_table_db"
                  }
               },
               "proxy":false
            },
            {
               "typeName":"hive_table_ddl",
               "attributes":{
                  "serviceType":"hive",
                  "qualifiedName":"atlas_test.person@primary:1581758587381",
                  "execTime":1581758587381,
                  "queryText":"create table person (id integer, first_name string, last_name string)\n\n",
                  "name":"create table person (id integer, first_name string, last_name string)\n\n",
                  "userName":"root"
               },
               "guid":"-16210780182601",
               "isIncomplete":false,
               "provenanceType":0,
               "version":0,
               "relationshipAttributes":{
                  "table":{
                     "guid":"-16210780182596",
                     "typeName":"hive_table",
                     "uniqueAttributes":{
                        "qualifiedName":"atlas_test.person@primary"
                     },
                     "relationshipType":"hive_table_ddl_queries"
                  }
               },
               "proxy":false
            }
         ]
      }
   }
}
```

## Check the entity in Apache Atlas

In a browser, navigate to <http://dataplatform:21000> and search for hive-table

![Hive Table Search](./images/atlas-search-hive-table.png)

and then click on the search result to get the detail information on the table

![Hive Table Details](./images/atlas-hive-table-details.png)
