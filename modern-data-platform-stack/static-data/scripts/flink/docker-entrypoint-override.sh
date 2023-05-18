#!/usr/bin/env bash

if [ ${FLINK_INSTALL_JARS_PACKAGES} ]
then
  /maven-download.sh central ${FLINK_INSTALL_JARS_PACKAGES} /opt/flink/lib
fi

if test -n "${FLINK_DO_NOT_START-}"; then
	tail -f /dev/null
else
	/docker-entrypoint.sh $@
fi