---
technoglogies:      streamsets
version:				1.14.0
validated-at:			3.2.2022
---

# Loading Streamsets Pipeline(s) upon start of container

This recipe will show how to import pipeline upon starting the StreamSets Data Collector.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services STREAMSETS -s trivadis/platys-modern-data-platform -w 1.14.0
```

Edit the `config.yml` and add the following configuration settings.

```
      STREAMSETS_install_pipelines: true
```

Now generate data platform and download the Streamsets Custom origin to the right folder. 

```
platys gen
```

## Copy StreamSets pipeline to scripts folder

Download the StreamSets pipeline into the scripts folder in Platys:

```
cd scripts/streamsets/pipelines

wget https://github.com/TrivadisPF/streamsets-dev-simulator/releases/download/0.8.0/dev-simulator-0.8.0.tar.gz 

tar -xvzf dev-simulator-0.8.0.tar.gz 
rm dev-simulator-0.8.0.tar.gz 

cd ../../..
```

Start the platform:

```
docker-compose up -d
```


## Check that the pipeline is running 

