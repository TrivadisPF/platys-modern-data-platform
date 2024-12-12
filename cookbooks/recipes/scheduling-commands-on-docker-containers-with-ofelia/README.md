---
technologies:       ofilia,python
version:				1.18.0
validated-at:			12.12.2024
---

# Schedule and execute commands in Docker containers using Ofelia

This recipe will show how to use the [Ofelia](https://github.com/mcuadros/ofelia) docker job scheduler.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started) with the needed services enabled and generate the platform:

```bash
mkdir -p platys-cookbook
cd platys-cookbook

cat > config.yml << EOL
      platys:
        platform-name: 'platys-platform'
        platform-stack: 'trivadis/platys-modern-data-platform'
        platform-stack-version: '1.18.0'
        structure: 'flat'

      # ========================================================================
      # Global configuration, valid for all or a group of services
      # ========================================================================
      # Timezone, use a Linux string such as Europe/Zurich or America/New_York
      use_timezone: ''
      # Name of the repository to use for private images, which are not on docker hub (currently only Oracle images)
      private_docker_repository_name: 'trivadis'
      # UID to use when using the "user" property in a service to override the user inside the container
      uid: '1000'

      # Optional environment identifier of this platys instance, by default take it from environment variable but can be changed to hardcoded value. 
      # Allowed values (taken from DataHub): dev, test, qa, uat, ei, pre, non_prod, prod, corp
      env: '${PLATYS_ENV}'

      data_centers: 'dc1,dc2'
      data_center_to_use: 0

      copy_cookbook_data_folder: true
      
      # ========================================================================
      # Platys Services
      # ========================================================================

      PROVISIONING_DATA_enable: true
      
      #
      # ===== Ofelia ========
      #
      OFELIA_enable: true
      OFELIA_job_name:
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-exec
      OFELIA_job_command:
      OFELIA_job_schedule:
      OFELIA_job_container:
      OFELIA_job_image:
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''    
      
      MINIO_enable: true
      MINIO_access_key: admin
      MINIO_secret_key: abc123abc123!
      MINIO_buckets: 'test-bucket'

      MINIO_upload_data_transfer_to_bucket_enabled: true
      MINIO_upload_data_transfer_bucket_name: 'data-transfer-bucket'
      MINIO_upload_data_transfer_subfolders: 'flight-data' 
      
      PYTHON_enable: true
EOL
      
platys gen
```

```bash
platys gen

docker-compose up -d
```

We have started a platform with `ofelia`, `minio` and `python`, the last two will be used to execute commands on. 

If we check the log of ofelia

```bash
docker compose logs -f ofelia
```

we will notice, that it does not start and complains with an error:

```
unable to start a empty scheduler.
unable to start a empty scheduler.
unable to start a empty scheduler.
unable to start a empty scheduler.
```

The reason for that is, that there is no job configured to be run by ofelia. 

## 1. Let's run a command inside the of the Ofelia service

First let's configure Ofelia to run the `date` command every 30 seconds inside the Ofelia service itself. 

Update the `config.yml` with the following settings:

```yaml
      OFELIA_enable: true
      OFELIA_job_name: 'execute-date-every-30s'
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-local
      OFELIA_job_command: date
      OFELIA_job_schedule: '@every 30s'
      OFELIA_job_container:
      OFELIA_job_image:
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''    
```

and run `platys gen` followed by `docker compose up -d`.

If we now check the logs of `ofelia`, we can see the `date command being executed every 30 seconds:

```bash
> docker logs -f ofelia
2024-12-12T18:30:36.585Z  scheduler.go:44 ▶ NOTICE New job registered "execute-date-every-30s" - "date" - "@every 30s"
2024-12-12T18:30:36.585Z  scheduler.go:55 ▶ DEBUG Starting scheduler with 1 jobs
2024-12-12T18:31:06.008Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (ba4f4c28bba9)] Started - date
2024-12-12T18:31:06.026Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (ba4f4c28bba9)] StdOut: Thu Dec 12 18:31:06 UTC 2024
2024-12-12T18:31:06.026Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (ba4f4c28bba9)] Finished in "17.321669ms", failed: false, skipped: false, error: none
2024-12-12T18:31:36.012Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (5d886995f4ed)] Started - date
2024-12-12T18:31:36.014Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (5d886995f4ed)] StdOut: Thu Dec 12 18:31:36 UTC 2024
2024-12-12T18:31:36.014Z  common.go:125 ▶ NOTICE [Job "execute-date-every-30s" (5d886995f4ed)] Finished in "1.48508ms", failed: false, skipped: false, error: none
```

## 2. Let's run a command on another service (`minio-mc`)

Now let's configure Ofelia so that a command is executed on an other, already running container. We will use the MinIO CLI available as `minio-mc` and execute a disk usage report every 30 seconds. 

Update the `config.yml` with the following settings

```yaml
      OFELIA_enable: true
      OFELIA_job_name: 'disk-usage-every-30s'
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-exec
      OFELIA_job_command: 'mc du --depth=3 minio-1/'
      OFELIA_job_schedule: '@every 30s'
      OFELIA_job_container: minio-mc
      OFELIA_job_image:
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''    
```

and run `platys gen` followed by `docker compose up -d`.

If we now check the logs of `ofelia`, we can see the result of the disk usage every 30 seconds: 

```bash
> docker logs -f ofelia
2024-12-12T19:26:28.913Z  scheduler.go:44 ▶ NOTICE New job registered "disk-usage-every-30s" - "mc du --depth=3 minio-1/" - "@every 30s"
2024-12-12T19:26:28.914Z  scheduler.go:55 ▶ DEBUG Starting scheduler with 1 jobs
2024-12-12T19:26:58.008Z  common.go:125 ▶ NOTICE [Job "disk-usage-every-30s" (8d5608dc8fd8)] Started - mc du --depth=3 minio-1/
2024-12-12T19:26:58.152Z  common.go:125 ▶ NOTICE [Job "disk-usage-every-30s" (8d5608dc8fd8)] StdOut: 0B	0 objects	admin-bucket
84MiB	72 objects	data-transfer-bucket/adventureworks
56MiB	12 objects	data-transfer-bucket/airports-data
370MiB	17 objects	data-transfer-bucket/flight-data
27MiB	6 objects	data-transfer-bucket/graphdb-news
6.4MiB	1 object	data-transfer-bucket/imdb-movies
64KiB	3 objects	data-transfer-bucket/platys-cookbooks
16KiB	1 object	data-transfer-bucket/synthetic-load-generator
6.2MiB	1 object	data-transfer-bucket/wordcount
548MiB	114 objects	data-transfer-bucket
0B	0 objects	test-bucket
548MiB	114 objects
2024-12-12T19:26:58.152Z  common.go:125 ▶ NOTICE [Job "disk-usage-every-30s" (8d5608dc8fd8)] Finished in "143.999004ms", failed: false, skipped: false, error: none
```

## 3. Run the command on other service by adding labels to the target container

Now we change the configuration so that the command to be executed is not part of ofelia, but is specified using labels on the target container (where the command should be executed). 

Update the `config.yml` with the following settings

```yaml
      OFELIA_enable: true
      OFELIA_job_name:
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-exec
      OFELIA_job_command:
      OFELIA_job_schedule:
      OFELIA_job_container:
      OFELIA_job_image:
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''      
```

We set Ofelia back to the original config.

Now run `platys gen`.

Platys does not yet support generating the labels. But we can easily ammend a service by using a `docker-compose.override.yml` file. 

Create the `docker-compose.override.yml` file (same location as the `config.yml`) and add

```yaml
services:
  minio-mc:
    labels:
      ofelia.enabled: "true"
      ofelia.job-exec.disk-usage.schedule: "@every 30s"
      ofelia.job-exec.disk-usage.command: "mc du --depth=3 minio-1/"
