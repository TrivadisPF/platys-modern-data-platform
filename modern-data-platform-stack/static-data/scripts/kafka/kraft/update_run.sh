#!/bin/sh

# Docker workaround: Remove check for KAFKA_ZOOKEEPER_CONNECT parameter
sed -i '/KAFKA_ZOOKEEPER_CONNECT/d' /etc/confluent/docker/configure

# Docker workaround: Ignore cub zk-ready
sed -i 's/cub zk-ready/echo ignore zk-ready/' /etc/confluent/docker/ensure

# KRaft required step: Format the storage directory with a new cluster ID
echo >> /etc/confluent/docker/ensure
echo "kafka-storage format --ignore-formatted -t $CLUSTER_ID -c /etc/kafka/kafka.properties" >> /etc/confluent/docker/ensure
