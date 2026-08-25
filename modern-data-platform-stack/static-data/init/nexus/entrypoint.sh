#!/bin/sh
set -e

ADMIN_PASS="${NEXUS_ADMIN_PASSWORD:-admin123}"
PASSWORD_FILE="/nexus-data/admin.password"
NEXUS_URL="http://localhost:8081"

# pre-seed password file on very first boot
if [ ! -f "${PASSWORD_FILE}" ] && [ ! -f "/nexus-data/.setup-complete" ]; then
  mkdir -p /nexus-data
  echo -n "${ADMIN_PASS}" > "${PASSWORD_FILE}"
  chown -R nexus:nexus /nexus-data
fi

/opt/sonatype/nexus/bin/nexus run &
NEXUS_PID=$!

echo "Waiting for Nexus to be writable..."
until curl -sf -u "admin:${ADMIN_PASS}" \
    "${NEXUS_URL}/service/rest/v1/status/writable" > /dev/null 2>&1; do
  sleep 5
done
echo "Nexus is up."

# only run setup once
if [ ! -f "/nexus-data/.setup-complete" ]; then

  # explicitly change password via API — this is what marks onboarding done
  curl -sf \
    -u "admin:${ADMIN_PASS}" \
    -X PUT "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password" \
    -H "Content-Type: text/plain" \
    -d "${ADMIN_PASS}"
  echo "Password set via API."

  # remove the seed file
  rm -f "${PASSWORD_FILE}"

  # disable anonymous access
  curl -sf \
    -u "admin:${ADMIN_PASS}" \
    -X PUT "${NEXUS_URL}/service/rest/v1/security/anonymous" \
    -H "Content-Type: application/json" \
    -d '{"enabled": false}' || true

  # create PyPI proxy repo
  curl -sf -o /dev/null \
    -u "admin:${ADMIN_PASS}" \
    -X POST "${NEXUS_URL}/service/rest/v1/repositories/pypi/proxy" \
    -H "Content-Type: application/json" \
    -d @/nexus-init/pypi-proxy.json || true

  # create PyPI proxy repo
  curl -sf -o /dev/null \
    -u "admin:${ADMIN_PASS}" \
    -X POST "${NEXUS_URL}/service/rest/v1/repositories/docker/proxy" \
    -H "Content-Type: application/json" \
    -d @/nexus-init/docker-proxy.json || true    

  # mark setup as done so restarts skip this block
  touch /nexus-data/.setup-complete
  echo "Setup complete."

fi

wait $NEXUS_PID