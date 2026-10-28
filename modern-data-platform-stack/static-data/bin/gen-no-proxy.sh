#!/bin/bash
# generate-no-proxy.sh
#
# DRY_RUN (default: true) only echoes the computed NO_PROXY values.
# Set it to false to actually write them to the .env file, e.g.:
#   DRY_RUN=false ./gen-no-proxy.sh
#   ./gen-no-proxy.sh docker-compose.yml 10.89.0.0/16 .env false
COMPOSE_FILE=${1:-docker-compose.yml}
SUBNET=${2:-10.89.0.0/16}
ENV_FILE=${3:-.env}
DRY_RUN=${4:-${DRY_RUN:-true}}

# Lists the services of the compose file, including the ones behind a profile.
# Instead of relying on the '--profile "*"' wildcard (not supported by all compose
# implementations), every profile found in the file is activated explicitly.
# Usage: list_services <compose command>   e.g. list_services docker compose
list_services() {
    local profile_args=()
    local profile
    while IFS= read -r profile; do
        [ -n "$profile" ] && profile_args+=(--profile "$profile")
    done < <("$@" -f "$COMPOSE_FILE" config --profiles 2>/dev/null)
    "$@" "${profile_args[@]}" -f "$COMPOSE_FILE" config --services 2>/dev/null | tr '\n' ',' | sed 's/,$//'
}

# Try docker compose or podman compose (both support config --services)
SERVICES=""
if docker compose version &>/dev/null 2>&1; then
    SERVICES=$(list_services docker compose)
elif podman-compose version &>/dev/null 2>&1; then
    SERVICES=$(list_services podman-compose)
fi

# Fallback: parse YAML directly with awk
if [ -z "$SERVICES" ]; then
    SERVICES=$(awk '/^services:/{f=1;next} f && /^[^ ]/{f=0} f && /^  [a-zA-Z0-9_-]+:/{line=substr($0,3); print substr(line,1,index(line,":")-1)}' "$COMPOSE_FILE" | tr '\n' ',' | sed 's/,$//')
fi

NO_PROXY="localhost,127.0.0.1,${PUBLIC_IP},${DOCKER_HOST_IP},${SUBNET},${SERVICES}"
no_proxy=$NO_PROXY

if [ "$DRY_RUN" = "true" ]; then
    echo "[dry-run] would write to $ENV_FILE (set NO_PROXY_DRY_RUN=false or pass 'false' as 4th arg to write):"
    echo "NO_PROXY=$NO_PROXY"
    echo "no_proxy=$NO_PROXY"
else
    # Make sure the .env file exists
    touch "$ENV_FILE"

    # Remove any existing NO_PROXY/no_proxy entries, then append the fresh ones
    sed -i '/^NO_PROXY=/d; /^no_proxy=/d' "$ENV_FILE"
    {
        echo "NO_PROXY=$NO_PROXY"
        echo "no_proxy=$NO_PROXY"
    } >> "$ENV_FILE"

    echo "Wrote to $ENV_FILE:"
    echo "NO_PROXY=$NO_PROXY"
    echo "no_proxy=$NO_PROXY"

fi