```

now start the stack `docker compose up -d`.

Let's see the logs of `ofelia`.

```bash
> docker logs -f ofelia
2024-12-12T19:40:38.229Z  scheduler.go:44 ▶ NOTICE New job registered "disk-usage" - "mc du --depth=3 minio-1/" - "@every 30s"
2024-12-12T19:40:38.23Z  scheduler.go:55 ▶ DEBUG Starting scheduler with 1 jobs
2024-12-12T19:41:08.007Z  common.go:125 ▶ NOTICE [Job "disk-usage" (a2c4772e7596)] Started - mc du --depth=3 minio-1/
2024-12-12T19:41:09.376Z  common.go:125 ▶ NOTICE [Job "disk-usage" (a2c4772e7596)] StdOut: 0B	0 objects	admin-bucket
84MiB	72 objects	data-transfer-bucket/adventureworks
56MiB	12 objects	data-transfer-bucket/airports-data
349MiB	17 objects	data-transfer-bucket/flight-data
7.8MiB	6 objects	data-transfer-bucket/graphdb-news
6.4MiB	1 object	data-transfer-bucket/imdb-movies
64KiB	3 objects	data-transfer-bucket/platys-cookbooks
16KiB	1 object	data-transfer-bucket/synthetic-load-generator
503MiB	113 objects	data-transfer-bucket
503MiB	113 objects
2024-12-12T19:41:09.376Z  common.go:125 ▶ NOTICE [Job "disk-usage" (a2c4772e7596)] Finished in "1.368669831s", failed: false, skipped: false, error: none
```

Delete the `docker-compose.override.yml` file. 

## 4. Run a command on a new container

Now we change the configuration so that the command is executed in a new container, started by ofelia whenever the schedule is reached.

Update the `config.yml` with the following settings

```yaml
      OFELIA_enable: true
      OFELIA_job_name: 'run-ping-every-30s'
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-run
      OFELIA_job_command: 'ping -c 2 www.google.com'
      OFELIA_job_schedule: '@every 30s'
      OFELIA_job_container:
      OFELIA_job_image: 'heimdocker/ping'
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''     
```

and run `platys gen` followed by `docker compose up -d`.

If we now check the logs of `ofelia`, we can see the result of the executing the `ping` every 30 seconds: 

```bash
> docker logs -f ofelia
2024-12-12T19:58:10.428Z  scheduler.go:44 ▶ NOTICE New job registered "run-ping-every-30s" - "ping -c 2 www.google.com" - "@every 30s"
2024-12-12T19:58:10.433Z  scheduler.go:55 ▶ DEBUG Starting scheduler with 1 jobs
2024-12-12T19:58:40.001Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (9e4e2f53ffa4)] Started - ping -c 2 www.google.com
2024-12-12T19:58:41.195Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (9e4e2f53ffa4)] Pulled image heimdocker/ping
2024-12-12T19:58:42.556Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (9e4e2f53ffa4)] StdOut: PING www.google.com (172.217.168.4) 56(84) bytes of data.
64 bytes from zrh11s03-in-f4.1e100.net (172.217.168.4): icmp_req=1 ttl=54 time=9.74 ms
64 bytes from zrh11s03-in-f4.1e100.net (172.217.168.4): icmp_req=2 ttl=54 time=9.35 ms

