#!/usr/bin/env bash

# Set json data directory
json_data_dir="$(dirname "${BASH_SOURCE[0]}")/nifi"

# Wait for LakeFS to become available
wait4x http $MINIO_URL/minio/health/live --insecure-skip-tls-verify --timeout 240s --interval 5s

echo ""
echo "*****************************************************"
echo "Provisioning Buckets  ..... "
echo "*****************************************************"
echo ""

## other parameters: --with-versioning --with-lock
mc mb --ignore-existing minio-1/lakefs-admin-bucket
mc tag set minio-1/lakefs-admin-bucket "app=admin"

mc mb --ignore-existing minio-1/lakefs-demo-bucket
mc tag set minio-1/lakefs-demo-bucket "app=demo"
