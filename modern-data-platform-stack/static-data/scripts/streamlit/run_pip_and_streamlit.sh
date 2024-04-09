#!/bin/sh

apt update

pip3 install --upgrade pip
pip3 install --no-cache-dir streamlit

if [ -z "$2" ]
then
  echo "No requirements.txt file configured, skipping PIP install phase!"
else
  pip3 install --upgrade pip
  pip3 install --no-cache-dir -r $2
fi

if [ -z "$1" ]
then
  echo "No streamlit application provided!"
  exit 2
else
  streamlit run $1
fi  
