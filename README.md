![](tri_logo_high.jpg)

[![License](http://img.shields.io/:license-Apache%202-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)
[![Code Climate](https://codeclimate.com/github/codeclimate/codeclimate/badges/gpa.svg)](https://codeclimate.com/github/TrivadisPF/modern-data-platform-stack)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# Trivadis Modern Data Platform (MDP)

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

## Changes

The change log can be found [here](./documentation/changes.md).
