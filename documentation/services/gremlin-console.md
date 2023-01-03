# Gremlin Console

The Gremlin Console serves a variety of use cases that can meet the needs of different types of Gremlin users. This tutorial explores the features of the Gremlin Console through a number of these different use cases to hopefully inspire you to new levels of usage. While a use case may not fit your needs, you may well find it worthwhile to read, as it is possible that a "feature" will be discussed that may be useful to you.

**[Website](https://tinkerpop.apache.org/)** | **[Documentation](https://tinkerpop.apache.org/docs/current/tutorials/the-gremlin-console/)** | **[GitHub](https://github.com/apache/tinkerpop)**

```bash
platys init --enable-services GREMLIN_CONSOLE
platys gen
```

## How to use it?

### Using the Gremlin Console

To start a gremlin console

```bash
docker exec -ti gremlin-console ./bin/gremlin.sh    
```

and then connect to 

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