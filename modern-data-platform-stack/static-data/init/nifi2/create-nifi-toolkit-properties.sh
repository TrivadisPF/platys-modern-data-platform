#!/bin/bash

# Input and output files
INPUT_FILE="/opt/nifi/nifi-current/conf/nifi.properties"
OUTPUT_FILE="/opt/nifi/nifi-current/conf/nifi-toolkit.properties"

# Define the keys to include and their transformations
declare -A KEYS_TO_INCLUDE=(
  ["server.host"]="baseUrl"
  ["nifi.security.keystore"]="keystore"
  ["nifi.security.keystoreType"]="keystoreType"
  ["nifi.security.keystorePasswd"]="keystorePasswd"  
  ["nifi.security.keyPasswd"]="keyPasswd"  
  ["nifi.security.truststore"]="truststore"  
  ["nifi.security.truststoreType"]="truststoreType"  
  ["nifi.security.truststorePasswd"]="truststorePasswd"  
)

# Fixed entry to add to the output file
FIXED_ENTRY="baseUrl=https://nifi2-1:18083/nifi-api"

# Initialize the output file
: > "$OUTPUT_FILE"

# Add the fixed entry
echo "$FIXED_ENTRY" >> "$OUTPUT_FILE"

# Process the input file
while IFS= read -r line; do
  # Skip empty lines or comments
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  # Extract key and value
  key=$(echo "$line" | cut -d'=' -f1)
  value=$(echo "$line" | cut -d'=' -f2-)

  # Check if the key is in the inclusion list
  if [[ -v KEYS_TO_INCLUDE["$key"] ]]; then
    # Transform the key and write to output file
    echo "${KEYS_TO_INCLUDE[$key]}=$value" >> "$OUTPUT_FILE"
  fi
done < "$INPUT_FILE"
