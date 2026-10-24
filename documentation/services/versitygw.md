# Versity S3 Gateway

VersityGW is a high-performance, S3-compatible object storage gateway. It exposes an AWS S3 API backed by a POSIX filesystem (and other backends), making existing storage usable through the S3 protocol.

**[Website](https://www.versity.com/products/versitygw/)** | **[Documentation](https://github.com/versity/versitygw/wiki)** | **[GitHub](https://github.com/versity/versitygw)**

## Ports

| External Port | Internal Port | Description   |
|:-------------:|:-------------:|---------------|
| 9006          | 9000          | S3 API        |
| 9007          | 9001          | Web UI        |

## How to enable?

```bash
platys init --enable-services VERSITYGW
platys gen
```

```yaml
VERSITYGW_enable: true
```

To make the rest of the stack use VersityGW as its internal S3 service, also set:

```yaml
s3_service_to_use: versitygw
```

## How to use it?

- **S3 API**: <http://dataplatform:9006>
- **Web UI**: <http://dataplatform:9007>

Authenticate with the credentials from `VERSITYGW_access_key` / `VERSITYGW_secret_key` (overridable at runtime via `PLATYS_AWS_ACCESS_KEY` / `PLATYS_AWS_SECRET_ACCESS_KEY`).

The gateway runs the POSIX backend with a sidecar metadata store; the object data lives under `/data` and metadata under `/metadata` inside the container. Set `VERSITYGW_volume_map_data: true` to persist both to `./container-volume/versitygw/` on the Docker host.

## Creating buckets on startup

To have buckets created automatically when the stack starts, enable the companion `mc` client and list the buckets you want:

```yaml
VERSITYGW_enable: true
VERSITYGW_mc_enabled: true
VERSITYGW_buckets: raw,refined,curated
```

This starts a `versitygw-mc` container that waits for the gateway to be ready and runs `mc mb --ignore-existing` for each bucket.

