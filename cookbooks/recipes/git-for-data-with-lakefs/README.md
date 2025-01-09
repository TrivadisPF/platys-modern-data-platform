---
technologies:       lakefs
version:				1.18.0
validated-at:			9.1.2025
---

# Git for Data with LakeFS

This recipe will show how to use the [LakeFS](https://lakefs.io/) to implement Git for data with data on S3.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) 

```bash
export DATAPLATFORM_HOME=$PWD
platys init -n lakefs-platform --stack trivadis/platys-modern-data-platform --stack-version develop --structure flat -f
```

Now open the `config.yml` file with an editor and change the following settings. 

Search for PLATYS_MDP_INIT and enable it

```yaml
      #
      # ===== Platys Modern Data Platform Init ========
      #
      PLATYS_MDP_INIT_enable: true
```

Search for POSTGRESQL, enable it and change the other config settings

```yaml
      #
      # ===== PostgreSQL ========
      #
      POSTGRESQL_enable: true
      POSTGRESQL_multiple_databases: 'lakefsdb'
      POSTGRESQL_multiple_users: 'lakefs'
      POSTGRESQL_multiple_passwords: 'abc123!'
```
Search for MINIO, enable it and change the other config settings

```yaml
      #
      #=====  MinIO Object Storage ========
      #
      MINIO_enable: true
      MINIO_access_key: admin
      MINIO_secret_key: abc123abc123!
```

Search for LAKEFS, enable it and change the other config settings

```yaml      
      #
      #===== LakeFS ========
      #
      LAKEFS_enable: true
      LAKEFS_use_as_drop_in_replacement_for_s3: true
      # either 'local' or postgresql' or ('dynamodb' not yet supported)
      LAKEFS_database_type: 'postgresql'
      LAKEFS_database_username: lakefs
      LAKEFS_database_password: abc123!
      LAKEFS_database_dbname: lakefsdb      
      # either 'local' or 's3'
      LAKEFS_blockstore_type: 's3'
```

Search for FILESTASH, enable it and change the other config settings

```yaml
      #
      #=====  FileStash Storage UI ========
      #
      FILESTASH_enable: true
```

Generate the platform by executing `platys gen`.

## Configure the automatic setup configurations

Before we can start the platform, we have to create some shell scripts and json metafiles to perform the automatic initalization of the Minio buckets and the LakeFS repositories. 

Create the follwing files inside the `./init/platys-mdp-init` folder. They will be picked up and executed automatically by the **platys-mdp-init** docker container upon startup. Alternatively you can also copy the files from the cookbook sub-folder `artefacts/platys-mdp-init`.

`./init/platys-mdp-init/10_init_minio.sh`

```bash
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
```


`./init/platys-mdp-init/20_init_lakefs.sh`

```bash
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
```

`./init/platys-mdp-init/lakefs/lakefs-setup.json`

```json
{
    "username": "$LAKEFS_USER",
    "key": {
      "access_key_id": "$LAKEFS_CREDENTIALS_ACCESS_KEY_ID",
      "secret_access_key": "$LAKEFS_CREDENTIALS_SECRET_ACCESS_KEY"
    }
  }
```

`./init/platys-mdp-init/lakefs/admin-repository.json`

```json
{
    "name": "demo",
    "storage_namespace": "s3://lakefs-demo-bucket/",
    "default_branch": "main",
    "sample_data": false,
    "read_only": false
}
```

`./init/platys-mdp-init/lakefs/demo-repository.json`

```json
{
    "name": "admin",
    "storage_namespace": "s3://lakefs-admin-bucket/",
    "default_branch": "main",
    "sample_data": false,
    "read_only": false
}
```

## Start the platform

Now you can start the platform 

`docker compose up -d`

and when watching the logs you should see that Minio buckets and LakeFS repositories are created automatically.

`docker compose logs -f platys-mdp-init`


```bash
guido.schmutz@AMAXDKFVW0HYY ~/w/platys-lakefs-demo> docker compose logs -f platys-mdp-init
platys-mdp-init  | ./docker-entrypoint.sh: running /docker-entrypoint-init.d/30_init_minio.sh
platys-mdp-init  | 2025-01-09T18:38:41Z INF [HTTP] Checking the http://lakefs:8000/minio/health/live ...
platys-mdp-init  | 2025-01-09T18:38:41Z ERR Expectation failed error="failed to establish an http connection, caused by: Get \"http://lakefs:8000/minio/health/live\": dial tcp 192.168.107.9:8000: connect: connection refused" address=http://lakefs:8000/minio/health/live
platys-mdp-init  | 2025-01-09T18:38:46Z INF [HTTP] Checking the http://lakefs:8000/minio/health/live ...
platys-mdp-init  | 2025-01-09T18:38:46Z ERR Expectation failed error="failed to establish an http connection, caused by: Get \"http://lakefs:8000/minio/health/live\": dial tcp 192.168.107.9:8000: connect: connection refused" address=http://lakefs:8000/minio/health/live
platys-mdp-init  | 2025-01-09T18:38:51Z INF [HTTP] Checking the http://lakefs:8000/minio/health/live ...
platys-mdp-init  |
platys-mdp-init  | *****************************************************
platys-mdp-init  | Provisioning Buckets  .....
platys-mdp-init  | *****************************************************
platys-mdp-init  |
platys-mdp-init  | Bucket created successfully `minio-1/lakefs-admin-bucket`.
platys-mdp-init  | Tags set for http://minio-1:9000/lakefs-admin-bucket.
platys-mdp-init  | Bucket created successfully `minio-1/lakefs-demo-bucket`.
platys-mdp-init  | Tags set for http://minio-1:9000/lakefs-demo-bucket.
platys-mdp-init  |
platys-mdp-init  | ./docker-entrypoint.sh: running /docker-entrypoint-init.d/40_init_lakefs.sh
platys-mdp-init  | 2025-01-09T18:38:52Z INF [HTTP] Checking the http://lakefs:8000/api/v1/healthcheck ...
platys-mdp-init  |
platys-mdp-init  | *****************************************************
platys-mdp-init  | Provisioning LakeFS  .....
platys-mdp-init  | *****************************************************
platys-mdp-init  |
platys-mdp-init  | {"access_key_id":"admin","creation_date":1736447932,"secret_access_key":"abc123abc123!"}
platys-mdp-init  | {"creation_date":1736447935,"default_branch":"main","id":"admin","read_only":false,"storage_namespace":"s3://lakefs-admin-bucket/"}
platys-mdp-init  | {"creation_date":1736447935,"default_branch":"main","id":"demo","read_only":false,"storage_namespace":"s3://lakefs-demo-bucket/"}
platys-mdp-init  | Error: '/docker-entrypoint-init.d/lakefs/diff-repository.json' file not found for POST request.
platys-mdp-init  |
platys-mdp-init  |
platys-mdp-init  |
platys-mdp-init  |
platys-mdp-init  | ./docker-entrypoint.sh: ignoring /docker-entrypoint-init.d/readme.txt
platys-mdp-init  |
```

## Using LakeFS to crate a Branch

Navigate to <http://dataplatform:28220> and login as `admin` with password `abc123abc123!`. You should see the two repositories `admin` and `demo`, which confirms that the automatic setup of Minio and LakeFS has worked!

Click on `demo` and on the next page navigate to the `branches` tab. 

Click on **Create Branch** and enter `experiment` into the **Branch Name** field. Click on **Create**. A new branch has been created. 

Click on the **experiment** link to navigate to the branch. We can see that there are no files, the branch is empty.

Now we will use Filestash to create a new object in the branch. 

## Using Filestash to create a new object

Navigate to <http://dataplatform:28192>, navigate to the **S3** tab and enter `admin` for the **Access Key ID** field, `abc123abc123!` for the **Secret Access Key** field, enable **Advanced** and enter `http://lakefs:8000` into the **Endpoint** field. Clic on **CONNECT**.  

You should be connected to LakeFS and see two folders, `admin` and `demo`, representing the two repositories. 

Navigate to `demo` and you should see 2 sub-folders, `main` and `experiment`, representing the 2 branches in the **demo** repository. Click on `experiment` and you should see that the folder is empty.

Click on **NEW FILE** and enter `person.csv` for the filename and hit **Enter**. A new file is created. CLick on the `person.csv` file and an editor opens, enter the following lines:

```csv
id,name
10,Peter Muster
20,Barbara Muster
```

and click on the save icon in the bottom right. 

## View, commit and merge the changes in LakeFS

Back in LakeFS UI (<http://dataplatform:28220>) navigate first to the `main` branch and it should be empty. Now navigate to the `experiment` branch and click on **Uncommitted Changes** and you should see the new `person.csv` which we added but is not yet commited.

Click on **COMMIT CHANGES** and enter `Added the person.csv file` for the commit message and click on **COMMIT**. Navigating to **Objects** and you will see the file. If you navigate to the `main` branch, you will see that it is still empty. 

We can merge the changes in the `experiment` branch with the `main` branch. Navigate to **Compare** and chose `main` for the **Base branch** and `experiment` for the **Compared to branch**. You can see that the `person.csv` is new and will be added to the `main` branch upon merge. Click on **Merge** to perform the merge operation and confirm it by clicking on **Merge** on the pop-up window.

If you navigate to **Objects** and select the `main` branch, you will now also see the new file in this branch.



 
