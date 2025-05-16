#!/bin/sh

while [ $# -gt 0 ]; do
  case "$1" in
    --requirement-file)
      requirements_file="$2"
      shift 2
      ;;
    --python-script)
      python_script="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter: $1"
      exit 1
      ;;
  esac
done

apk update

if [ -z "$requirements_file" ]
then
  echo "No requirements.txt file configured, skipping PIP install phase!"
else
  pip3 install --upgrade pip
  pip3 install --no-cache-dir -r $requirements_file
fi

if [ -z "$python_script" ]
then
  echo "No python script configured, just starting the python container without running an application!"
else
  python $python_script
fi  

sleep infinity