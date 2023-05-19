#!/bin/bash

#
# Download connector maven dependencies
#
# Author: Guido Schmutz <https://github.com/gschmutz>
#
set -e

# If there's not maven repository url set externally,
# default to the ones below
MAVEN_REPO_CENTRAL=${MAVEN_REPO_CENTRAL:-"https://repo1.maven.org/maven2"}
MAVEN_REPO_CONFLUENT=${MAVEN_REPO_CONFLUENT:-"https://packages.confluent.io/maven"}

maven_dep() {
    local REPO="$1"
    local MVN_COORDS="$2"
    local MAVEN_DEP_DESTINATION="$3"

    for i in $(echo $MVN_COORDS | sed "s/,/ /g")
    do
      local MVN_COORD=$i

      local GROUP_TMP=$(echo $MVN_COORD | cut -d: -f1)
      local GROUP=${GROUP_TMP//.//}
      local PACKAGE=$(echo $MVN_COORD | cut -d: -f2)
      local VERSION=$(echo $MVN_COORD | cut -d: -f3)

      local FILE="$PACKAGE-$VERSION.jar"

      DOWNLOAD_FILE_TMP_PATH="/tmp/maven_dep/${PACKAGE}"
      DOWNLOAD_FILE="$DOWNLOAD_FILE_TMP_PATH/$FILE"
      test -d $DOWNLOAD_FILE_TMP_PATH || mkdir -p $DOWNLOAD_FILE_TMP_PATH

	  DOWNLOAD_URL="$REPO/$GROUP/$PACKAGE/$VERSION/$FILE"
      echo "Downloading $DOWNLOAD_URL ...."
      curl -sfSL -o "$DOWNLOAD_FILE" "$DOWNLOAD_URL"
      
      mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION
    done
}

maven_central_dep() {
    maven_dep $MAVEN_REPO_CENTRAL $1 $2 $3
}

maven_confluent_dep() {
    maven_dep $MAVEN_REPO_CONFLUENT $1 $2 $3
}

case $1 in
    "central" ) shift
            maven_central_dep ${@}
            ;;
    "confluent" ) shift
            maven_confluent_dep ${@}
            ;;

esac
