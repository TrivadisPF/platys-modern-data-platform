---
technologies:       hive-router
version:				1.21.0
validated-at:			25.10.2026
---

# Using Hive Yoga Servers with Hive Router for GraphQL Federation

## Creating the Authors GraphQL service

`server-1.mjs`

```js
import { createServer } from 'node:http'
import { createYoga } from 'graphql-yoga'
import { buildSubgraphSchema } from '@apollo/subgraph'
import { renderApolloSandbox } from '@graphql-yoga/render-apollo-sandbox'
import { parse } from 'graphql'

const authors = [
  { id: '1', name: 'Frank Herbert', born: 1920 },
  { id: '2', name: 'Ursula K. Le Guin', born: 1929 },
  { id: '3', name: 'Isaac Asimov', born: 1920 }
]

// Apollo Federation v2 subgraph. Author is an entity keyed on `id`, so the
// Hive Router can entity-fetch name/born when another subgraph (books)
// references an Author by id.
const typeDefs = parse(/* GraphQL */ `
  extend schema @link(url: "https://specs.apollo.dev/federation/v2.3", import: ["@key"])

  type Author @key(fields: "id") {
    id: ID!
    name: String!
    born: Int
  }

  type Query {
    author(id: ID!): Author
    authors(ids: [ID!]!): [Author]
  }
`)

const resolvers = {
  Query: {
    author: (_, { id }) => authors.find((a) => a.id === id) ?? null,
    authors: (_, { ids }) => ids.map((id) => authors.find((a) => a.id === id) ?? null)
  },
  Author: {
    // Entity resolver invoked via _entities(representations: [{ __typename: "Author", id }])
    __resolveReference: (ref) => authors.find((a) => a.id === ref.id) ?? null
  }
}

const yoga = createYoga({
  graphqlEndpoint: '/graphql',
  schema: buildSubgraphSchema([{ typeDefs, resolvers }]),
  // Serve Apollo Sandbox (instead of the default GraphiQL) on the GET endpoint.
  renderGraphiQL: renderApolloSandbox()
})

createServer(yoga).listen(3001, '0.0.0.0', () => {
  console.log('Authors service: http://0.0.0.0:3001/graphql')
})
```

## Creating the Books GraphQL service

`server-2.mjs`

```js
import { createServer } from 'node:http'
import { createYoga } from 'graphql-yoga'
import { buildSubgraphSchema } from '@apollo/subgraph'
import { parse } from 'graphql'

const books = [
  { id: '1', title: 'Dune', authorId: '1' },
  { id: '2', title: 'Children of Dune', authorId: '1' },
  { id: '3', title: 'A Wizard of Earthsea', authorId: '2' },
  { id: '4', title: 'The Dispossessed', authorId: '2' },
  { id: '5', title: 'Foundation', authorId: '3' }
]

// Apollo Federation v2 subgraph. Book.author returns a stub Author reference
// ({ __typename: "Author", id }); the authors subgraph resolves the rest of
// the Author entity. Author is declared with resolvable: false here because
// this subgraph only produces references, it does not resolve them.
const typeDefs = parse(/* GraphQL */ `
  extend schema @link(url: "https://specs.apollo.dev/federation/v2.3", import: ["@key"])

  type Book @key(fields: "id") {
    id: ID!
    title: String!
    authorId: ID!
    author: Author
  }

  type Author @key(fields: "id", resolvable: false) {
    id: ID!
  }

  type Query {
    book(id: ID!): Book
    books: [Book!]!
  }
`)

const resolvers = {
  Query: {
    book: (_, { id }) => books.find((b) => b.id === id) ?? null,
    books: () => books
  },
  Book: {
    author: (book) => ({ __typename: 'Author', id: book.authorId })
  }
}

const yoga = createYoga({
  graphqlEndpoint: '/graphql',
  schema: buildSubgraphSchema([{ typeDefs, resolvers }])
})

createServer(yoga).listen(3001, '0.0.0.0', () => {
  console.log('Books service: http://0.0.0.0:3001/graphql')
})
```

## Compose subgraphs into Supergraph

```graphql
schema
  @link(url: "https://specs.apollo.dev/link/v1.0")
  @link(url: "https://specs.apollo.dev/join/v0.3", for: EXECUTION)
{
  query: Query
}

directive @join__enumValue(graph: join__Graph!) repeatable on ENUM_VALUE

directive @join__field(graph: join__Graph, requires: join__FieldSet, provides: join__FieldSet, type: String, external: Boolean, override: String, usedOverridden: Boolean) repeatable on FIELD_DEFINITION | INPUT_FIELD_DEFINITION

directive @join__graph(name: String!, url: String!) on ENUM_VALUE

directive @join__implements(graph: join__Graph!, interface: String!) repeatable on OBJECT | INTERFACE

directive @join__type(graph: join__Graph!, key: join__FieldSet, extension: Boolean! = false, resolvable: Boolean! = true, isInterfaceObject: Boolean! = false) repeatable on OBJECT | INTERFACE | UNION | ENUM | INPUT_OBJECT | SCALAR

directive @join__unionMember(graph: join__Graph!, member: String!) repeatable on UNION

directive @link(url: String, as: String, for: link__Purpose, import: [link__Import]) repeatable on SCHEMA

scalar join__FieldSet

scalar link__Import

enum link__Purpose {
  """
  `SECURITY` features provide metadata necessary to securely resolve fields.
  """
  SECURITY
  """
  `EXECUTION` features provide metadata necessary for operation execution.
  """
  EXECUTION
}

enum join__Graph {
  AUTHORS @join__graph(name: "authors", url: "http://hive-yoga-server-1:3001/graphql")
  BOOKS @join__graph(name: "books", url: "http://hive-yoga-server-2:3001/graphql")
}

type Author
  @join__type(graph: AUTHORS, key: "id")
  @join__type(graph: BOOKS, key: "id", resolvable: false)
{
  id: ID!
  name: String! @join__field(graph: AUTHORS)
  born: Int @join__field(graph: AUTHORS)
}

type Book
  @join__type(graph: BOOKS, key: "id")
{
  id: ID!
  title: String!
  authorId: ID!
  author: Author
}

type Query
  @join__type(graph: AUTHORS)
  @join__type(graph: BOOKS)
{
  author(id: ID!): Author @join__field(graph: AUTHORS)
  authors(ids: [ID!]!): [Author] @join__field(graph: AUTHORS)
  book(id: ID!): Book @join__field(graph: BOOKS)
  books: [Book!]! @join__field(graph: BOOKS)
}
```