#!/usr/bin/env bash

# Check if at least 5 arguments are passed
if [ $# -lt 5 ]
then
  echo "Usage: nifi-api <nifiBaseUrl> <username> <password> <method> <resource>"
  echo "       nifiBaseUrl: the base URL of the NiFi server as http(s)://<host:port>
  echo "       method: POST | PUT | GET"
  echo "       resource: name of the data jsonfile without the .json extension
  exit 1
fi

# Assign arguments to variables for better readability
nifiBaseUrl=$1
username=$2
password=$3
method=$4
resource=$5

# Validate the HTTP method
if [[ "$method" != "POST" && "$method" != "PUT" && "$method" != "GET" ]]; then
  echo "Error: Invalid method. Allowed methods are POST, PUT, or GET."
  exit 1
fi

# Get the authentication token
token=$(curl -k $nifiBaseUrl/nifi-api/access/token -d "username=$username&password=$password" --insecure)

# Check if token retrieval was successful
if [ -z "$token" ]; then
  echo "Error: Failed to retrieve authentication token."
  exit 1
fi

# Prepare the curl command dynamically based on the method
if [ "$method" == "GET" ]; then
  curl -X GET -H "Authorization: Bearer $token" --insecure -k https://$nifiBaseUrl/$resource
else
  dataFile=$6
  # POST and PUT require a data payload
  if [ ! -f "data.json" ]; then
    echo "Error: 'data.json' file not found for $method request."
    exit 1
  fi
  envsubst < $dataFile.json > temp.json
  curl -X $method -H "Authorization: Bearer $token" -H "Content-Type: application/json" -d @temp.json --insecure -k $nifiBaseUrl/nifi-api/$resource
fi