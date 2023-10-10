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

while getopts u:a:f: flag
do
    case "${flag}" in
        i) cluster_id=${OPTARG};;
        u) users=${OPTARG};;
    esac
done

kafka-storage format --ignore-formatted -c /etc/kafka/kafka.properties --cluster-id $cluster_id --add-scram 'SCRAM-SHA-256=[name=broker,password=broker-secret]'
