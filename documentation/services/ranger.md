# Apache Ranger

Apache Ranger™ is a framework to enable, monitor and manage comprehensive data security across the Hadoop platform.

The vision with Ranger is to provide comprehensive security across the Apache Hadoop ecosystem. With the advent of Apache YARN, the Hadoop platform can now support a true data lake architecture. Enterprises can potentially run multiple workloads, in a multi tenant environment. Data security within Hadoop needs to evolve to support multiple use cases for data access, while also providing a framework for central administration of security policies and monitoring of user access.

**[Website](https://ranger.apache.org/)** | **[Documentation](https://ranger.apache.org/)** | **[GitHub](https://github.com/apache/ranger)**

## How to enable?

```
platys init --enable-services RANGER
platys gen
```

## Containers

| Container | Image | Port | Purpose |
|-----------|-------|------|---------|
| `ranger-admin` | `apache/ranger` | `6080` | Ranger Admin UI |
| `ranger-db` | `apache/ranger-db` | - | PostgreSQL metadata store |
| `ranger-solr` | `apache/ranger-solr` | `6081` (→ 8983) | Solr, `ranger_audits` collection for audit |

## How to use it?

Navigate to <http://dataplatform:6080> (default login `admin` / `admin`).

