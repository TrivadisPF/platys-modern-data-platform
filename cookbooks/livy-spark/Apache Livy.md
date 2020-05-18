# Apache Livy

In this cookbook we show how [Apache Livy](https://livy.incubator.apache.org/) can be used to schedule Spark Batch jobs. 

Here you can find the [REST API documentation of Livy](https://livy.incubator.apache.org/docs/latest/rest-api.html).

## Prerequistes
```
export LIVY_HOST=dataplatform:8998
```

```
apt-get install jq
```

## Submitting a job

```
curl -v -H 'Content-Type: application/json' -X POST -d '{ "file":"s3a://application-bucket/digital-data-object-refinement-1.0-SNAPSHOT-jar-with-dependencies.jar", "className":"de.printus.edh.tracking.spark.PageInfoRefinementApp", "args":["--year","2020","--month","04","--day","30"], "conf": {"spark.jars.packages": "io.delta:delta-core_2.11:0.6.0,org.apache.spark:spark-avro_2.11:2.4.5", "spark.hadoop.fs.s3a.endpoint": "http://minio:9000", "spark.hadoop.fs.s3a.access.key":"V42FCGRVMK24JJ8DHUYG", "spark.hadoop.fs.s3a.secret.key":"bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza", "spark.hadoop.fs.s3a.path.style.access":"true", "spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem" } }' "http://$LIVY_HOST/batches" | jq
```

will produce an output similar to shown below

```
$ curl -v -H ....

Note: Unnecessary use of -X or --request, POST is already inferred.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 172.16.252.11...
* TCP_NODELAY set
* Connected to dataplatform (172.16.252.11) port 8998 (#0)
> POST /batches HTTP/1.1
> Host: dataplatform:8998
> User-Agent: curl/7.58.0
> Accept: */*
> Content-Type: application/json
> Content-Length: 638
> 
} [638 bytes data]
* upload completely sent off: 638 out of 638 bytes
< HTTP/1.1 201 Created
< Date: Wed, 13 May 2020 09:08:32 GMT
< Content-Type: application/json;charset=utf-8
< Location: /batches/8
< Content-Length: 133
< Server: Jetty(9.3.24.v20180605)
< 
{ [133 bytes data]
100   771  100   133  100   638   6045  29000 --:--:-- --:--:-- --:--:-- 35045
* Connection #0 to host dataplatform left intact
{
  "id": 8,
  "name": null,
  "state": "running",
  "appId": null,
  "appInfo": {
    "driverLogUrl": null,
    "sparkUiUrl": null
  },
  "log": [
    "stdout: ",
    "\nstderr: "
  ]
}
```

## Checking for the Status of the Job

Now you can regularly check for the status of the job by using a GET request with the ID of the job (retrieved in the result of the submit above). In our case here the `id` was 8. 

```
curl -v -H 'Content-Type: application/json' -X GET "http://$LIVY_HOST/batches/8" | jq
```

will produce an output similar to shown below indicating that the job is in `running` state.

```
curl -v -H 'Content-Type: application/json' -X GET "http://$LIVY_HOST/batches/8" | jq
Note: Unnecessary use of -X or --request, GET is already inferred.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 172.16.252.11...
* TCP_NODELAY set
* Connected to dataplatform (172.16.252.11) port 8998 (#0)
> GET /batches/8 HTTP/1.1
> Host: dataplatform:8998
> User-Agent: curl/7.58.0
> Accept: */*
> Content-Type: application/json
> 
< HTTP/1.1 200 OK
< Date: Wed, 13 May 2020 09:09:31 GMT
< Content-Type: application/json;charset=utf-8
< Content-Length: 1319
< Server: Jetty(9.3.24.v20180605)
< 
{ [1319 bytes data]
100  1319  100  1319    0     0  87933      0 --:--:-- --:--:-- --:--:-- 87933
* Connection #0 to host dataplatform left intact
{
  "id": 8,
  "name": null,
  "state": "running",
  "appId": null,
  "appInfo": {
    "driverLogUrl": null,
    "sparkUiUrl": null
  },
  "log": [
    "20/05/13 11:09:31 INFO scheduler.TaskSetManager: Starting task 37.0 in stage 31.0 (TID 842, 172.18.0.21, executor 0, partition 37, NODE_LOCAL, 7760 bytes)",
    "20/05/13 11:09:31 INFO scheduler.TaskSetManager: Finished task 12.0 in stage 31.0 (TID 830) in 322 ms on 172.18.0.21 (executor 0) (6/50)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_6 in memory on 172.18.0.20:43831 (size: 4.0 B, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_3 in memory on 172.18.0.20:43831 (size: 4.0 B, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_8 in memory on 172.18.0.20:43831 (size: 4.0 B, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_0 in memory on 172.18.0.20:43831 (size: 4.0 B, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_1 in memory on 172.18.0.20:43831 (size: 4.0 B, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_42 in memory on 172.18.0.20:43831 (size: 2.4 KB, free: 365.8 MB)",
    "20/05/13 11:09:31 INFO storage.BlockManagerInfo: Added rdd_129_30 in memory on 172.18.0.21:38157 (size: 534.0 B, free: 365.9 MB)",
    "\nstderr: "
  ]
}
```

After a while on a next request, the status will change to `success`.

```
{
  "id": 8,
  "name": null,
  "state": "success",
  "appId": null,
  "appInfo": {
    "driverLogUrl": null,
    "sparkUiUrl": null
  },
  "log": [
    "20/05/13 11:09:38 INFO spark.MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!",
    "20/05/13 11:09:38 INFO memory.MemoryStore: MemoryStore cleared",
    "20/05/13 11:09:38 INFO storage.BlockManager: BlockManager stopped",
    "20/05/13 11:09:38 INFO storage.BlockManagerMaster: BlockManagerMaster stopped",
    "20/05/13 11:09:38 INFO scheduler.OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!",
    "20/05/13 11:09:38 INFO spark.SparkContext: Successfully stopped SparkContext",
    "20/05/13 11:09:38 INFO util.ShutdownHookManager: Shutdown hook called",
    "20/05/13 11:09:38 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-2e61e507-d68d-4dd1-b0a4-45af8d039de4",
    "20/05/13 11:09:38 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-7728e54e-a89b-4ace-af3a-9c1db798f31e",
    "\nstderr: "
  ]
}
```

## Retrieving the Log lines of the job

To retrieve the Log lines of a finished job, you can to a GET on the `batches/{id}/log` endpoint:

```
curl -v -H 'Content-Type: application/json' -X GET "http://$LIVY_HOST/batches/8/log" | jq
```

## Deleting the job

If you want to remove the job from the log, you can use a DELETE.

```
curl -v -H 'Content-Type: application/json' -X DELETE "http://$LIVY_HOST/batches/8" | jq
```
