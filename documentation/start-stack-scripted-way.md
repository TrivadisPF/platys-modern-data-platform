# Creating a new stack in a scripted way

Instead of initialising a platys stack with `platys init ...`, manually editing the `config.yml` and then generating the stack with `platys gen`, you can also do it in a scripted way, assuming that you have the correct configuration (e.g. values for the `config.yml`) ready.

This can be combined with [Provisioning of a `platys`-ready environment](https://github.com/TrivadisPF/platys/tree/master/documentation/environment), where different options for (automatically) creating a Platys-ready environment are shown.

Two options for doing it are shown below.

## Specifying configuration inside script

With this option, we 

1. create a working folder and navigating into
2. create a folder and then create the `config.yml` dynamically with all the configuration settings inline
3. generate the platform. using `platys gen`
4. set the two variables `PUBLIC_IP` and `DOCKER_HOST_IP` 
5. start the docker compose stack using `docker compose up -d`

```bash
mkdir -p platys-demo
cd platys-demo

cat > config.yml << EOL
      platys:
        platform-name: 'platys-platform'
        platform-stack: 'trivadis/platys-modern-data-platform'
        platform-stack-version: '1.17.0-preview'
        structure: 'flat'

      # ========================================================================
      # Global configuration, valid for all or a group of services
      # ========================================================================
      # Timezone, use a Linux string such as Europe/Zurich or America/New_York
      use_timezone: ''
      # Name of the repository to use for private images, which are not on docker hub (currently only Oracle images)
      private_docker_repository_name: 'trivadis'
      # UID to use when using the "user" property in a service to override the user inside the container
      uid: '1000'

      # Optional environment identifier of this platys instance, by default take it from environment variable but can be changed to hardcoded value. 
      # Allowed values (taken from DataHub): dev, test, qa, uat, ei, pre, non_prod, prod, corp
      env: '${PLATYS_ENV}'

      data_centers: 'dc1,dc2'
      data_center_to_use: 0

      copy_cookbook_data_folder: true
      
      # ========================================================================
      # Platys Services
      # ========================================================================
      #
      # ===== Trino ========
      #
      TRINO_enable: false
      # "single" or "cluster" install
      TRINO_install: single
      TRINO_workers: 3
      # either starburstdata or oss
      TRINO_edition: 'starburstdata'
      TRINO_auth_enabled: false
      TRINO_auth_use_custom_password_file: false
      TRINO_auth_use_custom_certs: false
      TRINO_auth_with_groups: false
      TRINO_access_control_enabled: false
      TRINO_hive_storage_format: ORC
      TRINO_hive_compression_codec: GZIP
      TRINO_hive_views_enabled: false
      TRINO_hive_run_as_invoker: false
      TRINO_hive_legacy_translation: false
      TRINO_kafka_table_names: ''
      TRINO_kafka_default_schema: ''
      TRINO_event_listener: ''
      TRINO_postgresql_database: ''
      TRINO_postgresql_user: ''
      TRINO_postgresql_password: ''
      TRINO_oracle_user: ''
      TRINO_oracle_password: ''
      TRINO_sqlserver_database: ''
      TRINO_sqlserver_user: ''
      TRINO_sqlserver_password: ''
      TRINO_with_tpch_catalog: false
      TRINO_with_tpcds_catalog: false
      TRINO_with_memory_catalog: false
      TRINO_starburstdata_use_license: false
      TRINO_starburstdata_enable_data_product: false
      TRINO_additional_catalogs: ''
      TRINO_additional_connectors: ''

      # Trino-CLI is enabled by default
      TRINO_CLI_enable: true
EOL
      
platys gen

# export the two variables if not 
export DOCKER_HOST_IP=nnn.nnn.nnn.nnn
export PUBLICH_IP=nnn.nnn.nnn.nnn

docker compose up -d
```
   
## Specifying configuration via downloadable `config.yml`

With this option, we 

1. create a working folder and navigating into
2. download the `config.yml` via a Web-link (as an example we are using GitHub Gist <https://gist.github.com/>)
3. generate the platform. using `platys gen`
3. set the two variables `PUBLIC_IP` and `DOCKER_HOST_IP` 
4. start the docker compose stack using `docker compose up -d`

```bash
mkdir -p platys-demo
cd platys-demo

wget https://gist.githubusercontent.com/gschmutz/6b9ec82c833d73981942e1d412284933/raw/62a4bc428ee8d8830cc348dc14ec7389ea3440ad/platys-trino-config.yml -O config.yml

platys gen

export DOCKER_HOST_IP=nnn.nnn.nnn.nnn
export PUBLICH_IP=nnn.nnn.nnn.nnn

docker compose up -d
```