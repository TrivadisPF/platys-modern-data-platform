# Consume binary file and send it as Kafka message

Works with >1.8.0

This recipe will show how to use StreamSets Data Collector to read a binary file (we use image files) and send it as binary (opaque) message to an Apache Kafka topic. We will use another StreamSets pipeline to test that the message can be read and written out as a file, which should be the same as the original one.

* Platform services needed: `KAFKA,STREAMSETS,KAFKACAT`
* add the `STREAMSETS_volume_map_security_policy` property and set it to `true`
* `DATAPLATFORM_HOME` environment variable needs to be set to the folder where the dataplatform resides (the `docker-compose.yml`)

## Create the input and output folders

Create two folders inside the `data-transfer` folder holding the input and output data and make sure it is writeable by docker.

```
mkdir -p $DATAPLATFORM_HOME/data-transfer/in
mkdir -p $DATAPLATFORM_HOME/data-transfer/out
chmod o+w $DATAPLATFORM_HOME/data-transfer/in/
chmod o+w $DATAPLATFORM_HOME/data-transfer/out/
```

## Create the Kafka topic

Create the necessary Kafka topic:

```
docker exec -ti kafka-1 kafka-topics --create --zookeeper zookeeper-1:2181 --topic binary-content --replication-factor 3 --partitions 1
```

## Create the 1st StreamSets pipeline

In a browser, navigate to the StreamSets application on <http://dataplatform:18630> and login as user `admin` with password `admin`. 

Create a new pipeline and name it `BinaryFile-to-Kafka`. 

Add a `Directory` origin and set the following properties:

* `Files Directory` = `/data-transfer/in`
* `File Name Pattern` = `**.png`
* `Data Format` = `Whole File`

Add a `Kafka Producer` destination and set the following properties:

* `Broker URI` = `kafka-1:19092`
* `Topic` = `binary-content`
* `Data Format` = `Binary`
* `Binary Field Path` = `/content`

Add a `Groovy Evaluator` processor inbetween the `Directory` and `Kafka Producer` components and replace the `Script` property with the following snippet:

```
/*
 * Available constants:
 *   They are to assign a type to a field with a value null.
 *   sdc.NULL_BOOLEAN, sdc.NULL_CHAR, sdc.NULL_BYTE, sdc.NULL_SHORT, sdc.NULL_INTEGER, sdc.NULL_LONG,
 *   sdc.NULL_FLOAT, sdc.NULL_DOUBLE, sdc.NULL_DATE, sdc.NULL_DATETIME, sdc.NULL_TIME, sdc.NULL_DECIMAL,
 *   dsc.NULL_BYTE_ARRAY, sdc.NULL_STRING, sdc.NULL_LIST, sdc.NULL_MAP
 *
 * Available objects:
 *   sdc.records: A collection of Records to process. Depending on the processing mode
 *            it may have 1 record or all the records in the batch (default).
 *
 *   sdc.state: A Map<String, Object> that is preserved between invocations of this script.
 *          Useful for caching bits of data, e.g. counters.
 *
 *   sdc.log.<level>(msg, obj...): Use instead of println to send log messages to the log4j log
 *                             instead of stdout.
 *                             loglevel is any log4j level: e.g. info, warn, error, trace.
 *   sdc.output.write(Record): Writes a record to the processor output.
 *
 *   sdc.error.write(Record, message): Writes a record to the error pipeline.
 *
 *   sdc.getFieldNull(Record, 'field path'): Receive a constant defined above
 *                          to check if the field is typed field with value null
 *
 *   sdc.createRecord(String recordId): Creates a new record.
 *                          Pass a recordId to uniquely identify the record and include enough information to track down the record source.
 *   sdc.createMap(boolean listMap): Create a map for use as a field in a record.
 *                          Pass true to this function to create a list map (ordered map)
 *
 *   sdc.createEvent(String type, int version): Creates a new event.
 *                          Create new empty event with standard headers.
 *   sdc.toEvent(Record): Send event to event stream
 *                          Only events created with sdcFunctions.createEvent are supported.
 *   sdc.isPreview(): Determine if pipeline is in preview mode.
 *   sdc.pipelineParameters(): Map with pipeline runtime parameters.
 *
 * Available Record Header Variables:
 *   record.attributes: a map of record header attributes.
 *   record.<header name>: get the value of 'header name'.
 */

// Sample Groovy code
records = sdc.records
for (record in records) {
    try {
        // Reading the content of the file behind the fileRef and add it as a property "content"
        input_stream = record.value['fileRef'].getInputStream();
        try {
            byte[] targetArray = new byte[input_stream.available()];
            input_stream.read(targetArray)
            record.value['content'] = targetArray
        } finally {
            input_stream.close();
        }      
         
        sdc.output.write(record)
    } catch (e) {
        // Write a record to the error pipeline
        sdc.log.error(e.toString(), e)
        sdc.error.write(record, e.toString())
    }
}
```

Add a `Expression Evaluator` processor after the `Groovy Evaluator` and set the following properties:

* `Name` = `Set Kafka Key`
* Add a `Header Attribute Expression` with
  * `Header Attribute` =`kafkaMessageKey`
  * `Header Attribute Expression` = `${record:value('/fileInfo/filename')}`

## Granting permission for Groovy script

For the groovy code to be able to access the file resource, we need to update Streamsets security policy:

Inside the `conf.override` folder, copy the file `sdc-security.policy.template` to `sdc-security.policy`.

Edit the `sdc-security.policy` file and add the `java.io.FilePermission` to the groovy section:

```
// groovy source code
grant codebase "file:///groovy/script" { 
  permission java.lang.RuntimePermission "getClassLoader";
  permission java.io.FilePermission "/data-transfer/in/*", "read";
};
```

Restart the `streamsets-1` service: 

```
docker restart streamsets-1
```

## Test the first pipeline

Start the Streamsets pipeline and listen on the kafka topic using `kafkacat`:

```
docker exec -ti kafkacat kafkacat -b kafka-1 -t binary-content
```

Copy a binary file (a png image) into the `$DATAPLATFORM_HOME/data-transfer/in` folder. 

```
docker exec -ti streamsets-1 wget https://raw.githubusercontent.com/TrivadisPF/platys-modern-data-platform/master/documentation/images/modern-data-platform-overview.png -O /data-transfer/in/1.png
```

Change the name of the output file (1.png) if you want the file to be processed again. 

## Create the 2nd StreamSets pipeline for testing

Now let's use another pipeline to read the Kafka topic and write the content of the message to a file. 

Create a new pipeline and name it `Kafka-to-BinaryFile`. 

Add a `Kafka Consumer` origin and set the following properties:

* `Broker URI` = `kafka-1:19092`
* `Topic` = `binary-content`
* `Key Capture Mode`= `Record Header`
* `Data Format` = `Binary`
* `Max Data Size (bytes)` = '500000' 

Add a `Local FS` destination and set the following properties:

* `Directory Template` = `/data-transfer/out`
* `Files Suffix` = `png`
* `Data Format` = `Binary`

Run the pipeline and check for a file in `$DATAPLATFORM_HOME/data-transfer/out`. It should be a copy of the original image file.
