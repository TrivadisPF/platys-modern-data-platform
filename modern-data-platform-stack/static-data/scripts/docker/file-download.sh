#!/bin/bash

#
# Download Files from Internet (currently only Github releases are supported).
#
#	- GitHub Release:	file-download.sh github "<owner>:<project>:<version>:<artefact-name>"
#
# Author: Guido Schmutz <https://github.com/gschmutz>
#
set -e

# If there's not maven repository url set externally,
# default to the ones below
GITHUB=${GITHUB:-"https://github.com"}

github_download_dep() {
    local REPO="$1"
    local GIT_COORDS="$2"
    local GITHUB_DOWNLOAD_DESTINATION="$3"
    
    for i in $(echo $GIT_COORDS | sed "s/,/ /g")
    do
      local GIT_COORD=$i

      local OWNER=$(echo $GIT_COORDS | cut -d: -f1)
      local PROJECT=$(echo $GIT_COORDS | cut -d: -f2)
      local VERSION=$(echo $GIT_COORDS | cut -d: -f3)
      local ARTEFACT_NAME=$(echo $GIT_COORDS | cut -d: -f4)

      local FILE="$ARTEFACT_NAME"

      DOWNLOAD_FILE_TMP_PATH="/tmp/git_dep/${OWNER}"
      DOWNLOAD_FILE="$DOWNLOAD_FILE_TMP_PATH/$FILE"
      test -d $DOWNLOAD_FILE_TMP_PATH || mkdir -p $DOWNLOAD_FILE_TMP_PATH

 	  DOWNLOAD_URL="$REPO/$OWNER/$PROJECT/releases/download/$VERSION/$FILE"
      echo "Downloading $DOWNLOAD_URL ...."
      curl -sfSL -o "$DOWNLOAD_FILE" "$DOWNLOAD_URL"
      
      mv "$DOWNLOAD_FILE" $GITHUB_DOWNLOAD_DESTINATION
    done
}

github_dep() {
    github_download_dep $GITHUB $1 $2 $3
}

case $1 in
    "github" ) shift
            github_dep ${@}
            ;;

esac
