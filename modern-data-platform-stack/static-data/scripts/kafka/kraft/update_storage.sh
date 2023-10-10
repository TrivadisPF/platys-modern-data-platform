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
  user=$userAndPassword | cut -d ':' -f 1
  password=$userAndPassword | cut -d ':' -f 2

  echo "$user / $password"
done

kafka-storage format --ignore-formatted -c /etc/kafka/kafka.properties --cluster-id $1 --add-scram 'SCRAM-SHA-256=[name=broker,password=broker]'
kafka-storage format --ignore-formatted -c /etc/kafka/kafka.properties --cluster-id $1 --add-scram 'SCRAM-SHA-256=[name=client,password=client-secret]'
