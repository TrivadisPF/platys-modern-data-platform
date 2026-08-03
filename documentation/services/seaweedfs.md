# SeaweedFS

SeaweedFS is a simple and highly scalable distributed file system with an S3-compatible object storage API.

**[Website](https://seaweedfs.com)** | **[Documentation](https://github.com/seaweedfs/seaweedfs/wiki)**
| **[GitHub](https://github.com/seaweedfs/seaweedfs)**

## How to enable?

```bash
platys init --enable-services SEAWEEDFS
platys gen
```

## How to use it?

The S3 API is exposed on <http://dataplatform:8333>.

To use the Iceberg REST API with S3 table support, set `SEAWEEDFS_s3_table_bucket`
to the name of the S3 table bucket.
