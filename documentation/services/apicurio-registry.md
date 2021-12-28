# Apicurio Registry 

In the context of Apicurio, a registry is a runtime system (server) that stores a specific set of artifacts (files). At its core, a registry provides the ability to add, update, and remove the artifacts from the store, typically via a remote API of some kind (often a REST API). 

**[Website](https://www.apicur.io/registry/)** | **[Documentation](https://www.apicur.io/registry/docs/apicurio-registry/2.0.1.Final/index.html)** | **[GitHub](https://github.com/Apicurio/apicurio-registry)**

## How to enable?

```
platys init --enable-services APICURIO_REGISTRY
platys gen
```

## How to use it?

You can use it as a Confluent-compliant registry by using the following Schema Registry URL

```
http://dataplatform:8081/apis/ccompat/v6
```
