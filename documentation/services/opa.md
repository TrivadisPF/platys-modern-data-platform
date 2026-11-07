# Open Policy Agent (OPA)

Open Policy Agent (OPA) is an open source, general-purpose policy engine.

**[Website](https://www.openpolicyagent.org/)** | **[Documentation](https://www.openpolicyagent.org/docs/latest/)** | **[GitHub](https://github.com/open-policy-agent/opa)**

## How to enable?

```
platys init --enable-services OPA
platys gen
```

## How to configure?

By default OPA only loads the policies and data found in `./security/opa/policies`.

To start OPA with a configuration file (e.g. for bundles or decision logging), set `OPA_volume_map_config_file` to `true` in `config.yml` and regenerate. The file `./custom-conf/opa/config.yml` is then mounted into the container and passed to OPA via `--config-file`. Edit that file to match your needs.

## How to use?



