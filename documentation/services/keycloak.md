# Keycloak

Open Source Identity and Access Management For Modern Applications and Services.

**[Website](https://www.keycloak.org/)** | **[Documentation](https://www.keycloak.org/documentation)** | **[GitHub](https://github.com/keycloak/keycloak)**

## How to enable?

```
platys init --enable-services KEYCLOAK
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28204>

## How to export data from a realm

Replace `<realm-name>` by the name of the realm to export:

```bash
docker exec -it keycloak /opt/jboss/keycloak/bin/keycloak-export.sh <realm-name>
```

