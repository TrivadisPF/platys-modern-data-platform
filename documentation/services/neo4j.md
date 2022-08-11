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
docker exec -ti neo4j-1 ./bin/cypher-shell -u neo4j -p abc123!
```
