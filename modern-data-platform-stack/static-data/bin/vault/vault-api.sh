#!/usr/bin/env bash

# Check if at least 5 arguments are passed
if [ $# -lt 5 ]
then
  echo "Usage: vault-api <vaultBaseUrl> <username> <password> <method> <resource>"
  echo "       vaultBaseUrl: the base URL of the Vault server as http(s)://<host:port>"
  echo "       method: POST | PUT | GET"
  echo "       resource: the resource to invoke, do not prefix it with /"
  exit 1
fi

# Assign arguments to variables for better readability
vaultBaseUrl=$1
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
token=$(curl -k $vaultBaseUrl/v1/auth/userpass/login/$username --data  "{\"password\": \"$password\"}" --insecure --silent | jq -r .auth.client_token)

# Check if token retrieval was successful
if [ -z "$token" ]; then
  echo "Error: Failed to retrieve authentication token."
  exit 1
fi

# Prepare the curl command dynamically based on the method
if [ "$method" == "GET" ]; then
  curl -X GET -H "X-Vault-Token: $token" --insecure --silent -k $vaultBaseUrl/v1/$resource
else
  dataFile=$6
  if [ -z "$dataFile" ]; then
    echo "Error: Data file must be provided as the 6th argument for $method request."
    exit 1
  fi

  # Check if the specified data file exists
  if [ ! -f "$dataFile" ]; then
    echo "Error: '$dataFile' file not found for $method request."
    exit 1
  fi

  envsubst < $dataFile > temp.json
  curl -X $method -H "X-Vault-Token: $token" -H "Content-Type: application/json" -d @temp.json --insecure --silent -k $vaultBaseUrl/v1/$resource
fi