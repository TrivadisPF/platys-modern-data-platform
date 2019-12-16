#!/bin/bash

args=("$@")
len=${#args[@]}

if [ $len = 3 ] #3 arguments are required
then
   echo "Running the Modern Data Platform Stack Generator ...."
   docker run --rm -v ${args[0]}:/tmp/custom-values.yml -v ${args[1]}:/opt/analytics-generator/stacks  --user $(id -u):$(id -g) trivadis/modern-data-platform-stack-generator:${args[2]}
   # Remove all empty lines at the end of the file
   sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' ${args[1]}/docker-compose.yml
   echo "Modern Data Platform Stack generated successfully to ${args[1]}"
else
  echo "mdps-generate version 1.0.0"
  echo "Run the Modern Data Platform Stack Generator."
  echo ""  
  echo "Usage: "
  echo "  mdps-generate [custom yml folder path] [output folder path] [mdp stack version]"
fi


