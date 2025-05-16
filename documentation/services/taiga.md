# Taiga 

Taiga is a free and open-source project management for cross-functional agile teams. 

**[Website](https://taiga.io/)** | **[Documentation](https://community.taiga.io/c/learn-taiga-basic)** | **[GitHub](https://github.com/taigaio/taiga)**

## How to enable?

```
platys init --enable-services TAIGA
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28323>.

### Creating an admin user

To create an admin user, perform 

```bash
docker exec -ti taiga-back python manage.py createsuperuser
```

and you are prompted for username, email address and password. 