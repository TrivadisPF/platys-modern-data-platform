---
technoglogies:      jupyter,jupyterhub
version:				1.16.0
validated-at:			27.11.2022
---

# Using JupyterHub

This recipe will show how to use JupyterHub with Platys.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services JUPYTER,POSTGRESQL -s trivadis/platys-modern-data-platform -w 1.16.0
```

Edit the `config.yml` and add the following properties after `JUPYTERHUB_enable`

```yaml
      JUPYTERHUB_python_packages: ''
      JUPYTERHUB_authenticator_class: 'jupyterhub.auth.DummyAuthenticator' 
      JUPYTERHUB_global_password: abc123!
      JUPYTERHUB_use_postgres: true
      JUPYTERHUB_postgres_host: postgresql
      JUPYTERHUB_postgres_db: postgres
      JUPYTERHUB_postgres_username: postgres
      JUPYTERHUB_postgres_password: abc123!
```

Configure users for JupyterHub by creating the file `userlist` in `custom-conf/jupyterhub`. 

```bash
jhadmin	admin
jhuser
```

Generate and start the platform

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```
 
## Using JupyterHub

Navigate to JupyterHub on <http://dataplatform:28284>. 

