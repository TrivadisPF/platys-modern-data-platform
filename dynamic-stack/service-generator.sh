#!/bin/bash

args=("$@")
len=${#args[@]}

if [ $len = 2 ] #2 arguments are required
then
   docker run --rm -v ${args[0]}:/tmp/custom-values.yml -v ${args[1]}:/opt/analytics-generator/stacks tvd/modern-data-analytics-stack-generator:1.0
else
  echo "Usage : service-generator.sh [stack yml path] [output folder path]"
fi


