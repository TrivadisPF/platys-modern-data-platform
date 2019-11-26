## Updating the Dockerfile image

In case the docker image for the generator needs to be changed after modifying the
Dockerfile the image can be rebuilt using
 
```
docker build -t tvd/modern-data-analytics-stack-generator:1.0 .
```


## Running the service generator

The service generator allows creating `docker-compose.yml` files with  pre-configured data from the  `docker-compose.yml.j2` file.
In order to be able to run the generator `docker` is required to be installed on the machine.

The list of variables that can be configured for the service generator can be found in the `generator-config/vars/default-values.yml`
These variables can be overridden in a `yml` file accordingly to the services that you would like to be included in your docker-compose file (kafka, cassandra etc.); please ensure indentation is respected in your custom file as this is important for YML files.

Once you are happy with the services you would like configured you can run the generator script by providing 2 mandatory positional arguments :
* the path for your custom yml stack file
* the path on where the `docker-compose` file should be generated


```
./service-generator.sh [stack yml path] [output folder path]
```

Example : 
```
./service-generator.sh /tmp/custom.yml /config/output

```