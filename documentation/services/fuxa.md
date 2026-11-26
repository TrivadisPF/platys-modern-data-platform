# FUXA

Web-based Process Visualization (SCADA/HMI/Dashboard) software.

**[Website](https://github.com/frangoteam/FUXA)** | **[Documentation](https://github.com/frangoteam/FUXA/wiki)** | **[GitHub](https://github.com/frangoteam/FUXA)**

## How to enable?

```
platys init --enable-services FUXA
platys gen
```

## How to use it?

Navigate to <http://dataplatform:1881> for the FUXA UI.

Set `FUXA_volume_map_data: true` to persist the `_appdata`, `_db`, `_logs` and `_images` folders in `./container-volume/fuxa/`.
