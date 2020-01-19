# Services Design

This document describes some design decisions in the way the services are built by the generator.

## Service Variants

If you have a service, which can be deployed in various ways and for each one there is a separate docker image, then we use the concept of service editions. 

When working with service editions, the `<service>_enabled` flag generically enables the service (where `<service>` is replaced by the name of the service) independent of the edition in use. Then there is a second text property, specifying the edition.

```
<service>_enabled=[true | false]
<service>_edition=['edition-1' | 'edition-2' | ... ] 
```
 
An example where this concpet is applied can be found with the `Jupyter` service:

```
JUPYTER_enable: false
# one of 'minimal', 'r', 'scipy', 'tensorflow', 'datascience', 'all_spark'
JUPYTER_edition: 'minimal'
``` 

## Multiple Service Major Versions

Normally, a service version is just a property which can be changed from one version to another and represents the tag of the docker image which should be used. This is the case with minor version changes. 

In case where a service has a major new version, then we can also duplicate the service completley. We might chose this route if the new service is no longer backward compatible with the previous one or if the new service is released as a preview or beta version and it should have it's own default versions. 

In that case, we have separate enable flags, one for each major version. 

```
<service>_enabled=[true | false]
<service>2_enable=[true | false]
```

An example where this concpet is applied can be found with the `hivemq` service, where we allow both the HiveMQ v3 and v4 to be enabled, without having to change the version property:

```
HIVEMQ3_enable: false #needs MQTT_ENABLE = true
HIVEMQ4_enable: false #needs MQTT_ENABLE = true
```

