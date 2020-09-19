# Run Java Spark Application using `spark-submit`

This recipe will show how to submit a Java Spark application against the Spark Cluster of the data platform using the `spark-submit` script.

* Platform services needed: `SPARK,MINIO,AWSCLI`
* `DATAPLATFORM_HOME` environment variable needs to be set to the folder where the dataplatform resides (the `docker-compose.yml`)
* 
## Preparing the Java Spark Application

The Spark application we are going to use is available in this [GitHub project](https://github.com/TrivadisPF/spark-simple-app). 

You can 

1. download the pre-built JAR from GitHub or
2. build it on your own using `maven`

### 1) Download pre-built application

Download the pre-built JAR into the `data-transfer/app` folder of the platys dataplatform. 

```bash
wget https://github.com/TrivadisPF/spark-simple-app/releases/download/spark-2.4.7/spark-java-sample-1.0-SNAPSHOT.jar -O $DATAPLATFORM_HOME/data-transfer/app/spark-java-sample-1.0-SNAPSHOT.jar
```

### 2) Build the Spark application

Clone the project with the application from GitHub:

```bash
git clone https://github.com/TrivadisPF/spark-simple-app.git
```

Build the Spark java application using Maven:

```bash
cd spark-simple-app/java/spark-java-app
mvn package
```

Copy the generated artefact `spark-java-sample-1.0-SNAPSHOT.jar` in the `target` folder into the `data-transfer/app` folder of the platys dataplatform. 

```bash
cp target/spark-java-sample-1.0-SNAPSHOT.jar $DATAPLATFORM_HOME/data-transfer/app
```

## Upload the Spark application to MinIO S3

Create the `app-bucket`

```bash
docker exec -ti awscli s3cmd mb s3://app-bucket
```

and upload the Spark Application (JAR) from the `data-transfer/app` folder to MinIO `app-bucket`:

```bash
docker exec -ti -w /data-transfer/app/ awscli s3cmd put spark-java-sample-1.0-SNAPSHOT.jar s3://app-bucket/spark/ 
```

## Submit the Spark Application

A Spark application can be submitted using the [`spark-submit`](https://spark.apache.org/docs/latest/submitting-applications.html) script. It is located in the Spark's `bin` directory and available in the `spark-master` container.   

We can either submit using the local JAR file inside the `data-transfer/app` folder:

```bash
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 --class com.trivadis.sample.spark.SimpleApp /data-transfer/app/spark-java-sample-1.0-SNAPSHOT.jar
```

or using the JAR file we have uploaded to the MinIO S3 bucket:

```bash
docker exec -ti spark-master spark-submit --master spark://spark-master:7077 --class com.trivadis.sample.spark.SimpleApp --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 --conf spark.hadoop.fs.s3a.access.key=V42FCGRVMK24JJ8DHUYG --conf spark.hadoop.fs.s3a.secret.key=bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza --conf spark.hadoop.fs.s3a.path.style.access=true s3a://app-bucket/spark/spark-java-sample-1.0-SNAPSHOT.jar
```

In both cases you should see an output similar to the one below (only showing the last few lines. The output from the program is shown by this line `Lines with a: 61, lines with b: 30` (the count of character a and b in the Spark README.md file).  

```
...
20/09/19 12:43:01 INFO scheduler.DAGScheduler: Submitting ResultStage 3 (MapPartitionsRDD[18] at count at SimpleApp.java:13), which has no missing parents
20/09/19 12:43:01 INFO memory.MemoryStore: Block broadcast_4 stored as values in memory (estimated size 7.3 KB, free 365.9 MB)
20/09/19 12:43:01 INFO memory.MemoryStore: Block broadcast_4_piece0 stored as bytes in memory (estimated size 3.9 KB, free 365.9 MB)
20/09/19 12:43:01 INFO storage.BlockManagerInfo: Added broadcast_4_piece0 in memory on spark-master:44893 (size: 3.9 KB, free: 366.2 MB)
20/09/19 12:43:01 INFO spark.SparkContext: Created broadcast 4 from broadcast at DAGScheduler.scala:1163
20/09/19 12:43:01 INFO scheduler.DAGScheduler: Submitting 1 missing tasks from ResultStage 3 (MapPartitionsRDD[18] at count at SimpleApp.java:13) (first 15 tasks are for partitions Vector(0))
20/09/19 12:43:01 INFO scheduler.TaskSchedulerImpl: Adding task set 3.0 with 1 tasks
20/09/19 12:43:01 INFO scheduler.TaskSetManager: Starting task 0.0 in stage 3.0 (TID 3, 192.168.176.7, executor 1, partition 0, NODE_LOCAL, 7771 bytes)
20/09/19 12:43:01 INFO storage.BlockManagerInfo: Added broadcast_4_piece0 in memory on 192.168.176.7:39639 (size: 3.9 KB, free: 366.2 MB)
20/09/19 12:43:01 INFO spark.MapOutputTrackerMasterEndpoint: Asked to send map output locations for shuffle 1 to 192.168.176.7:58208
20/09/19 12:43:01 INFO scheduler.TaskSetManager: Finished task 0.0 in stage 3.0 (TID 3) in 58 ms on 192.168.176.7 (executor 1) (1/1)
20/09/19 12:43:01 INFO scheduler.TaskSchedulerImpl: Removed TaskSet 3.0, whose tasks have all completed, from pool 
20/09/19 12:43:01 INFO scheduler.DAGScheduler: ResultStage 3 (count at SimpleApp.java:13) finished in 0.071 s
20/09/19 12:43:01 INFO scheduler.DAGScheduler: Job 1 finished: count at SimpleApp.java:13, took 0.182177 s
Lines with a: 61, lines with b: 30
20/09/19 12:43:01 INFO server.AbstractConnector: Stopped Spark@65e7f52a{HTTP/1.1,[http/1.1]}{0.0.0.0:4040}
20/09/19 12:43:01 INFO ui.SparkUI: Stopped Spark web UI at http://172.16.252.12:4040
20/09/19 12:43:01 INFO cluster.StandaloneSchedulerBackend: Shutting down all executors
20/09/19 12:43:01 INFO cluster.CoarseGrainedSchedulerBackend$DriverEndpoint: Asking each executor to shut down
20/09/19 12:43:01 INFO spark.MapOutputTrackerMasterEndpoint: MapOutputTrackerMasterEndpoint stopped!
20/09/19 12:43:01 INFO memory.MemoryStore: MemoryStore cleared
20/09/19 12:43:01 INFO storage.BlockManager: BlockManager stopped
20/09/19 12:43:01 INFO storage.BlockManagerMaster: BlockManagerMaster stopped
20/09/19 12:43:01 INFO scheduler.OutputCommitCoordinator$OutputCommitCoordinatorEndpoint: OutputCommitCoordinator stopped!
20/09/19 12:43:01 INFO spark.SparkContext: Successfully stopped SparkContext
20/09/19 12:43:01 INFO util.ShutdownHookManager: Shutdown hook called
20/09/19 12:43:01 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-6dc66810-5f8f-4ab1-bc56-edc1aae2089d
20/09/19 12:43:01 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-96fdb1bb-87ed-43c0-92ec-0928951dd695
```
