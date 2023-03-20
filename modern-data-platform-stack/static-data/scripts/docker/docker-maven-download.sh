#!/bin/bash

#
# Download connector maven dependencies
# 4 methods are available:
# - maven_dep(REPO, GROUP, PACKAGE, VERSION, FILE, MD5_CHECKSUM) # Downloads anything from a maven repo
# - maven_core_dep(GROUP, PACKAGE, VERSION, MD5_CHECKSUM) # Downloads jar files
# - maven_confluent_dep(GROUP, PACKAGE, VERSION, MD5_CHECKSUM) # Downloads jar files for Confluent deps
# - maven_debezium_plugin(CONNECTOR, VERSION, MD5_CHECKSUM) # Downnloads debezium tar plugin
#
# Author: Renato Mefi <https://github.com/renatomefi>
#
set -e

# If there's not maven repository url set externally,
# default to the ones below
MAVEN_REPO_CENTRAL=${MAVEN_REPO_CENTRAL:-"https://repo1.maven.org/maven2"}
MAVEN_REPO_INCUBATOR=${MAVEN_REPO_INCUBATOR:-"https://repo1.maven.org/maven2"}
MAVEN_REPO_CONFLUENT=${MAVEN_REPO_CONFLUENT:-"https://packages.confluent.io/maven"}
#MAVEN_DEP_DESTINATION=${MAVEN_DEP_DESTINATION}

maven_dep() {
    local REPO="$1"
    local MVN_COORD="$2"
    local MAVEN_DEP_DESTINATION="$3"
    local MD5_CHECKSUM="$4"

    local DOWNLOAD_PATH=${MVN_COORD//://}
    local PACKAGE=$(echo $MVN_COORD | cut -d: -f2)
    local VERSION=$(echo $MVN_COORD | cut -d: -f3)

    local FILE="$PACKAGE-$VERSION.jar"

    DOWNLOAD_FILE_TMP_PATH="/tmp/maven_dep/${PACKAGE}"
    DOWNLOAD_FILE="$DOWNLOAD_FILE_TMP_PATH/$FILE"
    test -d $DOWNLOAD_FILE_TMP_PATH || mkdir -p $DOWNLOAD_FILE_TMP_PATH

    curl -sfSL -o "$DOWNLOAD_FILE" "$REPO/$DOWNLOAD_PATH/$FILE"
    # echo "$MD5_CHECKSUM  $DOWNLOAD_FILE" | md5sum -c -
    mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION
}

maven_central_dep() {
    maven_dep $MAVEN_REPO_CENTRAL $1 $2 $3 $4
}

maven_confluent_dep() {
    maven_dep $MAVEN_REPO_CONFLUENT $1 $2 $3 $4
}

case $1 in
    "central" ) shift
            maven_central_dep ${@}
            ;;
    "confluent" ) shift
            maven_confluent_dep ${@}
            ;;

esac
