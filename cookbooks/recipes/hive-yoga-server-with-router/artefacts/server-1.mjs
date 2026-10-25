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
