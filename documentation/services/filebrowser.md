# File Browser

A Web-based File Browser.

**[Documentation](https://filebrowser.org/)** | **[GitHub](https://github.com/filebrowser/filebrowser)** | **[Docker Image](https://github.com/hurlenko/filebrowser-docker)** 

## How to enable?

```
platys init --enable-services FILE_BROWSER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28178> and login with the default user `admin` and password `admin`. 

### Changing password

Add to `config.yml`

```
FB_PASSWORD=<bcrypt-password>
```

To encrypt the password, you can run `docker run -ti hurlenko/filebrowser hash <password>`.