#!/bin/bash

#
# Download connector maven dependencies
#
# Params: 
#     - Repository (central or confluent)
#     - Maven Coordiantes
#     - Download destination
#     - Download strategy (using curl, wget or python)
# Author: Guido Schmutz <https://github.com/gschmutz>
#
set -e

# If there's not maven repository url set externally,
# default to the ones below
MAVEN_REPO_CENTRAL=${MAVEN_REPO_CENTRAL:-"https://repo1.maven.org/maven2"}
MAVEN_REPO_CONFLUENT=${MAVEN_REPO_CONFLUENT:-"https://packages.confluent.io/maven"}

download_file_using_python() {
    local DOWNLOAD_FILE="$1"
    local DOWNLOAD_URL="$2"

    python -c "
import sys, requests

def download_file(url, local_filename):
    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)

if len(sys.argv) != 3:
    print('Usage: python -c \"<script>\" <url> <local_filename>')
    sys.exit(1)

url = sys.argv[1]
local_filename = sys.argv[2]

download_file(local_filename, url)
" $DOWNLOAD_FILE $DOWNLOAD_URL
}

maven_dep() {
    local REPO="$1"
    local MVN_COORDS="$2"
    local MAVEN_DEP_DESTINATION="$3"
    local DOWNLOAD_STRATEGY="${4:-curl}"

    case $DOWNLOAD_STRATEGY in
        "python" ) shift
            pip install requests
    esac

    # Set IFS to a comma
    IFS=','

    for mvn_coord in $MVN_COORDS;
    do
      local MVN_COORD=$mvn_coord

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
      
      case $DOWNLOAD_STRATEGY in
        "curl" )
            curl -sfSL -o "$DOWNLOAD_FILE" "$DOWNLOAD_URL" || true
            ;;
        "wget" )
            wget -q --show-progress --no-check-certificate -O "$DOWNLOAD_FILE" "$DOWNLOAD_URL" || true
            ;;            
        "python" )
            download_file_using_python "$DOWNLOAD_FILE" "$DOWNLOAD_URL" || true
            ;;
      esac

      mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION || true
    done
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

