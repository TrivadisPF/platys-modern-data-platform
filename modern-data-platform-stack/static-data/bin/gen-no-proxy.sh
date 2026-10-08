#!/bin/bash
# generate-no-proxy.sh
COMPOSE_FILE=${1:-docker-compose.yml}
SUBNET=${2:-10.89.0.0/16}

SERVICES=$(yq '.services | keys | .[]' "$COMPOSE_FILE" | tr '\n' ',' | sed 's/,$//')

export NO_PROXY="localhost,127.0.0.1,${SUBNET},${SERVICES}"
export no_proxy="$NO_PROXY"

echo "NO_PROXY=$NO_PROXY"
echo "no_proxy=$no_proxy"
