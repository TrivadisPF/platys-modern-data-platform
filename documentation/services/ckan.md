# CKAN - The Open Source Data Portal Software

CKAN is an open-source DMS (data management system) for powering data hubs and data portals. CKAN makes it easy to publish, share and use data. It powers catalog.data.gov, open.canada.ca/data, data.humdata.org among many other sites. 

**[Website](https://ckan.org/)** | **[Documentation](https://docs.ckan.org/en/2.9/)** | **[GitHub](https://github.com/ckan/ckan)**

```bash
platys init --enable-services CKAN
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28294>.

### Using CLI

```bash
docker exec -ti ckan ckan -c /srv/app/production.ini 
```