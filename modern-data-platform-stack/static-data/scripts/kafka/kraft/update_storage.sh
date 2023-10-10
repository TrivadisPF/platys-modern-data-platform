#!/bin/sh

# <===== START: copy from run script of confluent Dockerfile (https://github.com/confluentinc/kafka-images/blob/master/kafka/include/etc/confluent/docker/run)
. /etc/confluent/docker/bash-config

echo "===> User"
id

echo "===> Configuring ..."
/etc/confluent/docker/configure

echo "===> Running preflight checks ... "
/etc/confluent/docker/ensure

# ======> END: copy

export IFS=","
for userAndPassword in $2; do
  IFS=':' read -r -a data <<< "$userAndPassword"

  kafka-storage format --config /etc/kafka/kafka.properties --ignore-formatted --cluster-id $1 --add-scram 'SCRAM-SHA-256=[name=${data[0]},password=${data[1]}]'
done
