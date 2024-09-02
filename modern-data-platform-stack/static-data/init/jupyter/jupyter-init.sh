#!/bin/bash

# Removing JARs
for jar in $(echo $REMOVE_JARS | sed "s/,/ /g")
do
      local JAR=$jar
      rm /usr/local/spark/jars/$JAR
      echo "/usr/local/spark/jars/$JAR has been removed!"
done

# Downloading Maven dependencies
/maven-download.sh central ${MAVEN_DOWNLOAD_JARS} /usr/local/spark/jars