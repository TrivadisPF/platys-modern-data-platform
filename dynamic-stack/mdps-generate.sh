#!/bin/bash

usage="Trivadis Modern Data Platform Stack Generator v1.0.0

Usage: $(basename "$0") [-h] [-d|--debug] [-cf|--configfile FILE] [-cr|--configref URL] [-o |--output PATH] [-v]--version version-number]

generates the Docker-Compose stack

    -h  	show this help text
    -cf  	path to a local config file
    -cr		URL of a remote config file 
    -o 		path where the generator output should be placed in
    -v  	version of the generator to use
    -d 		add extra debug (verbose) output"
		
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "$usage"
    exit
    ;;
    -cf|--configfile)
    CONFIG_FILE="$2"
    shift # past argument
    shift # past value
    ;;
    -cr|--configref)
    CONFIG_REF="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    OUTPUT="$2"
    shift # past argument
    shift # past value
    ;;
    -v|--version)
    VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--debug)
    DEBUG=1
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac	
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo "Running the Modern Data Platform Stack Generator ...."

if [ ${DEBUG:-0} -eq 1 ] 
then
   echo "configfile  = ${CONFIG_FILE}"
   echo "configref   = ${CONFIG_REF}"
   echo "output      = ${OUTPUT}"
   echo "version     = ${VERSION}"
fi

# check if the output folder exists, if not create it
if [ ! -d "${OUTPUT}" ]
then
   mkdir "${OUTPUT}"
fi   
   
docker run --rm -v "${CONFIG_FILE}":/tmp/filebased-custom-values.yml -v "${OUTPUT}":/opt/analytics-generator/stacks -e CONFIG_REF="${CONFIG_REF}" -e DEBUG="${DEBUG}" --user $(id -u):$(id -g) trivadis/modern-data-platform-stack-generator:"${VERSION:-LATEST}"

echo "Modern Data Platform Stack generated successfully to ${args[1]}"


