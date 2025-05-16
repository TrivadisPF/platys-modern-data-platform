#!/usr/bin/env bash
INIT_DIR="/opt/sql-client/init"

if [ ${FLINK_INSTALL_MAVEN_DEP} ]
then
  /platys-scripts/maven-download.sh central ${FLINK_INSTALL_MAVEN_DEP} /opt/flink/lib
fi

if [ ${FLINK_INSTALL_FILE_DEP} ]
then
  /platys-scripts/file-download.sh github ${FLINK_INSTALL_FILE_DEP} /opt/flink/lib
fi

# add python modules
if [ ${FLINK_PYTHON_PROVIDE_REQUIREMENTS_FILE} ]; then
  echo "install python modules"
  pip install -r /opt/flink/requirements.txt
fi

# Wait for metastore if we need to
METASTORE="${METASTORE_HOST}:${METASTORE_PORT}"
if [ "$METASTORE" != ":" ]; then

  echo "Waiting for metastore to come up at " $METASTORE
  CONNECTED=false
  while ! $CONNECTED; do

    curl $METASTORE > /dev/null 2> /dev/null
    curlResult=$?

    # CURL code 52 means metastore is up
    if [ $curlResult == '52' ]; then
      CONNECTED=true
    fi

    echo "."
    sleep 1
  done;
  echo "Metastore is there!"
  
  # install hadoop dependencies - as shown here: https://www.decodable.co/blog/catalogs-in-flink-sql-hands-on#using-the-hive-catalog-with-flink-sql
  mkdir -p ./lib/hive
  curl https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.3.0/woodstox-core-5.3.0.jar -o ./lib/hive/woodstox-core-5.3.0.jar
  curl https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar -o ./lib/hive/commons-logging-1.1.3.jar
  curl https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar -o ./lib/hive/commons-configuration2-2.1.1.jar
  curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.2/hadoop-auth-3.3.2.jar -o ./lib/hive/hadoop-auth-3.3.2.jar
  curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.2/hadoop-common-3.3.2.jar -o ./lib/hive/hadoop-common-3.3.2.jar
  curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.2/hadoop-hdfs-client-3.3.2.jar -o ./lib/hive/hadoop-hdfs-client-3.3.2.jar
  curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/3.3.2/hadoop-mapreduce-client-core-3.3.2.jar -o ./lib/hive/hadoop-mapreduce-client-core-3.3.2.jar
  curl https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar -o ./lib/hive/hadoop-shaded-guava-1.1.1.jar
  curl https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar -o ./lib/hive/stax2-api-4.2.1.jar
  
fi

echo "Start initialization"
if [ -d "$INIT_DIR" ]; then
	echo "Init folder found at " $INIT_DIR
	for initfile in "$INIT_DIR"/*.sql; do
		echo "Running init file: " $initfile
		cat $initfile | /opt/sql-client/sql-client.sh
	done
else
	echo "No init folder found at " $INIT_DIR
fi
echo "Initialization finished"

if [ -z ${FLINK_DO_NOT_START} ]; then
	/docker-entrypoint.sh $@
else
	tail -f /dev/null
fi