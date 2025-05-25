#!/bin/sh

#mkdir -p /data-transfer/flight-data
cp -R /data/* /data-transfer

if [ -n "$ADDITIONAL_DATA_FOLDER" ]; then
  cp -R $ADDITIONAL_DATA_FOLDER/* /data-transfer
fi  