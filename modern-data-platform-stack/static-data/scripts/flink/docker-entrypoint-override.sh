#!/usr/bin/env bash

if [ ${FLINK_INSTALL_JARS_PACKAGES} ]
then
  /maven-download.sh central ${FLINK_INSTALL_JARS_PACKAGES} /opt/flink/lib
fi

/docker-entrypoint.sh $@