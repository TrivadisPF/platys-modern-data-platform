#!/usr/bin/env bash

if [ ${FLINK_INSTALL_MAVEN_DEP} ]
then
  /platys-scripts/maven-download.sh central ${FLINK_INSTALL_MAVEN_DEP} /opt/flink/lib
fi

if [ ${FLINK_INSTALL_FILE_DEP} ]
then
  /platys-scripts/file-download.sh github ${FLINK_INSTALL_FILE_DEP} /opt/flink/lib
fi

if [ -z ${FLINK_DO_NOT_START} ]; then
	/docker-entrypoint.sh $@
else
	tail -f /dev/null
fi