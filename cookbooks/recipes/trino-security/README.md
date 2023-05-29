---
technologies:       trino
version:				1.16.0
validated-at:			25.02.2023
---

# Trino Security

This recipe will show how to use [Trino](http://trino.io) with [security enabled](https://trino.io/docs/current/security/overview.html). We will first enable [TLS and HTTPS](https://trino.io/docs/current/security/tls.html) with [Password File Authentication](https://trino.io/docs/current/security/password-file.html) and then in a second step we will also enable [File-based access control](https://trino.io/docs/current/security/file-system-access-control.html).

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services TRINO,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.16.0
```

Before we can generate the platform, we need to extend the `config.yml`:

## Add Authentication

Enable authentication by adding the following settings to the `config.yml`

```
      TRINO_auth_enabled: true
      TRINO_auth_use_custom_password_file: false
      TRINO_auth_with_groups: false
```

Now set an environment variable to the home folder of the dataplatform and generate the data platform.

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen
```

Platys uses a self-signed certificate for TLS, you can create you own certificate. 

It also uses the [Password File Authentication](https://trino.io/docs/current/security/password-file.html) type of Trino and for that a password file is needed. By default a password file with 3 users (`admin`, `userA` and `userB`) with password `abc123!` is used. 

### Create a custom Password file (optional)

You can use your own password file and add your own users. For that you need to enable `TRINO_auth_use_custom_password_file` and then create the password file using

```bash
cd $DATAPLATFORM_HOME
touch custom-conf/trino/security/password.db
```

Now add or update the password for a user (replace `<new-user>` by the username). 

```bash
htpasswd -B -C 10 custom-conf/trino/security/password.db <new-user>
```

### Create Custom Certificates (optional)

You can create your own certificate and add it to a keystore. For that you need to enable `TRINO_auth_use_custom_certs` and then create the self-signed certificate and add it to the keystore using these commands


```bash
cd $DATAPLATFORM/custom-conf/trino

keytool -genkeypair -alias trino -keyalg RSA -keystore certs/keystore.jks \
-dname "CN=coordinator, OU=datalake, O=dataco, L=Sydney, ST=NSW, C=AU" \
-ext san=dns:coordinator,dns:coordinator.presto,dns:coordinator.presto.svc,dns:coordinator.presto.svc.cluster.local,dns:coordinator-headless,dns:coordinator-headless.presto,dns:coordinator-headless.presto.svc,dns:coordinator-headless.presto.svc.cluster.local,dns:localhost,dns:trino-proxy,ip:127.0.0.1,ip:192.168.64.5,ip:192.168.64.6 \
-storepass abc123!

keytool -exportcert -file certs/trino.cer -alias trino -keystore certs/keystore.jks -storepass abc123!

keytool -import -v -trustcacerts -alias trino_trust -file certs/trino.cer -keystore certs/truststore.jks -storepass password -keypass abc123! -noprompt


keytool -keystore certs/keystore.jks -exportcert -alias trino -storepass abc123! | openssl x509 -inform der -text

keytool -importkeystore -srckeystore certs/keystore.jks -destkeystore certs/trino.p12 -srcstoretype jks -deststoretype pkcs12 -storepass abc123! 

openssl pkcs12 -in certs/trino.p12 -out certs/trino.pem

openssl x509 -in certs/trino.cer -inform DER -out certs/trino.crt
```

### Start the platform

Now start the data platform.

```bash
docker-compose up -d
```

## Test Authentication

First let's see what happens if we use the Trino CLI without specifying a user and still over HTTP port:

```bash
docker exec -it trino-cli trino --server trino-1:8080
```

if we execute the SQL statement `SELECT * FROM system.runtime.nodes` we can see a HTTP `403` error.

```bash
trino> SELECT * FROM system.runtime.nodes;
Error running command: Error starting query at http://trino-1:8080/v1/statement returned an invalid response: JsonResponse{statusCode=403, headers={cache-control=[must-revalidate,no-cache,no-store], content-length=[422], content-type=[text/html;charset=iso-8859-1]}, hasValue=false} [Error: <html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1"/>
<title>Error 403 Forbidden</title>
</head>
<body><h2>HTTP ERROR 403 Forbidden</h2>
<table>
<tr><th>URI:</th><td>/v1/statement</td></tr>
<tr><th>STATUS:</th><td>403</td></tr>
<tr><th>MESSAGE:</th><td>Forbidden</td></tr>
<tr><th>SERVLET:</th><td>org.glassfish.jersey.servlet.ServletContainer-5810772a</td></tr>
</table>

</body>
</html>
]
```

we have to specify the `8443` port for using HTTPs, the username and the keystore to use:

```bash
docker exec -it trino-cli trino --server https://trino-1:8443 --user admin --password --insecure --keystore-path /etc/trino/trino.jks --keystore-password abc123!
```

Use `abc123!` for the password.

if we now execute the SQL statement `SELECT * FROM system.runtime.nodes` we can see that it works

```bash
trino> SELECT * FROM system.runtime.nodes;
 node_id |        http_uri        | node_version | coordinator | state
---------+------------------------+--------------+-------------+--------
 trino-1 | http://172.19.0.4:8080 | 407          | true        | active
(1 row)

Query 20230225_215138_00001_fd6cc, FINISHED, 1 node
Splits: 1 total, 1 done (100.00%)
0.20 [1 rows, 39B] [4 rows/s, 194B/s]
```

## Add Authorization

Enable authorization by adding the following settings to the `config.yml`

```
      TRINO_access_control_enabled: true
```

Regenerate the platform.

```bash
export DATAPLATFORM_HOME=${PWD}

platys gen
```

### Configure the access control rules file

Create a file `rules.json` in `custom-conf/trino/security/` and add the following configuration

```json
{
  "catalogs": [
    {
      "catalog": "system",
      "allow": "none"
    }
  ]
}
```

With this configuration, we disallow access to the system catalog for all users.

Now update the platform using

```bash
docker-compose up -d
```

## Test Authorization

Let's test if the authorization works by using the Trino CLI

```bash
docker exec -it trino-cli trino --server https://trino-1:8443 --user admin --password --insecure --keystore-path /etc/trino/trino.jks --keystore-password abc123!
```

Use `abc123!` for the password.

if we now execute the SQL statement `SELECT * FROM system.runtime.nodes` we can see that we get an access denied error!

```bash
trino> SELECT * FROM system.runtime.nodes
    -> ;
Query 20230225_221051_00000_guu2i failed: Access Denied: Cannot access catalog system
```

