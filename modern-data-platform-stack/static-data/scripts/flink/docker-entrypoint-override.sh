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
if [ "${FLINK_python_provide_requirements_file}" == "true" ]; then
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