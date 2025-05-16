#!/bin/bash
#
# Initialize SOLR for Dataverse by creating a Solr core
# Arguments are supplied via environment variables: DATAVERSE_CORE_NAME
# Example:
#   DATAVERSE_CORE_NAME=collection1
#
# The files in conf have been copied from the Dataverse configbaker docker image. To update, perform the following command
#  cd ./init/dataverse/solr/conf
#  docker create --name temp-container gdcc/configbaker:alpha
#  docker cp temp-container:/template/conf/schema.xml .
#  docker cp temp-container:/template/conf/solrconfig.xml .
#  docker rm temp-container

set -e

# Set some defaults as documented
DATAVERSE_CORE_NAME=${DATAVERSE_CORE_NAME:-"collection1"}

echo "Check whether SOLR is initialized for Dataverse"
COREDIR="$SOLR_HOME/$DATAVERSE_CORE_NAME"
if [ -d "$COREDIR" ]; then
    echo "SOLR already initialized, skipping initialization"
else
    echo "Initializing SOLR core $DATAVERSE_CORE_NAME for Dataverse"
    # init script for handling an empty /var/solr
    /opt/solr/docker/scripts/init-var-solr
    
    # Precreate Dataverse core
    /opt/solr/docker/scripts/precreate-core $DATAVERSE_CORE_NAME
    
    # Remove the managed schema and replace it with the Dataverse metadata
    echo "Removing the managed schema"
    rm $COREDIR/conf/managed-schema.xml

    echo "Adding Dataverse schema and solrconfig"
    cp -R /docker-entrypoint-initdb.d/conf/*.xml $COREDIR/conf
    
    echo "SOLR initialized"
fi
