# Tyk Dashboard

The Tyk Dashboard is the visual GUI and analytics platform for Tyk. It provides an easy-to-use management interface for managing a Tyk installation as well as clear and granular analytics.

The Dashboard also provides the API Developer Portal, a customisable developer portal for your API documentation, developer auto-enrolment and usage tracking.

Tyk Dashboard is part of the Professional license and not open source.

**[Website](https://tyk.io)** | **[Documentation](https://tyk.io/docs/tyk-dashboard/)** 

## How to enable?

```
platys init --enable-services TYK,TYK_DASHBOARD
platys gen
```

Before starting the stack, create an .env file and add an environment variable with the license

```bash
TYK_DB_LICENSEKEY=
```

## How to use it?

Navigate to <http://dataplatform:28281>