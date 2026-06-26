#!/usr/bin/env bash
INIT_DIR="/opt/sql-client/init"
HIVE_CONF_DIR="/opt/hive-conf"
HIVE_DEFAULT_CONF_DIR="/opt/hive-conf.default"

function addProperty() {
  local path=$1
  local name=$2
  local value=$3

  local entry="$name    ${value}"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/# >> END/ s/.*/${escapedEntry}\n&/" $path
}

function addElement() {
  local path=$1
  local name=$2
  local value=$3

  local entry="<property><name>$name</name><value>${value}</value></property>"
  local escapedEntry=$(echo $entry | sed 's/\//\\\//g')
  sed -i "/<\/configuration>/ s/.*/${escapedEntry}\n&/" $path
}
function configure_hive() {
    local path=$1
    local module=$2
    local envPrefix=$3

    local var
    local value

    echo "Configuring $module"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/_/g; s/_/./g'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addElement $path $name "$value"
    done
}

if [ ${FLINK_INSTALL_MAVEN_DEP} ]
then
  /platys-scripts/maven-download.sh central ${FLINK_INSTALL_MAVEN_DEP} /opt/flink/lib curl
fi

if [ ${FLINK_INSTALL_FILE_DEP} ]
then
  /platys-scripts/file-download.sh github ${FLINK_INSTALL_FILE_DEP} /opt/flink/lib
fi

# add python modules
if [ ${FLINK_PYTHON_PROVIDE_REQUIREMENTS_FILE} ]; then
  echo "install python modules"
  pip install -r /opt/flink/requirements.txt
fi

# Wait for metastore if we need to
METASTORE="${METASTORE_HOST}:${METASTORE_PORT}"
if [ "$METASTORE" != ":" ]; then

  echo "Copying files from $HIVE_DEFAULT_CONF_DIR to $HIVE_CONF_DIR"
  cp -nr "$HIVE_DEFAULT_CONF_DIR"/. "$HIVE_CONF_DIR"

  configure_hive $HIVE_CONF_DIR/hive-site.xml hive HIVE_SITE_CONF

  echo "Waiting for metastore to come up at " $METASTORE
  CONNECTED=false
  while ! $CONNECTED; do

    curl $METASTORE > /dev/null 2> /dev/null
    curlResult=$?

    # CURL code 52 means metastore is up
    if [ $curlResult == '52' ]; then
      CONNECTED=true
    fi

    echo "."
    sleep 1
  done;
  echo "Metastore is there!"
  
fi

chown -R flink:flink /opt/flink/lib

echo "Start initialization"
if [ -d "$INIT_DIR" ]; then
	echo "Init folder found at " $INIT_DIR
	for initfile in "$INIT_DIR"/*.sql; do
		echo "Running init file: " $initfile
		cat $initfile | /opt/sql-client/sql-client.sh
	done
else
	echo "No init folder found at " $INIT_DIR
fi
echo "Initialization finished"

if [ -z ${FLINK_DO_NOT_START} ]; then
	/docker-entrypoint.sh $@
else
	tail -f /dev/null
fi