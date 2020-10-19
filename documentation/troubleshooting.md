# Troubleshooting

In this document some tips and tricks for troubleshooting while developing a new generator version are documented. 

## How can I run the generator manually?

To run the generator without the `platys` CLI, perform the following `docker run` command:

```
docker run --rm -v ${PWD}/config.yml:/tmp/config.yml -v ${PWD}:/opt/mdps-gen/destination -e DEL_EMPTY_LINES=1 trivadis/platys-modern-data-platform:1.8.0-preview
```

or in verbose mode

```
docker run --rm -v ${PWD}/config.yml:/tmp/config.yml -v ${PWD}:/opt/mdps-gen/destination  -e DEL_EMPTY_LINES=1  -e VERBOSE=1 trivadis/platys-modern-data-platform:1.8.0-preview
```