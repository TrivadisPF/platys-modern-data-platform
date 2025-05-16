#!/bin/bash

# Removing JARs
for jar in $(echo $REMOVE_JARS | sed "s/,/ /g")
do
    echo "Trying to remove /usr/local/spark/jars/$jar"
    rm -fv /usr/local/spark/jars/$jar
done

# Downloading Maven dependencies
if [ -d "/usr/local/spark/jars" ]; then
	/maven-download.sh central ${MAVEN_DOWNLOAD_JARS} /usr/local/spark/jars
fi