--- www.google.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 9.350/9.545/9.741/0.218 ms
2024-12-12T19:58:42.556Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (9e4e2f53ffa4)] Finished in "2.554494078s", failed: false, skipped: false, error: none
2024-12-12T19:59:10.001Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (5c705f9191bc)] Started - ping -c 2 www.google.com
2024-12-12T19:59:11.25Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (5c705f9191bc)] Pulled image heimdocker/ping
2024-12-12T19:59:12.524Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (5c705f9191bc)] StdOut: PING www.google.com (172.217.168.4) 56(84) bytes of data.
64 bytes from zrh11s03-in-f4.1e100.net (172.217.168.4): icmp_req=1 ttl=54 time=8.45 ms
64 bytes from zrh11s03-in-f4.1e100.net (172.217.168.4): icmp_req=2 ttl=54 time=13.1 ms

--- www.google.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1004ms
rtt min/avg/max/mdev = 8.456/10.801/13.146/2.345 ms
2024-12-12T19:59:12.524Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (5c705f9191bc)] Finished in "2.523322483s", failed: false, skipped: false, error: none
```

## 5. Execute a Python script in the `python` container

In this sample we will execute a python script ever 30 seconds in the existing `python` container. 

First let's write a simple python application which calculates pi and prints it to the console:

Create a new file `pi.py` (located where the `config.yml` is) and add

```python
from mpmath import mp

# Set desired precision (e.g., 50 decimal places)
mp.dps = 50
pi = mp.pi
print(f"Pi using mpmath with high precision: {pi}")
```

Also create a `requirements.txt` file and add the `mpmath` libarary

```
mpmath
```

Update the `config.yml` with the following settings

```yaml
      OFELIA_enable: true
      OFELIA_job_name: 'run-ping-every-30s'
      # either 'job-exec' or 'job-run' or 'job-local'      
      OFELIA_job_type: job-exec
      OFELIA_job_command: 'python /app/pi.py'
      OFELIA_job_schedule: '@every 30s'
      OFELIA_job_container: 'python-1'
      OFELIA_job_image: ''
      OFELIA_job_network:
      OFELIA_log_to_folder: false
      OFELIA_environment: ''    
```

and run `platys gen` followed by `docker compose up -d`.

If we now check the logs of `ofelia`, we can see the result of the executing of our python application:

```bash
> docker logs -f ofelia
2024-12-12T20:49:47.659Z  scheduler.go:44 ▶ NOTICE New job registered "run-ping-every-30s" - "python /app/pi.py" - "@every 30s"
2024-12-12T20:49:47.659Z  scheduler.go:55 ▶ DEBUG Starting scheduler with 1 jobs
2024-12-12T20:50:20.529Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (88349c8ba8d1)] Started - python /app/pi.py
2024-12-12T20:50:20.687Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (88349c8ba8d1)] StdOut: Pi using mpmath with high precision: 3.1415926535897932384626433832795028841971693993751
2024-12-12T20:50:20.687Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (88349c8ba8d1)] Finished in "158.188785ms", failed: false, skipped: false, error: none
2024-12-12T20:50:50.013Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (542c64ec9c16)] Started - python /app/pi.py
2024-12-12T20:50:50.164Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (542c64ec9c16)] StdOut: Pi using mpmath with high precision: 3.1415926535897932384626433832795028841971693993751
2024-12-12T20:50:50.164Z  common.go:125 ▶ NOTICE [Job "run-ping-every-30s" (542c64ec9c16)] Finished in "150.775025ms", failed: false, skipped: false, error: none
``
