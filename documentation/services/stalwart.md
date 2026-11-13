# Stalwart

Stalwart is an all-in-one mail and collaboration server supporting SMTP, IMAP, JMAP, CalDAV, CardDAV and WebDAV.

**[Website](https://stalw.art/)** | **[Documentation](https://stalw.art/docs/)** | **[GitHub](https://github.com/stalwartlabs/stalwart)**

## How to enable?

```
platys init --enable-services STALWART
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28513/admin> and sign in as `admin` with the password set in `STALWART_admin_password` (default `abc123!`) to complete the initial setup.

The following ports are exposed on the Docker host:

| Host port | Protocol |
|-----------|----------|
| 28513 | Admin UI / JMAP over HTTP |
| 28514 | SMTP |
| 28515 | SMTP submission (STARTTLS) |
| 28516 | SMTP submission (implicit TLS) |
| 28517 | IMAP |
| 28518 | IMAPS |
| 28519 | ManageSieve |
| 28520 | HTTPS (JMAP, admin, ACME) |

Set `STALWART_volume_map_data` to `true` to keep the configuration (`./container-volume/stalwart/etc`) and the data (`./container-volume/stalwart/data`) across container re-creation.
