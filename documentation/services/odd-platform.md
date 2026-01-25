# Open Data Discovery Platform (ODD)

First open-source data discovery and observability platform. We make a life for data practitioners easy so you can focus on your business. 

**[Website](https://opendatadiscovery.org/)** | **[Documentation](https://docs.opendatadiscovery.org/)** | **[GitHub](https://github.com/opendatadiscovery/odd-platform)**

## How to enable?

```
platys init --enable-services ODD_PLATFORM
platys gen
```

## How to use it?

For the Open Data Discovery Platform UI, navigate to <http://dataplatform:28399>. 

If authentication is enabled, by default the user `admin` with password `abc123!` can be used.

### Using ODD Collector

Enable the ODD collector for automatic data ingestion by setting `ODD_PLATFORM_collector_enabled` to `true`, set a token (which you get by creating a collector in ODD Platform) by configuring `ODD_PLATFORM_token` and create a file named `collector_config.yaml` in `./custom-conf/odd-platform` folder before starting the platform and add the necessary plugins to run. Here an example for harvesting the Postgresql database of ODD itself.

```yaml
platform_host_url: !ENV ${PLATFORM_HOST_URL}
default_pulling_interval: 10
token: !ENV ${TOKEN}
plugins:
  - type: postgresql
    name: test_postgresql_adapter
    host: "odd-platform-db"
    port: 5432
    database: "odd_platform_db"
    user: "odd_platform"
    password: "abc123!"
```

To find out more about the available plugins and examples, see <https://github.com/opendatadiscovery/odd-collectors>.