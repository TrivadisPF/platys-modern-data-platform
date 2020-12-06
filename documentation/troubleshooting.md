# Troubleshooting

In this document some tips and tricks for troubleshooting while developing a new generator version are documented. 

## When running `platys gen` I get an "already used" error

When running `platys gen` I get the following error: "The container name "/platys" is already in use by container":

```
docker@ubuntu:/mnt/hgfs/git/gschmutz/kafka-workshop/01-environment/docker$ platys gen
2020/11/15 07:11:09 using configuration file [config.yml] with values:  platform-name: [kafka-workshop], platform-stack: [trivadis/platys-modern-data-platform] platform-stack-version: [1.9.0-preview], structure [flat]
{"status":"Pulling from trivadis/platys-modern-data-platform","id":"1.9.0-preview"}
{"status":"Digest: sha256:a4f096f9d776c123999e7145d2c431baf40ba99959c26405f36bece47fb4598a"}
{"status":"Status: Image is up to date for trivadis/platys-modern-data-platform:1.9.0-preview"}
2020/11/15 07:11:10 Error response from daemon: Conflict. The container name "/platys" is already in use by container "699dad31ab7b2523f1687780502ab7488102d279006632859586c038853593c9". You have to remove (or rename) that container to be able to reuse that name.
```

You can fix it by just stopping and removing the `platys` container, still running from a previous call to `platys`

```
docker stop platys
docker rm platys
```


## How can I run the generator manually?

To run the generator without the `platys` CLI, perform the following `docker run` command:

```
docker run --rm -v ${PWD}/config.yml:/tmp/config.yml -v ${PWD}:/opt/mdps-gen/destination -e DEL_EMPTY_LINES=1 trivadis/platys-modern-data-platform:1.8.0-preview
```

or in verbose mode

```
docker run --rm -v ${PWD}/config.yml:/tmp/config.yml -v ${PWD}:/opt/mdps-gen/destination  -e DEL_EMPTY_LINES=1  -e VERBOSE=1 trivadis/platys-modern-data-platform:1.8.0-preview
```

## How can I run the jinja2 template engine manually?

```
docker run --rm -v /mnt/hgfs/git/gschmutz/twitter-streaming-demo/docker/documentation/templates:/templates -v /mnt/hgfs/git/gschmutz/twitter-streaming-demo/docker:/variables -e PUBLIC_IP=${PUBLIC_IP} dinutac/jinja2docker:latest /templates/services.md.j2 /variables/docker-compose.yml --format=yaml --outfile test.md
```
