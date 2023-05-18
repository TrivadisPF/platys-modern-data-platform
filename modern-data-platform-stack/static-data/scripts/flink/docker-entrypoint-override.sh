#!/usr/bin/env bash

if [ ${FLINK_INSTALL_JARS_PACKAGES} ]
then
  /maven-download.sh central ${FLINK_INSTALL_JARS_PACKAGES} /opt/flink/lib
fi

if [ ${FLINK_CONTINUE:=true} ]
then
	/docker-entrypoint.sh $@
else
	tail -f /dev/null
fi