# Keycloak

Open Source Identity and Access Management For Modern Applications and Services.

**[Website](https://www.keycloak.org/)** | **[Documentation](https://www.keycloak.org/documentation)** | **[GitHub](https://github.com/keycloak/keycloak)**

## How to enable?

```
platys init --enable-services KEYCLOAK
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28204>.

Login with user `admin` and password `abc123!`.

## How to export data from a realm

Replace `<realm-name>` by the name of the realm to export and <filename> by the file to write to (e.g. `data-transfer/xxxx-realm.json` to make it available outside of the container).

```bash
docker exec -it keycloak /opt/keycloak/bin/kc.sh --realm <realm-name> --file <filename>
```

