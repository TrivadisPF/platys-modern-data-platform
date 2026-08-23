#!/bin/bash

#
# Download connector maven dependencies
#
# Params: 
#     - Repository (central or confluent or nexus)
#     - Maven Coordiantes
#     - Download destination
#     - Download strategy (using curl, wget, python or coursier)
# Author: Guido Schmutz <https://github.com/gschmutz>
#
set -e

# If there's not maven repository url set externally,
# default to the ones below
MAVEN_DOWNLOAD_REPO_CENTRAL=${MAVEN_DOWNLOAD_REPO_CENTRAL:-"https://repo1.maven.org/maven2"}
MAVEN_DOWNLOAD_REPO_CONFLUENT=${MAVEN_DOWNLOAD_REPO_CONFLUENT:-"https://packages.confluent.io/maven"}
# Set MAVEN_DOWNLOAD_REPO_NEXUS to your Nexus repository URL, e.g.:
#   MAVEN_DOWNLOAD_REPO_NEXUS=http://nexus:8081/repository/maven-public
MAVEN_DOWNLOAD_REPO_NEXUS=${MAVEN_DOWNLOAD_REPO_NEXUS:-""}
MAVEN_DOWNLOAD_REPO_NEXUS_USER=${MAVEN_DOWNLOAD_REPO_NEXUS_USER:-""}
MAVEN_DOWNLOAD_REPO_NEXUS_PASSWORD=${MAVEN_DOWNLOAD_REPO_NEXUS_PASSWORD:-""}

download_file_using_python() {
    local DOWNLOAD_FILE="$1"
    local DOWNLOAD_URL="$2"
    local AUTH_USER="${3:-}"
    local AUTH_PASS="${4:-}"

    python3 -c "
import sys, os, requests

def download_file(url, local_filename, user=None, password=None):
    auth = (user, password) if user else None
    with requests.get(url, stream=True, auth=auth) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)

url           = sys.argv[1]
local_filename = sys.argv[2]
user          = sys.argv[3] if len(sys.argv) > 3 and sys.argv[3] else None
password      = sys.argv[4] if len(sys.argv) > 4 and sys.argv[4] else None

download_file(url, local_filename, user, password)
" "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$AUTH_USER" "$AUTH_PASS"
}

maven_dep() {
    local REPO="$1"
    local MVN_COORDS="$2"
    local MAVEN_DEP_DESTINATION="$3"
    local DOWNLOAD_STRATEGY="${4:-curl}"
    local AUTH_USER="${5:-}"
    local AUTH_PASS="${6:-}"

    case $DOWNLOAD_STRATEGY in
        "python" )
            pip install requests
            ;;
        "coursier" )
            curl -fLo cs https://git.io/coursier-cli-linux && chmod +x cs
            ;;
    esac

    # Set IFS to a comma
    IFS=','

    for mvn_coord in $MVN_COORDS;
    do
      [ -z "$mvn_coord" ] && continue
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
            mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION || true
            ;;
        "wget" )
            wget -q --show-progress --no-check-certificate -O "$DOWNLOAD_FILE" "$DOWNLOAD_URL" || true
            mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION || true
            ;;
        "python" )
            download_file_using_python "$DOWNLOAD_FILE" "$DOWNLOAD_URL" "$AUTH_USER" "$AUTH_PASS" || true
            mv "$DOWNLOAD_FILE" $MAVEN_DEP_DESTINATION || true
            ;;
        "coursier" )
            ./cs fetch --repository https://packages.confluent.io/maven/ --classpath $MVN_COORD | tr ':' '\n' | xargs -I {} cp {} $MAVEN_DEP_DESTINATION || true
            ;;
      esac

    done
}

maven_central_dep() {
    maven_dep $MAVEN_DOWNLOAD_REPO_CENTRAL $1 $2 $3 $4
}

maven_confluent_dep() {
    maven_dep $MAVEN_DOWNLOAD_REPO_CONFLUENT $1 $2 $3 $4
}

maven_nexus_dep() {
    if [ -z "$MAVEN_DOWNLOAD_REPO_NEXUS" ]; then
        echo "ERROR: MAVEN_DOWNLOAD_REPO_NEXUS is not set" >&2
        exit 1
    fi
    maven_dep "$MAVEN_DOWNLOAD_REPO_NEXUS" "$1" "$2" "${3:-python}" "$MAVEN_DOWNLOAD_REPO_NEXUS_USER" "$MAVEN_DOWNLOAD_REPO_NEXUS_PASSWORD"
}

case $1 in
    "central" ) shift
            maven_central_dep ${@}
            ;;
    "confluent" ) shift
            maven_confluent_dep ${@}
            ;;
    "nexus" ) shift
            maven_nexus_dep ${@}
            ;;
esac

