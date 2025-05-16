# Rancher

Rancher is a Kubernetes management tool to deploy and run clusters anywhere and on any provider.

**[Website](https://www.rancher.com/)** | **[Documentation](https://ranchermanager.docs.rancher.com)** | **[GitHub](https://github.com/rancher/rancher)**

## How to enable?

```
platys init --enable-services RANCHER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28370>.

To get the initial password, execute the following

```bash
docker logs  rancher  2>&1 | grep "Bootstrap Password:"docker logs  rancher  2>&1 | grep "Bootstrap Password:"
```
