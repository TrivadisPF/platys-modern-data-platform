---
technoglogies:      trino,kafka
version:				1.14.0
validated-at:			18.11.2021
---

# Querying data in Kafka from Trino (formerly PrestoSQL)

This recipe will show how to query data from a Kakfa topic using Trino. It is an adapted version of the tutorial in the [Trino documentation](https://trino.io/docs/current/connector/kafka-tutorial.html).

## Initialise a platform

First [initialise a platys-supported data platform](../../getting-started.md) with the following services enabled 

```bash
platys init --enable-services TRINO,KAFKA,SCHEMA_REGISTRY,KAFKA_AKHQ,KAFKACAT,PROVISIONING_DATA -s trivadis/platys-modern-data-platform -w 1.13.0
```

add the follwing property to `config.yml`

```bash
KAFKA_auto_create_topics_enable: true

TRINO_edition: 'oss'
TRINO_kafka_table_names: 'tpch.customer,tpch.orders,tpch.lineitem,tpch.part,tpch.partsupp,tpch.supplier,tpch.nation,tpch.region'
```

Now generate and start the data platform. 

```bash
platys gen

docker-compose up -d
```

## Create Data in Kafka

Download the tpch-kafka loader from Maven central

```bash
curl -o kafka-tpch https://repo1.maven.org/maven2/de/softwareforge/kafka_tpch_0811/1.0/kafka_tpch_0811-1.0.sh
```

```bash
chmod 755 kafka-tpch
```

Now run the kafka-tpch program to preload a number of topics with tpch data

```bash
./kafka-tpch load --brokers localhost:29092 --prefix tpch. --tpch-type tiny
```


## Query Customer Table from Trino

Next let's query the data from Trino. Connect to the Trino CLI using

```bash
docker exec -it trino-cli trino --server trino-1:8080 --catalog kafka --schema tpch
```

List the tables to verify that things are working

```sql
show tables;
```

Kafka data is unstructured, and it has no metadata to describe the format of the messages. 

```sql
DESCRIBE customer;
```

Without further configuration, the Kafka connector can access the data, and map it in raw form. However there are no actual columns besides the built-in ones:

```sql
trino:tpch> describe customer
         -> ;
      Column       |              Type              | Extra |                   Comment
-------------------+--------------------------------+-------+---------------------------------------------
 _partition_id     | bigint                         |       | Partition Id
 _partition_offset | bigint                         |       | Offset for the message within the partition
 _message_corrupt  | boolean                        |       | Message data is corrupt
 _message          | varchar                        |       | Message text
 _headers          | map(varchar, array(varbinary)) |       | Headers of the message as map
 _message_length   | bigint                         |       | Total number of message bytes
 _key_corrupt      | boolean                        |       | Key data is corrupt
 _key              | varchar                        |       | Key text
 _key_length       | bigint                         |       | Total number of key bytes
 _timestamp        | timestamp(3)                   |       | Message timestamp
(10 rows)
```

```sql
SELECT * FROM customer;
```

```sql
trino:tpch> select * from customer;
 _partition_id | _partition_offset | _message_corrupt |                                                                                                                                                                      _message                                >
---------------+-------------------+------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
             0 |                 0 | false            | {"rowNumber":1,"customerKey":1,"name":"Customer#000000001","address":"IVhzIApeRb ot,c,E","nationKey":15,"phone":"25-989-741-2988","accountBalance":711.56,"marketSegment":"BUILDING","comment":"to the even, >
             0 |                 1 | false            | {"rowNumber":2,"customerKey":2,"name":"Customer#000000002","address":"XSTf4,NCwDVaWNe6tEgvwfmRchLXak","nationKey":13,"phone":"23-768-687-3665","accountBalance":121.65,"marketSegment":"AUTOMOBILE","comment">
             0 |                 2 | false            | {"rowNumber":3,"customerKey":3,"name":"Customer#000000003","address":"MG9kdTD2WBHm","nationKey":1,"phone":"11-719-748-3364","accountBalance":7498.12,"marketSegment":"AUTOMOBILE","comment":" deposits eat sl>
             0 |                 3 | false            | {"rowNumber":4,"customerKey":4,"name":"Customer#000000004","address":"XxVSJsLAGtn","nationKey":4,"phone":"14-128-190-5944","accountBalance":2866.83,"marketSegment":"MACHINERY","comment":" requests. final, >

```


The data from Kafka can be queried using Trino, but it is not yet in actual table shape. The raw data is available through the _message and _key columns, but it is not decoded into columns. As the sample data is in JSON format, the [JSON functions and operators](https://trino.io/docs/current/functions/json.html) built into Trino can be used to slice the data.

We can use the `json_extract_scalar` function to extract the values from the `_message` column:

```sql
SELECT sum(cast(json_extract_scalar(_message, '$.accountBalance') AS double)) FROM customer LIMIT 10;
```

### Add a topic description file

The Kafka connector supports topic description files to turn raw data into table format. These files are located in the `etc/kafka` folder in the Trino installation and must end with .json. It is recommended that the file name matches the table name, but this is not necessary.

Create a file `tpch.customer.json` in the folder `conf/trino/kafka` (this is the folder which is mapped to `etc/kafka` inside the container)

```json
{
    "tableName": "customer",
    "schemaName": "tpch",
    "topicName": "tpch.customer",
    "key": {
        "dataFormat": "raw",
        "fields": [
            {
                "name": "kafka_key",
                "dataFormat": "LONG",
                "type": "BIGINT",
                "hidden": "false"
            }
        ]
    },
    "message": {
        "dataFormat": "json",
        "fields": [
            {
                "name": "row_number",
                "mapping": "rowNumber",
                "type": "BIGINT"
            },
            {
                "name": "customer_key",
                "mapping": "customerKey",
                "type": "BIGINT"
            },
            {
                "name": "name",
                "mapping": "name",
                "type": "VARCHAR"
            },
            {
                "name": "address",
                "mapping": "address",
                "type": "VARCHAR"
            },
            {
                "name": "nation_key",
                "mapping": "nationKey",
                "type": "BIGINT"
            },
            {
                "name": "phone",
                "mapping": "phone",
                "type": "VARCHAR"
            },
            {
                "name": "account_balance",
                "mapping": "accountBalance",
                "type": "DOUBLE"
            },
            {
                "name": "market_segment",
                "mapping": "marketSegment",
                "type": "VARCHAR"
            },
            {
                "name": "comment",
                "mapping": "comment",
                "type": "VARCHAR"
            }
        ]
    }
}
```

Restart trino

```bash
docker restart trino-1
```

```bash
docker exec -it trino-cli trino --server trino-1:8080 --catalog kafka --schema tpch
```

Now for all the fields in the JSON of the message, columns are defined and the sum query from earlier can operate on the `account_balance` column directly:


```sql
DESCRIBE customer;
```


```sql
trino:tpch> describe customer
         -> ;
      Column       |              Type              | Extra |                   Comment
-------------------+--------------------------------+-------+---------------------------------------------
 kafka_key         | bigint                         |       |
 row_number        | bigint                         |       |
 customer_key      | bigint                         |       |
 name              | varchar                        |       |
 address           | varchar                        |       |
 nation_key        | bigint                         |       |
 phone             | varchar                        |       |
 account_balance   | double                         |       |
 market_segment    | varchar                        |       |
 comment           | varchar                        |       |
 _partition_id     | bigint                         |       | Partition Id
 _partition_offset | bigint                         |       | Offset for the message within the partition
 _message_corrupt  | boolean                        |       | Message data is corrupt
 _message          | varchar                        |       | Message text
 _headers          | map(varchar, array(varbinary)) |       | Headers of the message as map
 _message_length   | bigint                         |       | Total number of message bytes
 _key_corrupt      | boolean                        |       | Key data is corrupt
 _key              | varchar                        |       | Key text
 _key_length       | bigint                         |       | Total number of key bytes
 _timestamp        | timestamp(3)                   |       | Message timestamp
(20 rows)
```

```sql
SELECT * FROM customer LIMIT 5;
```


```sql
SELECT sum(account_balance) FROM customer LIMIT 10;
```

Now all the fields from the customer topic messages are available as Trino table columns.
