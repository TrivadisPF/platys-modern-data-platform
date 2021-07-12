# Command Cheatsheet

## Start the platform stack

```
docker-compose up -d
```

## Stop and Remove the platform stack

```
docker-compose down
```

be careful, all the content in the running containers will be removed!

## Show all running containers

Show all running containers

```
docker-compose ps
```

## Attach to a running container

Show the log of all running containers

```
docker-compose logs -f
```

Only show the log of a few services (`kafka-connect-1` and `kafka-connect-2` in this example)

```
docker-compose logs -f kafka-connect-1 kafka-connect-2
```

## Attach to a running container

Run a `bash` shell by proding the container id or name (here `kafka-1`)

```
docker exec -ti kafka-1 bash
```