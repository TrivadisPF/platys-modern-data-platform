# Unity Catalog

Open, Multi-modal Catalog for Data & AI.

**[Website](https://www.unitycatalog.io/)** | **[Documentation](https://docs.unitycatalog.io/)** | **[GitHub](https://github.com/unitycatalog/unitycatalog)**

## How to enable?

```bash
platys init --enable-services UNITY_CATALOG UNITY_CATALOG_UI
platys gen
```

## How to use it?

### Web UI

Navigate to <http://dataplatform:28393>.

### Unity Catalog CLI

```bash
docker exec -ti unity-catalog bin/uc table list --catalog unity --schema default
```