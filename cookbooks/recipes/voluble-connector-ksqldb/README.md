# Generate Live Data Streams with Voluble Connector and ksqlDB

This recipe will show how to use the Voluble Connector to generate data streams into Kafka topics using ksqlDB. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services KAFKA,KSQLDB,KAFKA_CONNECT -s trivadis/platys-modern-data-platform -w 1.13.0
```

edit the `config.yml` and add the connector to the following property

```
      KAFKA_CONNECT_connectors: 'mdrogalis/voluble:0.3.0'
```

start the platform

```
export DATAPLATFORM_HOME=${PWD}

platys gen

docker-compose up -d
```

```
docker exec -ti kafka-1 kafka-topics --create --bootstrap-server kafka-1:19092 --topic customer --replication-factor 3 --partitions 8
docker exec -ti kafka-1 kafka-topics --create --bootstrap-server kafka-1:19092 --topic inventory --replication-factor 3 --partitions 8
docker exec -ti kafka-1 kafka-topics --create --bootstrap-server kafka-1:19092 --topic order --replication-factor 3 --partitions 8

docker exec -ti kafka-1 kafka-topics --create --bootstrap-server kafka-1:19092 --topic customer-key --replication-factor 3 --partitions 8
```


## Run the connector

```bash
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088
```

```sql
DROP CONNECTOR ORDERS;

CREATE SOURCE CONNECTOR ORDERS WITH (
    'connector.class'                   = 'io.mdrogalis.voluble.VolubleSourceConnector',
    'key.converter'                     = 'org.apache.kafka.connect.storage.StringConverter',
    'value.converter'				       = 'org.apache.kafka.connect.json.JsonConverter',
    'value.converter.schemas.enable'    = 'false',

    'genkp.customer-key.with'				= '#{Code.isbn10}',

    'genkp.inventory.sometimes.with'		= '#{Code.asin}',
    'genkp.inventory.sometimes.matching' = 'inventory.key',
    'genv.inventory.amount_in_stock.with' = '#{number.number_between ''5'',''15''}',
    'genv.inventory.product_name.with'	= '#{Commerce.product_name}',
    'genv.inventory.last_updated.with'	= '#{date.past ''10'',''SECONDS''}',

    'genkp.customer.with'					= 'customer-key.key',
    'genv.customer.id.matching'         = 'customer-key.key',
    'genv.customer.name.with'				= '#{Name.full_name}',
    'genv.customer.gender.with'			= '#{Demographic.sex}',
    'genv.customer.favorite_beer.with'	= '#{Beer.name}',
    'genv.customer.state.with'			= '#{Address.state}',

    'genkp.order.matching'					= 'inventory.key',
    'genv.order.quantity.with'			= '#{number.number_between ''1'',''5''}',
    'genv.order.customer_id.matching'	= 'customer-key.key',

    'global.throttle.ms'			= '1000',
    'global.history.records.max'	= '10000'
);
```