# Lenses Box

Lenses Box is a Docker image which contains Lenses and a full installation of Kafka with all its relevant components. The image packs Lenses’ Stream Reactor Connector collection as well. It is all pre-setup and the only requirement is having Docker installed. It contains Lenses, Kafka Broker, Schema Registry, Kafka Connect, 25+ Kafka Connectors with SQL support and various CLI tools.

**[Website](https://lenses.io/)** | **[Documentation](https://docs.lenses.io/3.0/dev/lenses-box/)** | **[GitHub](https://github.com/lensesio/fast-data-dev)**

## How to enable?

```
platys init --enable-services LENSES_BOX
platys gen
```

Add the `LENSES_BOX_license` property with the license information you have gotten per email from <lenses.io>.

## How to use it?

Navigate to <http://dataplatform:3030> and login with admin/admin.
