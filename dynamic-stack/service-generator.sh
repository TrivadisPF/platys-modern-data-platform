#!/bin/bash

args=("$@")
len=${#args[@]}

if [ $len = 3 ] #3 arguments are required
then
   docker run --rm -v ${args[0]}:/tmp/custom-values.yml -v ${args[1]}:/opt/analytics-generator/stacks  --user $(id -u):$(id -g) trivadis/modern-data-platform-stack-generator:${args[2]}
   # Remove all empty lines at the end of the file
   sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' ${args[1]}/**/docker-compose.yml
else
  echo "Usage : service-generator.sh [custom yml path] [output folder path]"
fi


