#!/bin/bash
# generate-no-proxy.sh
COMPOSE_FILE=${1:-docker-compose.yml}
SUBNET=${2:-10.89.0.0/16}

# Try docker compose or podman compose (both support config --services)
SERVICES=""
if docker compose version &>/dev/null 2>&1; then
    SERVICES=$(docker compose -f "$COMPOSE_FILE" config --services 2>/dev/null | tr '\n' ',' | sed 's/,$//')
elif podman-compose version &>/dev/null 2>&1; then
    SERVICES=$(podman-compose -f "$COMPOSE_FILE" config --services 2>/dev/null | tr '\n' ',' | sed 's/,$//')
fi

# Fallback: parse YAML directly with awk
if [ -z "$SERVICES" ]; then
    SERVICES=$(awk '/^services:/{f=1;next} f && /^[^ ]/{f=0} f && /^  [a-zA-Z0-9_-]+:/{line=substr($0,3); print substr(line,1,index(line,":")-1)}' "$COMPOSE_FILE" | tr '\n' ',' | sed 's/,$//')
fi

export NO_PROXY="localhost,127.0.0.1,${SUBNET},${SERVICES}"
export no_proxy="$NO_PROXY"

echo "NO_PROXY=$NO_PROXY"
echo "no_proxy=$no_proxy"
