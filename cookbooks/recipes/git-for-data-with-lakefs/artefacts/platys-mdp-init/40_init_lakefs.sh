#!/usr/bin/env bash

if [ -z "$LAKEFS_URL" ]; then
    echo "Skipping LakeFS Provisioning, as LAKEFS_URL is not set!"
else
    # Set json data directory
    json_data_dir="$(dirname "${BASH_SOURCE[0]}")/lakefs"

    # Wait for LakeFS to become available
    wait4x http $LAKEFS_URL/api/v1/healthcheck --insecure-skip-tls-verify --timeout 60s --interval 5s

    echo ""
    echo "*****************************************************"
    echo "Provisioning LakeFS  ..... "
    echo "*****************************************************"
    echo ""

    # Create initial user and credentials in LakeFS 
    ./lakefs-api.sh $LAKEFS_URL "" "" POST setup_lakefs $json_data_dir/lakefs-setup.json

    # Create the admin repository
    result=$(./lakefs-api.sh $LAKEFS_URL $LAKEFS_CREDENTIALS_ACCESS_KEY_ID $LAKEFS_CREDENTIALS_SECRET_ACCESS_KEY POST repositories $json_data_dir/admin-repository.json)
    echo $result

    # Create the demo data repository
    result=$(./lakefs-api.sh $LAKEFS_URL $LAKEFS_CREDENTIALS_ACCESS_KEY_ID $LAKEFS_CREDENTIALS_SECRET_ACCESS_KEY POST repositories $json_data_dir/demo-repository.json)
    echo $result

fi