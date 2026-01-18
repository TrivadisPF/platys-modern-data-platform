---
technoglogies:    neo4j
version:				  1.15.0
validated-at:			15.02.2022
---

# Working with Neo4J

This recipe will show how to use Neo4J.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services NEO4J -s trivadis/platys-modern-data-platform
```

Now generate and start the data platform.

```
platys gen

docker-compose up -d
```

## Working with Neo4J

Connect to the `cypher-shell` in the `neo4j-1` container:

```
docker exec -ti neo4j-1 ./bin/cypher-shell -u neo4j -p abc123!
```

Alternatively you can also connect through the Neo4J Browser: <http://dataplatform:7474>

Create a plain node

```
CREATE (n)
```

Select all nodes (the one created before) and return them

```
MATCH (n) RETURN n
```

Create a node labeled `Person`

```
CREATE (p:Person)
```

Only return nodes with the label `Person`

```
MATCH (p:Person) RETURN p
```

```
CREATE (p:Person {firstName: "Guido", lastName: "Schmutz"})
```

```
CREATE (n1)-[r:Relationship]->(n2) RETURN n1, n2
```

```
MATCH (n)-[r:Relationship]->() RETURN n LIMIT 25
```

```
CREATE (s:Student)-[r:STUDENT_OF]->(c:Course) RETURN s, c
```

```
CREATE (p:Person:Student {firstName:"Martin",lastName:"Kraft"}),(c:Course {name: "NoSQL"}) RETURN p, c
```

```
MATCH (s:Student), (c:Course)
WHERE s.firstName = "Martin" AND s.lastName = "Kraft" AND c.name = "NoSQL"
CREATE (s)-[r:STUDENT_OF]->(c)
RETURN s, c
```

```
MATCH (s:Student), (c:Course)
WHERE s.firstName = "Martin" AND s.lastName = "Kraft" AND c.name = "NoSQL"
CREATE (s)-[r:STUDENT_OF {year:"2020"}]->(c)
RETURN s, c
```
