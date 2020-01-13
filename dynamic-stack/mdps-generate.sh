#!/bin/bash

version="Trivadis Docker-based Modern Data Platform Generator v2.0.0"

usage="
Usage: $(basename "$0") [OPTIONS] COMMAND [ARGS]... 

Options:
  --version       Show the version and exit.
  -h, --help      Show this message and exit.

Commands:
  init            Initializes a new docker-based Data Platform Stack.
  gen             Generates a docker-based Data Platform Stack.               
"

usageInit="
Usage: $(basename "$0") init [OPTIONS] 

  Initializes the current directory to be a Modern Data Platform Stack
  environment by creating an initial stack config file, if one does not
  already exists.

Options:
  -n, --platform-name TEXT        the name of the platform stack to generate.
                                  [required]
  -in, --stack-image-name TEXT    the modern data platform stack image
                                  [default: modern-data-platform-stack-
                                  generator]
  -iv, --stack-image-version TEXT
                                  the modern data platform stack image version
                                  to use  [default: LATEST]
  -cf, --config-filename TEXT     the name of the local config file.
                                  [default: stack-config.yml]
  -ps, --predef-stack-config TEXT
                                  the name of a predefined stack to base this
                                  new platform on
  -f, --force                     If specified, this command will overwrite
                                  any existing config file
  -h, --help                      Show this message and exit.
"

usageGen="${version}
Usage: $(basename "$0") gen [OPTIONS] 

  Generates a docker-based Modern Data Platform Stack.

  -cf, --config-filename TEXT     the name of the local config file.
                                  [default: stack-config.yml]
  -cu, --config-url TEXT          the URL to a remote config file
  --del-empty-lines / --no-del-emptylines
                                  remove empty lines from the docker-
                                  compose.yml file.  [default: True]
  --flat                          generate the stack into same folder as
                                  stack-config.yml
  --subfolder                     generate the stack into a subfolder, which
                                  by default is the name of the stack
  -v, --verbose                   Verbose logging  [default: False]
  -h, --help                      Show this message and exit.
"
		
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    if [[ $POSITIONAL == "gen" ]]
    then
       echo "$usageGen"
    elif [[ $POSITIONAL == "init" ]]
    then
       echo "$usageInit"
    else
       echo "$usage"
    fi
    exit
    ;;
    --version)
    echo "$version"
    exit
    ;;
    -n|--platform-name)
    PLATFORM_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -in|--stackimage-name)
    STACK_IMAGE_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -iv|--stackimage-version)
    STACK_IMAGE_VERSION="$2"
    shift # past argument
    shift # past value
    ;;
    -cf|--config-filename)
    CONFIG_FILENAME="$2"
    shift # past argument
    shift # past value
    ;;
    -cu|--config-url)
    CONFIG_URL="$2"
    shift # past argument
    shift # past value
    ;;
    -psc|--predef-stack-config)
    PREDEF_STACK_CONFIG="$2"
    shift # past argument
    shift # past value
    ;;
    -f|--force)
    FORCE=1
    shift # past argument
    ;;
    --flat)
    STRUCTURE="flat"
    shift # past argument
    ;;
    --subfolder)
    STRUCTURE="subfolder"
    shift # past argument
    ;;
    -v|--verbose)
    VERBOSE=1
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac	
done
set -- "${POSITIONAL[@]}" # restore positional parameters

context_file=context

if [[ $POSITIONAL == "gen" ]]
then

   echo "Running the Modern Data Platform Stack Generator ...."

   source ${context_file}

   if [ ${VERBOSE:-0} -eq 1 ] 
   then
      echo "config-filename     = ${CONFIG_FILENAME}"

      echo "stackimage-name = $stackimage_name"
      echo "stackimage-version = $stackimage_name"
      echo "platform-name = $platform_name"
   fi

   if [[ $STRUCTURE == "subfolder" ]]
   then
      # check if the output folder exists, if not create it
      if [ ! -d "${platform_name}" ]
      then
         mkdir "${platform_name}"
      fi
      destination="${PWD}/${platform_name}"
   else
      destination="${PWD}"
   fi   
    
   echo "Destination = ${destination}"

   if [ ${VERBOSE:-0} -eq 1 ] 
   then
	echo "Running container with this docker cmd:" docker run --rm -v "${PWD}":/opt/mdps-gen/stack-config -v "${destination}":/opt/mdps-gen/destination -e CONFIG_URL="${CONFIG_URL}" -e VERBOSE="${VERBOSE}" --user $(id -u):$(id -g) trivadis/"$stackimage_name":"${stackimage_version:-LATEST}"

   fi
   docker run --rm -v "${PWD}":/opt/mdps-gen/stack-config -v "${destination}":/opt/mdps-gen/destination -e CONFIG_URL="${CONFIG_URL}" -e VERBOSE="${VERBOSE}" --user $(id -u):$(id -g) trivadis/"$stackimage_name":"${stackimage_version:-LATEST}"

   echo "Modern Data Platform Stack generated successfully to ${args[1]}"

elif [[ $POSITIONAL == "init" ]]
then
   stack_file=stack-config.yml

   if [ ${VERBOSE:-0} -eq 1 ] 
   then
      echo "platform-name  = ${PLATFORM_NAME}"
      echo "platform-name  = ${PLATFORM_NAME}"
   fi

   if [ ! -e "${stack_file}" ]
   then
      echo "Initializing the Modern Data Platform Stack Generator ...."

      echo "# =============== Do to remove ==========================" >> ${stack_file}
      echo "# stackimage_name=${STACK_IMAGE_NAME}" >> ${stack_file}
      echo "# stackimage_version=${STACK_IMAGE_VERSION}" >> ${stack_file}
      echo "# =============== Do to remove ==========================" >> ${stack_file}
      echo "   stack_name: ${PLATFORM_NAME}" >> ${stack_file}
      echo "   stack_type: I86" >> ${stack_file}
      echo "   KAFKA_enable: TRUE" >> ${stack_file}

      echo -e "platform_name=${PLATFORM_NAME}\nstackimage_name=${STACK_IMAGE_NAME}\nstackimage_version=${STACK_IMAGE_VERSION}\n" >> ${context_file}
      
   else
      echo "A Data Platform Stack already exists in this folder ...."
   fi

fi
