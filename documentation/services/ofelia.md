# Ofelia

A docker job scheduler (aka. crontab for docker).

**[Documentation](https://github.com/mcuadros/ofelia)** | **[GitHub](https://github.com/mcuadros/ofelia)**

## How to enable?

```
platys init --enable-services OFELIA
```

Add a job to execute either as part of the ofelia service or to any other service which supports it. 

To add it to the ofelia service, configure the following settings

```yaml
      OFELIA_job_name: <name of the job>
      OFELIA_job_type: `job-exec` or `job-run` or `job-local`
      OFELIA_job_command: <the command to run>
      OFELIA_job_schedule: <the scheduling>
      OFELIA_job_image: <the name of the image, if job-run>
      OFELIA_job_container: <the name of the container, if job-exec>
```

now generate the stack

```
platys gen
```

## How to use it?

you can also add it to any existing service, by adding labels using an override file:

`docker-compose.override.yml`

```yml
minio-mc:
  labels:
    ofelia.enabled: "true"
    ofelia.job-exec.disk-usage.schedule: "@every 1m"
    ofelia.job-exec.disk-usage.command: "mc du --depth=2 minio-1/"
```
