# Modern Data Analytics Stack

This project sets up the infrastructure for testing a modern data analytics stack with services such as

* Kafka
* Spark
* Hadoop HDFS
* StreamSets
* Zeppelin

and many others.

Each service runs as a Docker container and the whole stack is composed using [Docker Compose](https://docs.docker.com/compose/). The stack can be provisioned either locally or in the cloud

The complete stack can be found in the [`base-stack`](./base-stack/README.md) folder. 

Customized version of the stack (mainly downside to only the services needed) can be found under the [`customer-poc`](./base-stack/README.md) folder.
