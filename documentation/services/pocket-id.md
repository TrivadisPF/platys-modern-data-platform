# Pocket ID

A simple and easy-to-use OIDC provider that allows users to authenticate with their passkeys.

**[Website](https://pocket-id.org/)** | **[Documentation](https://pocket-id.org/docs/)** | **[GitHub](https://github.com/pocket-id/pocket-id)**

## How to enable?

```
platys init --enable-services POCKET_ID
platys gen
```

Set `POCKET_ID_encryption_key` in `config.yml` first (generate with `openssl rand -base64 32`).

## How to use it?

Navigate to <http://dataplatform:1411> for the Pocket ID UI. The environment variables (`APP_URL`, `ENCRYPTION_KEY`, `TRUST_PROXY`, `MAXMIND_LICENSE_KEY`, `PUID`, `PGID`) are set directly in the `docker-compose.yml` from the `POCKET_ID_*` parameters. Set `POCKET_ID_volume_map_data: true` to persist the data folder in `./container-volume/pocket-id/data`.
