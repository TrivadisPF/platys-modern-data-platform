# Frequently Asked Questions

If you don’t see your question here, feel free to add an issue on GitHub. 

## Is there support for Raspberry Pi?

Running `Platys` itself on Raspberry Pi has not been tested so far. 

But the `modern-data-platform-stack` supports generating a docker-compose file with only components running on ARM devices. You can find the services which support ARM in the [configuration file reference](../platform-stacks/modern-data-platform/documentation/configuration.md).

If you want to easily start with docker on Raspberry Pi, we suggest to use [HyperiotOS](https://blog.hypriot.com/).  

## How can I add additional services, not supported by a Platform Stack?

Find the documentation on how to do this in the [Platys project](https://github.com/TrivadisPF/platys/tree/master/documentation/docker-compose-override.md).

## How can I provision Kafka topics automatically?

Use the following service block for provisioning Kafka topics automatically as part of the stack: 

``` 
  kafka-setup:
    image: confluentinc/cp-kafka:5.4.0
    hostname: kafka-setup
    container_name: kafka-setup
    command: "bash -c 'echo Waiting for Kafka to be ready... && \
                       cub kafka-ready -b kafka-1:19092 1 20 && \
                       kafka-topics --create --if-not-exists --zookeeper zookeeper-1:2181 --partitions 1 --replication-factor 1 --topic orders"
    environment:
      # The following settings are listed here only to satisfy the image's requirements.
      # We override the image's `command` anyway, hence this container will not start a broker.
      KAFKA_BROKER_ID: ignored
      KAFKA_ZOOKEEPER_CONNECT: ignored
``` 

Add this service to the `docker-compose.override.yml` file. 
 
## How can I provision StreamSets Pipelines automatically?

Use the following service block for provisioning StreamSets Pipelines automatically as part of the stack: 

``` 
  streamsets-setup:
    image: tutum/curl
    hostname: streamsets-setup
    container_name: streamsets-setup
    depends_on:
      - streamsets-1
    volumes:
      - ./streamsets-pipelines:/import
    command:
      - bash 
      - -c 
      - |
        echo "Waiting for Streamsets to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} --insecure http://streamsets-1:18630/rest/v1/pipelines/status) -ne 200 ] ; do 
          echo -e $$(date) " Streamsets state: " $$(curl -s -o /dev/null -w %{http_code} --insecure http://streamsets-1:18630/rest/v1/pipelines/status) " (waiting for 200)"
          sleep 5 
        done
        nc -vz streamsets-1 18630
        echo -e "\n--\n+> Creating Streamsets Pipelines"
        curl -XPOST -u admin:admin -v -H 'Content-Type: multipart/form-data' -H 'X-Requested-By: My Import Process' -F file=@/import/pipelines-v1.0.zip --insecure http://streamsets:18630/rest/v1/pipelines/import
        sleep infinity
``` 

Add this service to the `docker-compose.override.yml` file. 

## How can I provision Kafka Connect Connector instances automatically?

Use the following service block for provisioning Kafka Connect Connector instances automatically as part of the stack: 

``` 
  connect:
    image: confluentinc/cp-kafka-connect:5.4.0
    hostname: connect
    container_name: connect
    depends_on:
      - zookeeper
      - broker
      - schema-registry
    ports:
      - "8083:8083"
    volumes:
      - ./kafka-connect-jdbc-sink-hafen-vm.json:/opt/kafka-connect-jdbc-sink-hafen-vm.json:Z
    environment:
      CONNECT_BOOTSTRAP_SERVERS: 'kafka-1:19092'
      CONNECT_REST_ADVERTISED_HOST_NAME: connect
      CONNECT_REST_PORT: 8083
      CONNECT_GROUP_ID: compose-connect-group
      CONNECT_CONFIG_STORAGE_TOPIC: docker-connect-configs
      CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_OFFSET_FLUSH_INTERVAL_MS: 10000
      CONNECT_OFFSET_STORAGE_TOPIC: docker-connect-offsets
      CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_STATUS_STORAGE_TOPIC: docker-connect-status
      CONNECT_STATUS_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_KEY_CONVERTER: org.apache.kafka.connect.storage.StringConverter
      CONNECT_VALUE_CONVERTER: io.confluent.connect.avro.AvroConverter
      CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: http://schema-registry-1:8081
      CONNECT_INTERNAL_KEY_CONVERTER: "org.apache.kafka.connect.json.JsonConverter"
      CONNECT_INTERNAL_VALUE_CONVERTER: "org.apache.kafka.connect.json.JsonConverter"
      CONNECT_ZOOKEEPER_CONNECT: 'zookeeper-1:2181'
      # Assumes image is based on confluentinc/kafka-connect-datagen:latest which is pulling 5.1.1 Connect image
      CLASSPATH: /usr/share/java/monitoring-interceptors/monitoring-interceptors-5.3.0.jar
      CONNECT_PRODUCER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"
      CONNECT_CONSUMER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"
      CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components"
      CONNECT_LOG4J_ROOT_LOGLEVEL: WARN
      CONNECT_LOG4J_LOGGERS: org.apache.zookeeper=ERROR,org.I0Itec.zkclient=ERROR,org.reflections=ERROR
    command:
      - bash 
      - -c 
      - |
        /etc/confluent/docker/run & 
        echo "Waiting for Kafka Connect to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} http://connect:8083/connectors) -ne 200 ] ; do 
          echo -e $$(date) " Kafka Connect listener HTTP state: " $$(curl -s -o /dev/null -w %{http_code} http://connect:8083/connectors) " (waiting for 200)"
          sleep 5 
        done
        nc -vz connect 8083
        echo -e "\n--\n+> Creating Kafka Connect TimescaleDB sink"
        curl -X POST -H "Content-Type: application/json" -d @/opt/kafka-connect-jdbc-sink-hafen-vm.json http://connect:8083/connectors
        sleep infinity
```

Add this service to the `docker-compose.override.yml` file. 

## How can I provision Avro Schema instances automatically?

Use the following service block for provisioning Kafka Connect Connector instances automatically as part of the stack: 

```
  schema-registry-setup:
    image: blacktop/httpie
    hostname: schema-registry-setup
    container_name: schema-registry-setup
    volumes:
      - ./avro-schemas:/import:Z
    entrypoint: /bin/sh
    command:
      - -c 
      - |
        echo "Waiting for Schema-Registry to start listening on connect..."
        while [ $$(curl -s -o /dev/null -w %{http_code} http://schema-registry-1:8081/subjects) -ne 200 ] ; do 
          echo -e $$(date) " Schema-Registry state: " $$(curl -s -o /dev/null -w %{http_code} http://schema-registry-1:8081/subjects) " (waiting for 200)"
          sleep 5 
        done
        nc -vz schema-registry 8081
        echo -e "\n--\n+> Registering Avro Schemas"
        
        http -v --ignore-stdin POST http://schema-registry-1:8081/subjects/Barge/versions Accept:application/vnd.schemaregistry.v1+json schema=@/import/Barge-v1.avsc        

        sleep infinity
    restart: always
```

Add this service to the `docker-compose.override.yml` file. 

   
## `platys` documentation

* [Getting Started with `platys` and the `modern-data-platform` platform stack](getting-started.md)
* [Explore the full list of Platys commands](https://github.com/TrivadisPF/platys/tree/master/documentation/overview-platys-command.md)
