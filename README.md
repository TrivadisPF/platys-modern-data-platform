![](tri_logo_high.jpg)

[![License](http://img.shields.io/:license-Apache%202-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)
[![Code Climate](https://codeclimate.com/github/codeclimate/codeclimate/badges/gpa.svg)](https://codeclimate.com/github/TrivadisPF/modern-data-platform-stack)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

#mdp - toolset for provisioning Modern Data Plaforms 
Copyright (c) 2019-2020 Trivadis

## What is `mdp` ?

**`mdp`** is a tool for genearting and provisioning Modern Data Platforms based on [Docker](https://www.docker.com/get-started) and [Docker Compose](https://docs.docker.com/compose/). 

Its main use is for small-scale Data Lab projects, Proof-of-Concepts (PoC) or Proof-of-value (PoV) projects as well as trainings.

First only a fixed set of services were supported using one `docker-compose.yml` file. This approach was quite unflexible and due to the amount of services we support also quite heavy weight. Therefore we went to a generated approach, where the user of **mdp** can decide which features to enable and based on that generate the necessary artifacts.  

A _Modern Data Platform_ is always generated based on a given _Platform Stack_. A platform stack defines the set of availble and usable services. A platform stack has a name and a version. Currently only one Platform Stack is avilable. In the future other platform stacks might be added.

## What do I need for `mdp` ?

Currently the **mdp** toolset only runs on macOS and 64-bit Linux, but we are working on a plaform-independent version, to be released with the final 1.2.0 version. 

`mdp` runs the generator for a given Platform Stack as a Docker container in the background. Therefore you need to have [Docker](https://www.docker.com/get-started) installed on the machine where you create the Platform. To run the Platform, you also need to have [Docker Compose](https://docs.docker.com/compose/) installed on the target machine, which can be different to the one where you generate the platform.  

See [Installing mdp](./documentation/install.md) and [Getting Started](./documentation/getting-started.md) for how to install and use `mdp`.

## Where can I run the generated platform ?

The generated platform can be provisioned either locally or in the cloud. See [Provisioning of Modern Data Platform](./documentation/environment/README.md) for various versions of how to deploy the stack. 

## Documentation

**Usage**

* [Installing mdp](./documentation/install.md)
* [Getting Started](./documentation/getting-started.md)
* [Frequently Asked Questions](./documentation/faq.md)
* [Command line reference](./documentation/command-line-ref.md)
* [Configuration file reference](./documentation/configuration.md)
* [Glossary of Terms](./documentation/glossary.md)

**Development**

* [Service Design Decisions](./documentation/service-design.md)
* [Port Mapping Overview](./documentation/port-mapping.md)
* [Creating and maintaining a Platform Stack](./documentation/creating-platform-stack.md)




