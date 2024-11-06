#!/bin/bash
#
# Initialize SOLR for Dataverse by copying the metafiles

set -e

cp conf/* /template/

echo "SOLR initialized"