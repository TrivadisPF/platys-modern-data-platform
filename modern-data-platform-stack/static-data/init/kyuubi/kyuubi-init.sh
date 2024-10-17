#!/bin/bash

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

function configure_spark() {
    local path=$1
    local envPrefix=$2

    local var
    local value

    echo "Configuring Spark"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/--/g;  s/_/./g; s/--/_/g;'`        
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addProperty $path $name "$value"
    done
}

function configure_kyuubi() {
    local path=$1
    local envPrefix=$2

    local var
    local value

    echo "Configuring Kyuubi"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/--/g;  s/_/./g; s/--/_/g;'`        
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addProperty $path $name "$value"
    done
}

function configure_hive() {
    local path=$1
    local envPrefix=$2

    local var
    local value

    echo "Configuring Hive"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/_/g; s/_/./g'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addElement $path $name "$value"
    done
}

configure_hive ${KYUUBI_HOME}/conf/hive-site.xml HIVE_SITE_CONF
configure_spark ${KYUUBI_HOME}/conf/spark-defaults.conf SPARK_DEFAULTS_CONF
configure_kyuubi ${KYUUBI_HOME}/conf/kyuubi-defaults.conf KYUUBI_DEFAULTS_CONF

function wait_for_it()
{
    local serviceport=$1
    local service=${serviceport%%:*}
    local port=${serviceport#*:}
    local retry_seconds=5
    local max_try=100
    let i=1

    nc -z $service $port
    result=$?

    until [ $result -eq 0 ]; do
      echo "[$i/$max_try] check for ${service}:${port}..."
      echo "[$i/$max_try] ${service}:${port} is not available yet"
      if (( $i == $max_try )); then
        echo "[$i/$max_try] ${service}:${port} is still not available; giving up after ${max_try} tries. :/"
        exit 1
      fi

      echo "[$i/$max_try] try in ${retry_seconds}s once again ..."
      let "i++"
      sleep $retry_seconds

      nc -z $service $port
      result=$?
    done
    echo "[$i/$max_try] $service:${port} is available."
}

for i in ${SERVICE_PRECONDITION[@]}
do
    wait_for_it ${i}
done

if [ ${SPARK_INSTALL_JARS_PACKAGES} ]
then
  # navigate into the spark folder
  cd ${KYUUBI_HOME}/externals/spark*
  /maven-download.sh central ${SPARK_INSTALL_JARS_PACKAGES} ./jars
  cd
fi  

exec $@
