#!/bin/bash
#
# Initialize SOLR for Dataverse by creating a ckan core
# Arguments are supplied via environment variables: DATAVERSE_CORE_NAME
# Example:
#   DATAVERSE_CORE_NAME=collection1

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
    cp -R /docker-entrypoint-initdb.d/conf/* $COREDIR/conf
    
    echo "SOLR initialized"
fi
