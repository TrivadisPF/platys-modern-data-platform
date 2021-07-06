#!/bin/bash
# Pre-runner for Data Collector.
# Restores registration
# Installs any missing stage libraries

echo
echo "$(date -Iseconds) Entering: $0"
echo
set -e

# Install dockerize
DOCKERIZE_VERSION=v0.6.1
wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && sudo tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && sudo rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Install SDC sample pipelines
if [ -z "${SDC_INSTALL_PIPELINES_FROM}" ]
then
  echo "INFO: No sample pipelines to install.  SDC_INSTALL_PIPELINES_FROM not configured."
elif [ ! -d "${SDC_INSTALL_PIPELINES_FROM}" ]
then
  echo "ERROR: SDC_INSTALL_PIPELINES_FROM did not specify a folder.  SDC_INSTALL_PIPELINES_FROM=${SDC_INSTALL_PIPELINES_FROM}"
else
  echo "Installing sample pipelines ${SDC_INSTALL_PIPELINES_FROM}/*"
  # Recurse.  And do not copy if the file is older.
  cp -r -u "${SDC_INSTALL_PIPELINES_FROM}"/* "${SDC_DIST}/samplePipelines/"
fi

# Prepare the working folder
rm -fr /tmp/libraries-extracted
mkdir -p /tmp/libraries-extracted # Temporary path to extract files into

BASE_URL=https://archives.streamsets.com/datacollector
SDC_VERSION=${SDC_VERSION:=${SDC_DIST##*-}}  # If SDC_VERSION is not specified then extract it from the path

echo
if [ -z "${SDC_INSTALL_STAGES}" ]
then
  echo "INFO: No stages to install.  SDC_INSTALL_STAGES not configured."
else
  echo "Installing stages specified by environment variable SDC_INSTALL_STAGES"
  echo ---------------------------

  for stage in ${SDC_INSTALL_STAGES//[,;]/ }
  do
    if [ ! -d "${SDC_DIST}/streamsets-libs/${stage}" ]
    then
      echo "Installing stage library ${stage}"
      if [ -d /tmp/sdc_stagecache -a ! -f /tmp/sdc_stagecache/${stage}-${SDC_VERSION}.tgz ]
      then
        # Cache directory exists and this stage isn't there.  Download it.
        echo "...Downloading to cache and then installing"
        wget -q -T 30 -O /tmp/sdc_stagecache/${stage}-${SDC_VERSION}.tgz ${BASE_URL}/${SDC_VERSION}/tarball/${stage}-${SDC_VERSION}.tgz
      fi
      if [ -d /tmp/sdc_stagecache -a -f /tmp/sdc_stagecache/${stage}-${SDC_VERSION}.tgz ]
      then
        # Cache directory exists and this stage is there.  Use the cache.
        tar -xzf /tmp/sdc_stagecache/${stage}-${SDC_VERSION}.tgz -C /tmp/libraries-extracted
      else
        # Download and extract at the same time
        wget -q -T 30 -O - ${BASE_URL}/${SDC_VERSION}/tarball/${stage}-${SDC_VERSION}.tgz | tar -xz -C /tmp/libraries-extracted
      fi
      mv /tmp/libraries-extracted/streamsets-datacollector-*/streamsets-libs/* "${SDC_DIST}/streamsets-libs/" || true # Will not overwrite and will ignore errors
    else
      echo "Stage already installed ${stage}"
    fi
  done
  echo
fi

echo
if [ -z "${SDC_INSTALL_ENTERPRISE_STAGES}" ]
then
  echo "INFO: No enterprise stages to install.  SDC_INSTALL_ENTERPRISE_STAGES not configured."
else
  echo "Installing enterprise stages specified by environment variable SDC_INSTALL_ENTERPRISE_STAGES"
  echo ---------------------------
  for stage in ${SDC_INSTALL_ENTERPRISE_STAGES//[,;]/ }
  do
    stage_without_version=${stage%-*}
    if [ ! -d "${SDC_DIST}/streamsets-libs/${stage_without_version}" ]
    then
      echo "Installing enterprise stage library ${stage}"
      if [ -d /tmp/sdc_stagecache -a ! -f /tmp/sdc_stagecache/${stage}.tgz ]
      then
        # Cache directory exists and this stage isn't there.  Download it.
        echo "...Downloading to cache and then installing"
        wget -q -T 30 -O /tmp/sdc_stagecache/${stage}.tgz ${BASE_URL}/latest/tarball/enterprise/${stage}.tgz
      fi
      if [ -d /tmp/sdc_stagecache -a -f /tmp/sdc_stagecache/${stage}.tgz ]
      then
        # Cache directory exists and this stage is there.  Use the cache.
        tar -xzf /tmp/sdc_stagecache/${stage}.tgz -C /tmp/libraries-extracted
      else
        # Download and extract at the same time
        wget -q -T 30 -O - ${BASE_URL}/latest/tarball/enterprise/${stage}.tgz | tar -xz -C /tmp/libraries-extracted
      fi
      mv /tmp/libraries-extracted/streamsets-libs/* "${SDC_DIST}/streamsets-libs/" || true # Will not overwrite and will ignore errors
    else
      echo "Stage already installed ${stage}"
    fi
  done
fi

echo
echo 'List of stages installed in ${SDC_DIST}/streamsets-libs'
ls -l "${SDC_DIST}/streamsets-libs"
echo


# We translate environment variables to sdc.properties and rewrite them.
set_dpm_conf() {
  if [ $# -ne 2 ]; then
    echo "set_conf requires two arguments: <key> <value>"
    exit 1
  fi

  if [ -z "$SDC_CONF" ]; then
    echo "SDC_CONF is not set."
    exit 1
  fi

  grep -q "^$1" ${SDC_CONF}/dpm.properties && sed 's|^#\?\('"$1"'=\).*|\1'"$2"'|' -i ${SDC_CONF}/dpm.properties || echo -e "\n$1=$2" >> ${SDC_CONF}/dpm.properties
}

for e in $(env); do
  key=${e%=*}
  value=${e#*=}
  if [[ $key == DPM_CONF_* ]]; then
    lowercase=$(echo $key | tr '[:upper:]' '[:lower:]')
    key=$(echo ${lowercase#*dpm_conf_} | sed 's|_|.|g')
    set_dpm_conf $key $value
  fi
done

#if [ ! -z "${SCH_REGISTRATION_URL}" ]
#then
#  SCH_REGISTRATION_URL
#  SCH_AUTHENTICATION_TOKEN
#  SCH_SDC_INSTANCE_ID
#fi

if [ -n "${PLATYS_SDC_ID}" ]
then
    echo 'write the configured SDC_ID (${PLATYS_SDC_ID}) to the sdc.id file'
	echo "${PLATYS_SDC_ID}" > $SDC_DATA/sdc.id
fi

echo "$(date -Iseconds) Exiting: $0"
exec /docker-entrypoint.sh "$@"
