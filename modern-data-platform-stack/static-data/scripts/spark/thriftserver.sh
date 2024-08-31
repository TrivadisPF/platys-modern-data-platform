#!/bin/bash

# export SPARK_MASTER_HOST=`hostname`

export SPARK_THRIFTSERVER_LOG=/opt/bitnami/spark/logs

. "/opt/bitnami/spark/sbin/spark-config.sh"

. "/opt/bitnami/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_THRIFTSERVER_LOG

export SPARK_HOME=/opt/bitnami/spark
export CLASS="org.apache.spark.sql.hive.thriftserver.HiveThriftServer2"

ln -sf /dev/stdout /opt/bitnami/spark/logs/spark-root-org.apache.spark.sql.hive.thriftserver.HiveThriftServer2-1-$SPARK_MASTER_HOST.out

cd /opt/bitnami/spark/bin && /opt/bitnami/spark/bin/spark-submit --class $CLASS 1 --master $SPARK_MASTER_URL --name "Thrift JDBC/ODBC Server" "$@" >> $SPARK_THRIFTSERVER_LOG/spark-thriftserver.out
