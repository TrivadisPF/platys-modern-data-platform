---
technoglogies:      kafka,jikkou
version:				1.17.0
validated-at:			3.10.2023
---

# Automate management of Kafka topics on the platform

This recipe will show how automate the management of Kafka topics using the [Jikkou tool](https://streamthoughts.github.io/jikkou/), which is part of the platform.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,AKHQ,JIKKOU -s trivadis/platys-modern-data-platform -w 1.17.0
```

Now generate and start the platform

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker compose up -d
```

## Show Jikkou version

```bash
docker compose run -ti jikkou -V
```

```
Jikkou version "0.29.0" 2023-09-29
JVM: 17.0.8 (Oracle Corporation Substrate VM 17.0.8+9-LTS)
```

## Show Usage page

```bash
docker compose run -ti jikkou -h
```

```
Usage:
jikkou [-hV] [COMMAND]


Jikkou CLI:: A command-line client designed to provide an efficient and easy way to manage, automate, and provision resources for any kafka infrastructure.

Find more information at: https://streamthoughts.github.io/jikkou/.

Options:

  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.

Commands:

  create      Create resources from the resource definition files (only non-existing resources will be created).
  delete      Delete resources that are no longer described by the resource definition files.
  update      Create or update resources from the resource definition files
  apply       Update the resources as described by the resource definition files.
  resources   List supported resources
  extensions  List or describe the extensions of Jikkou
  config      Sets or retrieves the configuration of this client
  diff        Display all resource changes.
  validate    Validate resource definition files.
  health      Print or describe health indicators.
  help        Display help information about the specified command.
  get         List and describe all resources of a specific kind.
```  


## View Configuration

```bash
docker compose run -ti jikkou config view
```

```bash
{
    "extension" : {
        "paths" : []
    },
    "kafka" : {
        "brokers" : {
            "waitForEnabled" : "true",
            "waitForMinAvailable" : "3",
            "waitForRetryBackoffMs" : "10000",
            "waitForTimeoutMs" : "120000"
        },
        "client" : {
            "bootstrap" : {
                "servers" : "kafka-1:19092,kafka-2:19093,kafka-3:19094"
            }
        }
    },
    "reporters" : [],
    "schemaRegistry" : {
        "url" : ""
    },
    "transformations" : [],
    "validations" : [
        {
            "config" : {
                "topicNameRegex" : "[a-zA-Z0-9\\._\\-]+"
            },
            "name" : "topicMustHaveValidName",
            "priority" : 100,
            "type" : "io.streamthoughts.jikkou.kafka.validation.TopicNameRegexValidation"
        },
        {
            "config" : {
                "topicMinNumPartitions" : "1"
            },
            "name" : "topicMustHaveParitionsEqualsOrGreaterThanOne",
            "priority" : 100,
            "type" : "io.streamthoughts.jikkou.kafka.validation.TopicMinNumPartitionsValidation"
        },
        {
            "config" : {
                "topicMinReplicationFactor" : "1"
            },
            "name" : "topicMustHaveReplicasEqualsOrGreaterThanOne",
            "priority" : 100,
            "type" : "io.streamthoughts.jikkou.kafka.validation.TopicMinReplicationFactorValidation"
        }
    ]
}
```

## Automate initial Kafka topic creation

In this recipe we will create to topics

 * `topic-1` - with 8 paritions, replication-factor 3 and min.insync.replicas = 2
 * `topic-2` - with 1 partition, replication-factor 3 as a log-compacted topic

In the `scripts/jikkou` folder, create a file named `kafka-topics.yml` and add the following content

```yml
---
apiVersion: "kafka.jikkou.io/v1beta2"
kind: KafkaTopicList
metadata:
  labels:
    environment: example
items:
  - metadata:
      name: 'topic-1'
    spec:
      partitions: 8
      replicas: 3
      configMapRefs: [ "TopicConfig" ]

  - metadata:
      name: 'topic-2'
    spec:
      partitions: 1
      replicas: 3
      configMapRefs: [ "TopicConfig" ]
      configs:
        cleanup.policy: compact
---
apiVersion: "core.jikkou.io/v1beta2"
kind: ConfigMap
metadata:
  name: 'TopicConfig'
data:
  min.insync.replicas: 2
  cleanup.policy: 'delete'
```

With the file in place, execute once again

```bash
docker-compose up -d
```

To see what Jikkou has done you can visit the log file of the `jikkou` service:

```bash
docker logs -f jikkou
```

you should see an output similar to the one below

```bash
EXECUTION in 193ms
ok : 0, created : 0, altered : 0, deleted : 0 failed : 0
TASK [ADD] Add topic 'topic-1' (partitions=8, replicas=3, configs=[cleanup.policy=delete,min.insync.replicas=2]) - CHANGED
{
  "status" : "CHANGED",
  "changed" : true,
  "failed" : false,
  "end" : 1696363123181,
  "data" : {
    "apiVersion" : "kafka.jikkou.io/v1beta2",
    "kind" : "KafkaTopicChange",
    "metadata" : {
      "name" : "topic-1",
      "labels" : {
        "environment" : "example"
      },
      "annotations" : {
        "jikkou.io/resource-location" : "file:///jikkou/kafka-topics.yml"
      }
    },
    "change" : {
      "name" : "topic-1",
      "partitions" : {
        "after" : 8,
        "operation" : "ADD"
      },
      "replicas" : {
        "after" : 3,
        "operation" : "ADD"
      },
      "configs" : {
        "cleanup.policy" : {
          "after" : "delete",
          "operation" : "ADD"
        },
        "min.insync.replicas" : {
          "after" : "2",
          "operation" : "ADD"
        }
      },
      "operation" : "ADD"
    }
  }
}
TASK [ADD] Add topic 'topic-2' (partitions=1, replicas=3, configs=[cleanup.policy=delete,min.insync.replicas=2]) - CHANGED
{
  "status" : "CHANGED",
  "changed" : true,
  "failed" : false,
  "end" : 1696363123181,
  "data" : {
    "apiVersion" : "kafka.jikkou.io/v1beta2",
    "kind" : "KafkaTopicChange",
    "metadata" : {
      "name" : "topic-2",
      "labels" : {
        "environment" : "example"
      },
      "annotations" : {
        "jikkou.io/resource-location" : "file:///jikkou/kafka-topics.yml"
      }
    },
    "change" : {
      "name" : "topic-2",
      "partitions" : {
        "after" : 1,
        "operation" : "ADD"
      },
      "replicas" : {
        "after" : 3,
        "operation" : "ADD"
      },
      "configs" : {
        "cleanup.policy" : {
          "after" : "delete",
          "operation" : "ADD"
        },
        "min.insync.replicas" : {
          "after" : "2",
          "operation" : "ADD"
        }
      },
      "operation" : "ADD"
    }
  }
}
EXECUTION in 1s 713ms
ok : 0, created : 2, altered : 0, deleted : 0 failed : 0
```

The first line is from the initial startup, where there was not yet a file in the folder. The last 3 lines show that the two new topics have been created.

The topic creation would also work if done initially when first starting the platform. 

## Add a new and alter an existing Kafka topic

Edit the file `scripts/jikkou/kafka-topics.yml` file and add a new topic `topic-3` and change the data retention of `topic-1` to unlimited (`-1`):  

```yml
---
apiVersion: "kafka.jikkou.io/v1beta2"
kind: KafkaTopicList
metadata:
  labels:
    environment: example
items:
  - metadata:
      name: 'topic-1'
    spec:
      partitions: 8
      replicas: 3
      configMapRefs: [ "TopicConfig" ]
      configs:
        retention.ms: -1

  - metadata:
      name: 'topic-2'
    spec:
      partitions: 1
      replicas: 3
      configMapRefs: [ "TopicConfig" ]
      configs:
        cleanup.policy: compact

  - metadata:
      name: 'topic-3'
    spec:
      partitions: 8
      replicas: 3
---
apiVersion: "core.jikkou.io/v1beta2"
kind: ConfigMap
metadata:
  name: 'TopicConfig'
data:
  min.insync.replicas: 2
  cleanup.policy: 'delete'
```

Now perform again

```
docker-compose up -d
```

and visit the log. You should see the following additional lines

```bash
TASK [UPDATE] Update topic 'topic-1' (partitions=8, replicas=3, configs=[cleanup.policy=delete,min.insync.replicas=2,retention.ms=-1]) - CHANGED
{
  "status" : "CHANGED",
  "changed" : true,
  "failed" : false,
  "end" : 1696363379513,
  "data" : {
    "apiVersion" : "kafka.jikkou.io/v1beta2",
    "kind" : "KafkaTopicChange",
    "metadata" : {
      "name" : "topic-1",
      "labels" : {
        "environment" : "example"
      },
      "annotations" : {
        "jikkou.io/resource-location" : "file:///jikkou/kafka-topics.yml"
      }
    },
    "change" : {
      "name" : "topic-1",
      "partitions" : {
        "before" : 8,
        "after" : 8,
        "operation" : "NONE"
      },
      "replicas" : {
        "before" : 3,
        "after" : 3,
        "operation" : "NONE"
      },
      "configs" : {
        "cleanup.policy" : {
          "before" : "delete",
          "after" : "delete",
          "operation" : "NONE"
        },
        "min.insync.replicas" : {
          "before" : "2",
          "after" : 2,
          "operation" : "NONE"
        },
        "retention.ms" : {
          "before" : "604800000",
          "after" : -1,
          "operation" : "UPDATE"
        }
      },
      "operation" : "UPDATE"
    }
  }
}
TASK [NONE] Unchanged topic 'topic-2' (partitions=1, replicas=3, configs=[cleanup.policy=delete,min.insync.replicas=2]) - OK
{
  "status" : "OK",
  "changed" : false,
  "failed" : false,
  "end" : 1696363379514,
  "data" : {
    "apiVersion" : "kafka.jikkou.io/v1beta2",
    "kind" : "KafkaTopicChange",
    "metadata" : {
      "name" : "topic-2",
      "labels" : {
        "environment" : "example"
      },
      "annotations" : {
        "jikkou.io/resource-location" : "file:///jikkou/kafka-topics.yml"
      }
    },
    "change" : {
      "name" : "topic-2",
      "partitions" : {
        "before" : 1,
        "after" : 1,
        "operation" : "NONE"
      },
      "replicas" : {
        "before" : 3,
        "after" : 3,
        "operation" : "NONE"
      },
      "configs" : {
        "cleanup.policy" : {
          "before" : "delete",
          "after" : "delete",
          "operation" : "NONE"
        },
        "min.insync.replicas" : {
          "before" : "2",
          "after" : 2,
          "operation" : "NONE"
        }
      },
      "operation" : "NONE"
    }
  }
}
TASK [ADD] Add topic 'topic-3' (partitions=8, replicas=3, configs=[]) - CHANGED **********************
{
  "status" : "CHANGED",
  "changed" : true,
  "failed" : false,
  "end" : 1696363379901,
  "data" : {
    "apiVersion" : "kafka.jikkou.io/v1beta2",
    "kind" : "KafkaTopicChange",
    "metadata" : {
      "name" : "topic-3",
      "labels" : {
        "environment" : "example"
      },
      "annotations" : {
        "jikkou.io/resource-location" : "file:///jikkou/kafka-topics.yml"
      }
    },
    "change" : {
      "name" : "topic-3",
      "partitions" : {
        "after" : 8,
        "operation" : "ADD"
      },
      "replicas" : {
        "after" : 3,
        "operation" : "ADD"
      },
      "configs" : { },
      "operation" : "ADD"
    }
  }
}
EXECUTION in 808ms
ok : 1, created : 1, altered : 1, deleted : 0 failed : 0
```




