# Neo4J

Neo4j gives developers and data scientists the most trusted and advanced tools to quickly build today’s intelligent applications and machine learning workflows. Available as a fully managed cloud service or self-hosted.

**[Website](https://neo4j.com/)** | **[Documentation](https://neo4j.com/docs/)** | **[GitHub](https://github.com/neo4j/neo4j)**

## How to enable?

```
platys init --enable-services NEO4J
platys gen
```

## How to use it?

Navigate to <http://dataplatform:7474> to use the Neo4J Browser.

To use the `cypher-shell`, in a terminal window execute

```bash
docker exec -ti neo4j-1 ./bin/cypher-shell -u neo4j -p abc123abc123
```

## How to further configure Docker image

all valid configuration settings for configuring the Neo4J docker container can be found [here](https://neo4j.com/docs/operations-manual/current/docker/ref-settings/). Some are directly supported as [configuration settings](http://dataplatform/documentation/configuration) in the Platys `config.yml`. All the other can be added by using a `docker-compose.override.yml` file. 