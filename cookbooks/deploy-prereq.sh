#!/bin/bash

export PLATYS_PLATFORM_HOME=/home/docker/platys-tkse

wget https://www.dropbox.com/s/wyplr5v2zt0k3b8/flight-data.zip?dl=0 -O flight-data.zip

unzip flight-data.zip
rm flight-data.zip

rm -fR $PLATYS_PLATFORM_HOME/data-transfer/samples/flight-data
mv flight-data $PLATYS_PLATFORM_HOME/data-transfer/samples/