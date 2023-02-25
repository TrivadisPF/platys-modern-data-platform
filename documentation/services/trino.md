# Trino (formerly PrestoSQL)

Trino is a distributed SQL query engine designed to query large data sets distributed over one or more heterogeneous data sources.

**[Website](https://trino.io/)** | **[Documentation](https://trino.io/docs/current/)** | **[GitHub](https://github.com/trinodb/trino)**

## How to enable?

```
platys init --enable-services TRINO
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28082>

To connect over the CLI, use:

```
docker exec -it trino-cli trino --server trino-1:8080
```

if authentication is enabled (`TRINO_auth_enabled`), then you have to connect over `https` and specify the user and the keystore:

```
docker exec -it trino-cli trino --server https://trino-1:8443 --user admin --password --insecure --keystore-path /etc/trino/trino.jks --keystore-password abc123!
```

### Security

Security for Trino can be enabled with `TRINO_auth_enabled` (to enable authentication) and `TRINO_access_control_enabled` (to enable access control). 

#### Authentication

By default the following 3 users and passwords are pre-configured:

1. `admin` : `abc123!`
2. `userA` : `abc123!`
3. `userB` : `abc123!`

You can specify your own password file in `conf/trino/security/password.db` by enabling `TRINO_auth_use_custom_password_file`. See [here](https://trino.io/docs/current/security/password-file.html#creating-a-password-file) for how to add users to the password file. 

You can also create groups by enabling `TRINO_auth_with_groups` and specifying them in `custom-conf/trino/security/group.txt`.

#### Access Control

Enable access control with `TRINO_access_control_enabled` and set the access control rules in `custom-conf/trino/security/rules.json`.


