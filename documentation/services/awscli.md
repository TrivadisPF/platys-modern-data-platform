# awscli

Universal Command Line Interface for Amazon Web Services 

**[Website](https://aws.amazon.com/cli/)** | **[Documentation](https://docs.aws.amazon.com/cli/index.html)** | **[GitHub](https://github.com/aws/aws-cli)**

## How to enable?

```
platys init --enable-services AWSCLI
platys gen
```

## How to use it?

Within the container, you can either use the `aws` or `s3cmd` command line interface. 

### aws

If using the local `minio` S3 service then you have to specify the endpoint. The rest is configured through the environment variables. I.e. to list all available buckets:

```bash
docker exec -ti awscli aws --endpoint-url http://minio-1:9000 s3 ls
```

### s3cmd

To list all available buckets using s3cmd:

```cmd
docker exec -ti awscli s3cmd ls
```