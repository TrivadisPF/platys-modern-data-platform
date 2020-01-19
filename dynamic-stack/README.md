![](./../tri_logo_high.jpg)

# Modern Data Platform (MDP) Stack Generator 2.0.0

This is the dynamic version of the Modern Data Platform stack. It is the version we will continue with, the full-stack is no longer maintained. 

The idea here is to specify the possible and supported services in a template file, from which a docker-compose stack file can be generated. The generator is dynamic and services have to be enabled in order for them to appear in the stack. 

You can run the Modern Data Platform Stack Generator (MDP Stack Generator) on macOS and 64-bit Linux.

## MDP Stack Generator

The service generator is available as a docker image from where it can be run. 

It can be found on [Docker Hub](https://hub.docker.com/repository/docker/trivadis/modern-data-platform-stack-generator) under `trivadis/modern-data-platform-stack-generator`.

Tag      | Status         |  Changes
---------|----------------| --------------------------
1.2.0-preview | on-going  | Support of different Jupyter versions, Support of multiple MQTT brokers, InfluxDB added, new version of bash script
1.0.0    | stable         | Initial, first version


Check [What's new?](../documentation/changes.md) for a more detailled list of changes.

If you want to build the docker image locally, perform (this is not necessary if you follow the installation instructions below).

```
docker build -t trivadis/modern-data-platform-stack-generator:1.2.0-preview .
```

## MDP Documentation

**Usage**

* [Installing MDP](../documentation/install.md)
* [Getting Started](../documentation/getting-started.md)
* [Frequently Asked Questions](../documentation/faq.md)
* [Command line reference](../documentation/command-line-ref.md)
* [Configuration file reference](../documentation/configuration.md)

**Development**

* [Service Design Decisions](../documentation/service-design.md)
* [Port Mapping Overview](../documentation/port-mapping.md)

