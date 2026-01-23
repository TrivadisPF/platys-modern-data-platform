# DVD Rental

This is a DVD Rental sample database retrieved from [Neon](https://github.com/neondatabase) here: 

```bash
curl -O https://neon.tech/postgresqltutorial/dvdrental.zip
```

## Create a Platys stack

```bash
platys init --enable-services POSTGRESQL,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w develop
```

```yaml
      POSTGRESQL_multiple_databases: 'dvdrental'
      POSTGRESQL_multiple_users: 'postgres'
      POSTGRESQL_multiple_passwords: 'abc123!'
```

## Make data availble in PostgreSQL

Create an init script to load the data into postgresql

`./init/postgresql/02_init.sh`

```bash
#!/bin/bash
set -e

pg_restore -U postgres -d dvdrental /data-transfer/dvdrental/dvdrental.tar
```

