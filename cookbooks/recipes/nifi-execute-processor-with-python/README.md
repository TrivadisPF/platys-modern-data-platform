---
technologies:       nifi,python
version:				1.16.0
validated-at:			6.3.2023
---


# NiFi ExecuteScript Processor with Python

This recipe will show how to use NiFi with Python. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```bash
export DATAPLATFORM_HOME=${PWD}
platys init --enable-services NIFI -s trivadis/platys-modern-data-platform -w 1.16.0
```

Before we can generate the platform, we need to extend the `config.yml`:

```
      NIFI_python_enabled: true
      NIFI_python_provide_requirements_file: true
      NIFI_python_version: 3.10
```

We set enable the python environment (will switch to a custom Docker image extending the official NiFi image with python) and specify to provide additional Python modules with a `requirements.txt` file.

Save the file and generate and start the data platform.

```bash
platys gen
```

## Create the `requirements.txt` file

The `requirements.txt` file has to be created in `./custom-conf/nifi` folder of the platform. 

Edit the file 

```bash
nano ./custom-conf/nifi/requirments.txt`
```

and add the following module

```bash
XXXX
```

Now start the platform

```bash
docker-compose up -d
```

and once it is running navigate to the NiFi UI: <https://dataplatform:18080/nifi>.