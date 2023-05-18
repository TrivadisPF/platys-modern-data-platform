#!/usr/bin/env bash

if [ ${FLINK_INSTALL_JARS_PACKAGES} ]
then
  /maven-download.sh central ${FLINK_INSTALL_JARS_PACKAGES} /opt/flink/lib
fi

if [ -z ${FLINK_DO_NOT_START+x} ]; then
	tail -f /dev/null
else
	/docker-entrypoint.sh $@
fi