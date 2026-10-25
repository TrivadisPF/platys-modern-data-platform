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
