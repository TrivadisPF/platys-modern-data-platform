# Sonatype Nexus Repository Manager

Sonatype Nexus Repository Manager is a universal artifact repository that supports a wide range of package formats including Maven, npm, Docker, PyPI, NuGet, and more.

**[Website](https://www.sonatype.com/products/sonatype-nexus-repository)** | **[Documentation](https://help.sonatype.com/en/sonatype-nexus-repository.html)** | **[GitHub](https://github.com/sonatype/nexus-public)**

## Enable the service

```yaml
NEXUS_enable: true
```

## How to use it?

Nexus is available at <http://dataplatform:28426>.

The default admin credentials are:

- **Username:** `admin`
- **Password:** found in `/nexus-data/admin.password` on first startup (or `admin123` for older versions)

## Getting the Root CA

```bash
openssl s_client -connect repo1.maven.org:443 -proxy <proxy-host>:<proxy-port> -showcerts 2>/dev/null | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/' > ./security/nexus/certs/root_ca.pem
```

## Testing Nexus

## Maven Central Proxy

```bash
curl "http://localhost:28426/repository/maven-central/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar" -o /dev/null -w "%{http_code}\n"
```

## PyPi Proxy

```bash
curl "http://localhost:28426/repository/pypi-proxy/simple/requests/"
```