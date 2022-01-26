#!/bin/sh

apt update

if [ -z "$2" ]
then
  echo "No requirements.txt file configured, skipping PIP install phase!"
else
  pip3 install --upgrade pip
  pip3 install --no-cache-dir -r $2
fi

if [ -z "$1" ]
then
  echo "No python script configured, just running python without an application!"
  python
else
  python $1
fi  
