# Modern Data Platform Stack   ![](https://www.trivadis.com/hubfs/tri_logo_high.jpg)

This project sets up the infrastructure for testing a modern data platform stack with services such as

* Kafka
* Spark
* Hadoop Ecosystem
* StreamSets & NiFi
* Zeppelin & Jupyter
* NoSQL

and many others.

Each service runs as a Docker container and the whole stack is composed using [Docker Compose](https://docs.docker.com/compose/). The stack can be provisioned either locally or in the cloud. See [Provisioning of Analytics Platform](./full-stack/environment/README.md) for various versions of how to deploy the stack. 

The **new way for using the stack** is in a dynamic way. It can be found in the [`dynamic-stack`](./dynamic-stack/README.md) folder. The idea here is to keep a complete version of the stack in one single docker-compose template file from where an instance of a `docker-compose.yml` file can be generated.    

The **full stack** is no longer mainained. It can be found in the [`full-stack`](./full-stack/README.md) folder. 

Customised versions of the stack (mainly downsized to only the services needed for a given project) can be found under the [`customer-poc`](./full-stack/README.md) folder.

## Changes

The change log can be found [here](./full-stack/Changes.md).
