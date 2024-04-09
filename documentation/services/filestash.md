# Filestash

A modern web client for SFTP, S3, FTP, WebDAV, Git, Minio, LDAP, CalDAV, CardDAV, Mysql, Backblaze, ...

**[Documentation](https://github.com/mickael-kerjean/filestash)** | **[GitHub](https://github.com/mickael-kerjean/filestash)**

## How to enable?

```
platys init --enable-services FILESTASH
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28192>. 

### Storage Backends

By default `s3`, `local`, `ftp` and `sftp` storage backends are enabled. Navigate to <http://dataplatform:28192/admin/backend> to change to the Admin console, where you can enable other storage backends.