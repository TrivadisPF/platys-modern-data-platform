# Lightdash

Lightdash is an open-source BI tool that connects directly to your dbt project, allowing data teams to define metrics in code and share them with the whole organization through a self-serve analytics interface.

**[Website](https://www.lightdash.com/)** | **[Documentation](https://docs.lightdash.com/)** | **[GitHub](https://github.com/lightdash/lightdash)**

## How to enable?

```
platys init --enable-services LIGHTDASH
platys gen
```

> **Important**: Set `LIGHTDASH_secret` to a strong random string (32+ characters) and keep it constant across deployments — losing it makes stored data inaccessible.

## How to use it?

Navigate to <http://dataplatform:28422>

On first access, create your admin account and connect a dbt project or warehouse directly.

