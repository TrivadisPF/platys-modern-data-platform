# Fluent Bit

Fast and Lightweight Logs and Metrics processor for Linux, BSD, OSX and Windows 

**[Website](https://fluentbit.io/)** | **[Documentation](https://docs.fluentbit.io/manual)** | **[GitHub](https://github.com/fluent/fluent-bit)**

## How to enable?

```
platys init --enable-services FLUENT_BIT
platys gen
```

## How to use it?

Place a `fluent-bit.conf` or `fluent-bit.yaml` file into the `./custom-conf/fluent-bit/` folder and set the `FLUENT_BIT_volume_map_config` to `true`.

```yaml
pipeline:
    inputs:
        - name: cpu
          tag: my_cpu

    outputs:
        - name: stdout
          match: '*'
```
