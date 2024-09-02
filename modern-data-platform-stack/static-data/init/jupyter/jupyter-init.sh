#!/bin/bash

# Removing JARs
for jar in $(echo $REMOVE_JARS | sed "s/,/ /g")
do
      rm /usr/local/spark/jars/$jar
      echo "/usr/local/spark/jars/$jar has been removed!"
done

# Downloading Maven dependencies
/maven-download.sh central ${MAVEN_DOWNLOAD_JARS} /usr/local/spark/jars