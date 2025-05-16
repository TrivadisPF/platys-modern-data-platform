#!/bin/bash

# Set some sensible defaults
export CORE_CONF_fs_defaultFS=${CORE_CONF_fs_defaultFS:-hdfs://`hostname -f`:8020}

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
    local module=$2
    local envPrefix=$3

    local var
    local value

    echo "Configuring $module"
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

function configure() {
    local path=$1
    local module=$2
    local envPrefix=$3

    local var
    local value

    echo "Configuring $module"
    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do
        name=`echo ${c} | perl -pe 's/___/-/g; s/__/@/g; s/_/./g; s/@/_/g;'`
        var="${envPrefix}_${c}"
        value=${!var}
        echo " - Setting $name=$value"
        addElement /etc/hadoop/$module-site.xml $name "$value"
    done
}

function replace_env_config_if_not_exists {
  local conf_name=$1
  local envs_to_replace=$2
  if [ ! -r conf/$conf_name ]; then
    echo "$conf_name does not exist, creating it"
    envsubst $envs_to_replace < conf.templates/$conf_name.template > conf/$conf_name
  else
    echo "$conf_name already exists, not overwriting"
  fi
}

function replace_env_config {
  local conf_name=$1
  local envs_to_replace=$2
  echo "creating $conf_name"
  #envsubst $envs_to_replace < conf.templates/$conf_name.template > conf/$conf_name
  python -c 'import os,sys; sys.stdout.write(os.path.expandvars(sys.stdin.read()))' < conf.templates/$conf_name.template > conf/$conf_name
}

replace_env_config zeppelin-env.sh
replace_env_config zeppelin-site.xml
replace_env_config shiro.ini '$ZEPPELIN_ADMIN_USERNAME,$ZEPPELIN_ADMIN_PASSWORD,$ZEPPELIN_USER_USERNAME,$ZEPPELIN_USER_PASSWORD'

perl -pe 's/\$\{(\w+)\}/$ENV{$1}/g' < /root/.s3cfg.template > /root/.s3cfg

if [ ${SPARK_INSTALL_JARS_PACKAGES} ]
then
  /maven-download.sh central ${SPARK_INSTALL_JARS_PACKAGES} /spark/jars
fi

source /opt/conda/etc/profile.d/conda.sh
conda activate python_312_with_R
conda env list  

exec $@
