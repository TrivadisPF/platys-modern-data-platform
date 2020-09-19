package com.trivadis.sample.spark

import org.apache.spark.sql.{AnalysisException, SparkSession}
import org.apache.spark.sql.functions.col
import org.apache.spark.{SparkConf, SparkContext}
import scopt.OParser
import org.apache.spark.sql.types._

case class Config(year: String = null,
                  month: String = null,
                  day: String = null,
                  hour: String = null,
                  s3aEndpoint: String = "http://minio:9000",
                  s3aAccessKey: String = "V42FCGRVMK24JJ8DHUYG",
                  s3aSecretKey: String = "bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza")

object SampleApp extends App {

  val builder = OParser.builder[Config]
  val parser1 = {
    import builder._
    OParser.sequence(
      programName("sampleApp"),
      head("sampleApp", "1.0"),

      opt[String]('e', "s3aEndpoint")
        .optional()
        .action { (x, c) => c.copy(s3aEndpoint = x) }
        .text("s3aEndpoint is the S3a Endpoint which should be used to connect to S3"),
      opt[String]('e', "s3aAccessKey")
        .optional()
        .action { (x, c) => c.copy(s3aAccessKey = x) }
        .text("s3AccessKey is the S3a AccessKey which should be used to connect to S3"),
      opt[String]('e', "s3aSecretKey")
        .optional()
        .action { (x, c) => c.copy(s3aSecretKey = x) }
        .text("s3SecretKey is the S3a SecretKey which should be used to connect ot S3")
    )
  }
  // parser.parse returns Option[C]
  OParser.parse(parser1, args, Config()) match {
    case Some(config) =>
      // do stuff
      println("s3aEndopoint=" + config.s3aEndpoint)
      println("s3AccessKey=" + config.s3aAccessKey)
      println("s3SecretKey=" + config.s3aSecretKey)

      // digital data object input
      val digitalDataObjectRawPath = "s3a://raw-bucket/digital-data-object/avro"

      // digital data object refined
      val digitalDataObjectRefinedPath = "s3a://refined-bucket/tracking/"

      // mapping data
      val shopToFirmaMappingPath = "s3a://refined-bucket/mapping/shopToFirma"
      val hostToSystemumgebungMappingPath = "s3a://refined-bucket/mapping/hostToSystemumgebung"

      val conf = new SparkConf().setAppName("PageRequestCount")
      val spark = SparkSession.builder.appName("Scala Sample Spark Application").getOrCreate()
      spark.sparkContext.hadoopConfiguration.set("avro.mapred.ignore.inputs.without.extension", "false")
      spark.sparkContext.hadoopConfiguration.set("spark.hadoop.fs.s3a.endpoint", config.s3aEndpoint)
      spark.sparkContext.hadoopConfiguration.set("spark.hadoop.fs.s3a.access.key", config.s3aAccessKey)
      spark.sparkContext.hadoopConfiguration.set("spark.hadoop.fs.s3a.secret.key", config.s3aSecretKey)
      spark.sparkContext.hadoopConfiguration.set("spark.hadoop.fs.s3a.path.style.access", "true")
      spark.sparkContext.hadoopConfiguration.set("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")

      // define the flight schema
      val flightsSchema = StructType(Array(
        StructField("year", IntegerType, true),
        StructField("month", IntegerType, true),
        StructField("dayOfMonth", IntegerType, true),
        StructField("dayOfWeek", IntegerType, true),
        StructField("depTime", IntegerType, true),
        StructField("crsDepTime", IntegerType, true),
        StructField("arrTime", IntegerType, true),
        StructField("crsArrTime", IntegerType, true),
        StructField("uniqueCarrier", StringType, true),
        StructField("flightNum", StringType, true),
        StructField("tailNum", StringType, true),
        StructField("actualElapsedTime", IntegerType, true),
        StructField("crsElapsedTime", IntegerType, true),
        StructField("airTime", IntegerType, true),
        StructField("arrDelay", IntegerType, true),
        StructField("depDelay", IntegerType, true),
        StructField("origin", StringType, true),
        StructField("dest", StringType, true),
        StructField("distance", IntegerType, true),
        StructField("taxiIn", IntegerType, true),
        StructField("taxiOut", IntegerType, true),
        StructField("cancelled", StringType, true),
        StructField("cancellationCode", StringType, true),
        StructField("diverted", StringType, true),
        StructField("carrierDelay", StringType, true),
        StructField("weatherDelay", StringType, true),
        StructField("nasDelay", StringType, true),
        StructField("securityDelay", StringType, true),
        StructField("lateAircraftDelay", StringType, true)
        )
      )

      val flightsDf = spark.read.format("csv")
        .option("delimiter",",")
        .option("header", "false")
        .schema(flightsSchema)
        .load("s3a://flight-bucket/raw/flights/flights_2008_5_1.csv")

      flightsDf.write.format("parquet").mode("append").partitionBy("year","month").save("s3a://flight-bucket/refined/parquet/flights")
      
      spark.stop()
    case _ =>
      throw new RuntimeException("Invalid set of parameters have been passed!")
  }
}
