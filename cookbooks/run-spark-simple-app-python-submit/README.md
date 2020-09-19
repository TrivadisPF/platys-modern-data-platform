# Run Python Spark Application using `spark-submit`

This recipe will show how to submit a Pyhton Spark application against the Spark Cluster of the data platform using the `spark-submit` script.

* Platform services needed: `SPARK,MINIO,AWSCLI`
* `DATAPLATFORM_HOME` environment variable needs to be set to the folder where the dataplatform resides (the `docker-compose.yml`)

## Preparing the Python Spark Application

The Spark application we are going to use is available in this [GitHub project](https://github.com/TrivadisPF/spark-simple-app). 

Download the python script with the spark application into the `data-transfer/app` folder of the platys dataplatform. 

```bash
wget https://raw.githubusercontent.com/TrivadisPF/spark-simple-app/master/python/simple-app.py -O $DATAPLATFORM_HOME/data-transfer/app/simple-app.py
```

## Upload the Spark application to MinIO S3

Create the `app-bucket`

```bash
docker exec -ti awscli s3cmd mb s3://app-bucket
```

and upload the Spark Application (jar) from the `data-transfer/app` folder to MinIO `app-bucket`:

```bash
docker exec -ti -w /data-transfer/app/ awscli s3cmd put simple-app.py s3://app-bucket/spark/ 
```

## Submit the Spark Application

A Spark application can be submitted using the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) script. It is located in the Spark's `bin` directory and available in the `spark-master` container.   

We can either submit using the local file in the `data-transfer/app` folder:

```bash
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 /data-transfer/app/simple-app.py
```

or using the jar we have uploaded to the MinIO S3 bucket:

```bash
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true s3a://app-bucket/spark/simple-app.py
```

In both cases you should see an output similar to the one below (only showing the last few lines. The output from the program is shown by this line `Lines with a: 61, lines with b: 30` (the count of character a and b in the Spark README.md file).  

```
...
20/09/19 20:14:50 INFO storage.BlockManagerInfo: Added broadcast_4_piece0 in memory on spark-master:35599 (size: 3.9 KB, free: 366.2 MB)
20/09/19 20:14:50 INFO spark.SparkContext: Created broadcast 4 from broadcast at DAGScheduler.scala:1163
20/09/19 20:14:50 INFO scheduler.DAGScheduler: Submitting 1 missing tasks from ResultStage 3 (MapPartitionsRDD[18] at count at NativeMethodAccessorImpl.java:0) (first 15 tasks are for partitions Vector(0))
20/09/19 20:14:50 INFO scheduler.TaskSchedulerImpl: Adding task set 3.0 with 1 tasks
20/09/19 20:14:50 INFO scheduler.TaskSetManager: Starting task 0.0 in stage 3.0 (TID 3, 192.168.176.7, executor 1, partition 0, NODE_LOCAL, 7771 bytes)
20/09/19 20:14:50 INFO storage.BlockManagerInfo: Added broadcast_4_piece0 in memory on 192.168.176.7:46825 (size: 3.9 KB, free: 366.2 MB)
20/09/19 20:14:50 INFO spark.MapOutputTrackerMasterEndpoint: Asked to send map output locations for shuffle 1 to 192.168.176.7:60446
20/09/19 20:14:50 INFO scheduler.TaskSetManager: Finished task 0.0 in stage 3.0 (TID 3) in 47 ms on 192.168.176.7 (executor 1) (1/1)
20/09/19 20:14:50 INFO scheduler.TaskSchedulerImpl: Removed TaskSet 3.0, whose tasks have all completed, from pool 
20/09/19 20:14:50 INFO scheduler.DAGScheduler: ResultStage 3 (count at NativeMethodAccessorImpl.java:0) finished in 0.064 s
20/09/19 20:14:50 INFO scheduler.DAGScheduler: Job 1 finished: count at NativeMethodAccessorImpl.java:0, took 0.159224 s
Lines with a: 61, lines with b: 30
20/09/19 20:14:50 INFO server.AbstractConnector: Stopped Spark@77f2176c{HTTP/1.1,[http/1.1]}{0.0.0.0:4040}
20/09/19 20:14:50 INFO ui.SparkUI: Stopped Spark web UI at http://172.16.252.12:4040
20/09/19 20:14:50 INFO cluster.StandaloneSchedulerBackend: Shutting down all executors
20/09/19 20:14:50 INFO cluster.CoarseGrainedSchedulerBackend$DriverEndpoint: Asking each executor to shut down
20/09/19 20:14:50 INFO spark.MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!
20/09/19 20:14:50 INFO memory.MemoryStore: MemoryStore cleared
20/09/19 20:14:50 INFO storage.BlockManager: BlockManager stopped
20/09/19 20:14:50 INFO storage.BlockManagerMaster: BlockManagerMaster stopped
20/09/19 20:14:50 INFO scheduler.OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!
20/09/19 20:14:50 INFO spark.SparkContext: Successfully stopped SparkContext
20/09/19 20:14:50 INFO util.ShutdownHookManager: Shutdown hook called
20/09/19 20:14:50 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-dee80bc6-7a22-4137-872c-182f5303ac2f/pyspark-78591cdb-554d-477f-8c75-fd1894d9df54
20/09/19 20:14:50 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-dee80bc6-7a22-4137-872c-182f5303ac2f
20/09/19 20:14:50 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-fe419567-b538-4a82-a095-1cc4b728c285
```
