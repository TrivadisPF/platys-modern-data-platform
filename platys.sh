#!/bin/bash

version="A toolset for provisioning Modern Platforms - v2.0.0"

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

  The stack to use as well as its version need to be passed by the --stack-name 
  and --stack-version options. By default 'config.yml' is
  used for the name of the config file, which is created by the init.

Options:
  -n, --platform-name TEXT     the name of the platform stack to generate.
                               [required]
  -in, --stack-name TEXT       the modern data platform stack image  [default:
                               trivadis/modern-data-platform-stack-generator]
  -iv, --stack-version TEXT    the modern data platform stack image version to
                               use  [default: latest]
  -sc, --seed-config TEXT      the name of a predefined stack to base this new
                               platform on
  -f, --force                  If specified, this command will overwrite any
                               existing config file
  -hw, --hw-arch [ARM|ARM64|x86-64]
                               Hardware architecture for the platform
  -h, --help                   Show this message and exit.
"

usageGen="${version}
Usage: $(basename "$0") gen [OPTIONS] 

  Generates a docker-based Modern Data Platform Stack.

  The stack configuration can either be passed as a local file (using the
  default file name 'config.yml') or as an URL referencing a file on the Internet 
  (using the --config-url option).

Options:

  -cu, --config-url TEXT          the URL to a remote config file
  --del-empty-lines / --no-del-emptylines
                                  remove empty lines from the docker-
                                  compose.yml file.  [default: True]
  --flat                          generate the stack into same folder as
                                  config.yml
  --subfolder                     generate the stack into a subfolder, which
                                  by default is the name of the platform
                                  provided when initializing the stack
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
    -sn|--stack-name)
    STACK_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -sv|--stack-version)
    STACK_VERSION="$2"
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
    -sc|--seed-config)
    SEED_CONFIG="$2"
    shift # past argument
    shift # past value
    ;;
    -hw|--hw-arch)
    HW_ARCH="$2"
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

   # in the Python implementation, this should be read from the config.yml file
   source ${context_file}

   if [ ${VERBOSE:-0} -eq 1 ] 
   then
      echo "stack-name = $stack_name"
      echo "stack-version = $stack_name"
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
	echo "Running container with this docker cmd:" docker run --rm -v "${PWD}":/opt/mdps-gen/stack-config -v "${destination}":/opt/mdps-gen/destination -e CONFIG_URL="${CONFIG_URL}" -e VERBOSE="${VERBOSE}" --user $(id -u):$(id -g) "${stack_name:-trivadis/platys-modern-data-platform}":"${stack_version:-1.2.0}"
   fi

   docker run --rm -v "${PWD}":/opt/mdps-gen/conf -v "${destination}":/opt/mdps-gen/destination -e CONFIG_URL="${CONFIG_URL}" -e VERBOSE="${VERBOSE}" --user $(id -u):$(id -g) "${stack_name:-trivadis/platys-modern-data-platform}":"${stack_version:-1.2.0}"

   echo "Modern Data Platform Stack generated successfully to ${destination}"

elif [[ $POSITIONAL == "init" ]]
then
   stack_file=config.yml

   if [ ${VERBOSE:-0} -eq 1 ] 
   then
      echo "platform-name  = ${PLATFORM_NAME}"
      echo "platform-name  = ${PLATFORM_NAME}"
   fi

   if [ ! -e "${stack_file}" ]
   then
      echo "Initializing the Modern Data Platform Stack Generator ...."

      # in the python script, that should be copied out of the docker image (file default-values.yml)
      # (the header with stack_name and stack_version could already be in the file and does not have to be added)

      docker create --name cont1 "${STACK_NAME:-trivadis/platys-modern-data-platform}":"${STACK_VERSION:-1.2.0}"
      docker cp cont1:/opt/mdps-gen/vars/config.yml ${stack_file}
      docker rm cont1
 
      # in this PoC the data is also added to a INI formatted file, as I was not able to read the YML in the bash script with minimal invest
      echo -e "platform_name=${PLATFORM_NAME}\nstack_name=${STACK_NAME}\nstack_version=${STACK_VERSION}\n" >> ${context_file}
      
   else
      echo "A Data Platform Stack already exists in this folder ...."
   fi

fi

