#!/bin/bash

version="Trivadis Docker-based Modern Data Platform Generator v2.0.0"
usage="${version}

Usage: $(basename "$0") [-h] [-d|--debug] [-cf|--configfile FILE] [-cr|--configref URL] [-o |--output PATH] [-t]--tag TAG]

generates the Docker-Compose stack

    -h      display this help text
    -v      display version of the docker-based platform generator
    -cf     path to a local config file
    -cr     URL of a remote config file 
    -o      path where the generator output should be placed in
    -t      the container tag (version) for the modern data platform stack to use
    -d      add extra debug (verbose) output"
		
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "$usage"
    exit
    ;;
    -v|--version)
    echo "$version"
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
    -t|--tag)
    TAG="$2"
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
   echo "tag         = ${TAG}"
fi

# check if the output folder exists, if not create it
if [ ! -d "${OUTPUT}" ]
then
   mkdir "${OUTPUT}"
fi   
   
docker run --rm -v "${CONFIG_FILE}":/tmp/filebased-custom-values.yml -v "${OUTPUT}":/opt/analytics-generator/stacks -e CONFIG_REF="${CONFIG_REF}" -e DEBUG="${DEBUG}" --user $(id -u):$(id -g) trivadis/modern-data-platform-stack-generator:"${TAG:-LATEST}"

echo "Modern Data Platform Stack generated successfully to ${args[1]}"


