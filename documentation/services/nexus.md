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

