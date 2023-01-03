# Invana Engine

GraphQL API for creating and managing graph data 

**[Website](https://invana.io/)** | **[Documentation](https://docs.invana.io/products/invana-engine)** | **[GitHub](https://github.com/invana/invana-engine)**

```bash
platys init --enable-services INVANA_ENGINE
platys gen
```

## How to use it?

### Using the Gremlin Console

To start a gremlin console

```bash
docker-compose -f docker-compose.yml run --rm \
    -e GREMLIN_REMOTE_HOSTS=janusgraph-1 janusgraph-1 ./bin/gremlin.sh    
```

```groovy
:remote connect tinkerpop.server conf/remote.yaml
g = traversal().withRemote('conf/remote-graph.properties')
g.addV('demigod').property('name', 'hercules').iterate()    
g.V()
```

### Initialise JanusGraph

When the container is started it will execute files with the extension `.groovy` that are found in `./init/janusgraph/` with the Gremlin Console. These scripts are only executed after the JanusGraph Server instance was started. So, they can connect to it and execute Gremlin traversals.

For example, to add a vertex to the graph, create a file `./init/janusgraph/add-vertex.groovy` with the following content

```groovy
g = traversal().withRemote('conf/remote-graph.properties')
g.addV('demigod').property('name', 'hercules').iterate()
```