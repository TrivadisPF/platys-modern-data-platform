FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
EXPOSE 3001
USER node
# server.mjs is mounted at runtime from ./scripts/hive-yoga/server-<N>.mjs
CMD ["node", "server.mjs"]
