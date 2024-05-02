# Fluent Bit

Fast and Lightweight Logs and Metrics processor for Linux, BSD, OSX and Windows 

**[Website](https://fluentbit.io/)** | **[Documentation](https://docs.fluentbit.io/manual)** | **[GitHub](https://github.com/fluent/fluent-bit)**

## How to enable?

```
platys init --enable-services FLUENT_BIT
platys gen
```

## How to use it?

Place a `fluent-bit.conf` or `fluent-bit.yaml` file into the `./custom-conf/fluent-bit/` folder and set the `FLUENT_BIT_volume_map_config` to `true` and specify the file-name using the `FLUENT_BIT_config_filename` property.

Here an example of a config file using the YAML notation:

```yaml
pipeline:
    inputs:
        - name: cpu
          tag: my_cpu

    outputs:
        - name: stdout
          match: '*'
```
