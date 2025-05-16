#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Load Spark environment settings
# /opt/bitnami/scripts/spark-env.sh

export KYUUBI_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"
export KYUUBI_DEFAULT_CONF_DIR="${KYUUBI_HOME}/conf.default"
export KYUUBI_CONF_DIR="${KYUUBI_HOME}/conf"
export SPARK_DEFAULT_CONF_DIR="${KYUUBI_HOME}/conf.default"
export SPARK_CONF_DIR="${KYUUBI_HOME}/conf"

# We add the copy from default config in the entrypoint to not break users 
# bypassing the setup.sh logic. If the file already exists do not overwrite (in
# case someone mounts a configuration file in /opt/kyuubi/spark/conf)
echo "Copying files from $KYUUBI_DEFAULT_CONF_DIR to $KYUUBI_CONF_DIR"
cp -nr "$KYUUBI_DEFAULT_CONF_DIR"/. "$KYUUBI_CONF_DIR"
echo "Copying files from $SPARK_DEFAULT_CONF_DIR to $SPARK_CONF_DIR"
cp -nr "$SPARK_DEFAULT_CONF_DIR"/. "$SPARK_CONF_DIR"


########################
# Run custom initialization scripts
# Globals:
#   SPARK_*
# Arguments:
#   None
# Returns:
#   None
#########################
kyuubi_custom_init_scripts() {
    if [[ -n $(find "${KYUUBI_INITSCRIPTS_DIR}/" -type f -regex ".*\.sh") ]]; then
        echo "Loading user's custom files from $KYUUBI_INITSCRIPTS_DIR ..."
        local -r tmp_file="/tmp/filelist"
        find "${KYUUBI_INITSCRIPTS_DIR}/" -type f -regex ".*\.sh" | sort >"$tmp_file"
        while read -r f; do
            case "$f" in
            *.sh)
                if [[ -x "$f" ]]; then
                    echo "Executing $f"
                    "$f"
                else
                    echo "Sourcing $f"
                    # shellcheck disable=SC1090
                    . "$f"
                fi
                ;;
            *)
                echo "Ignoring $f"
                ;;
            esac
        done <$tmp_file
        rm -f "$tmp_file"
    else
        echo "No custom scripts in $KYUUBI_INITSCRIPTS_DIR"
    fi
}

# Run custom initialization scripts
kyuubi_custom_init_scripts

./bin/kyuubi run