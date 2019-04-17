# Two phase build

# Phase 1 - build node.js app
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Phase 2 - run built code in nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Allow default CMD to start it
