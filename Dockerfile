# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# install dependencies into temp directory
# this will cache them and speed up future builds
FROM base AS install
RUN mkdir -p /temp/dev
COPY package.json /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# install with --production (exclude devDependencies)
RUN mkdir -p /temp/prod
COPY package.json /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

# copy node_modules from temp directory
# then copy all (non-ignored) project files into the image
FROM base AS prerelease
COPY --from=install /temp/dev/node_modules node_modules
COPY . .

# [optional] tests & build
ENV NODE_ENV=production
# RUN bun add -d @types/ejs
RUN bun run build

# copy production dependencies and source code into final image
FROM node:23.6.0-slim AS release
WORKDIR /usr/src/app

COPY --from=install /temp/prod/node_modules node_modules
COPY --from=prerelease /usr/src/app/dist dist
COPY --from=prerelease /usr/src/app/package.json .
COPY --from=prerelease /usr/src/app/workflows workflows

ENV WORKFLOWS_PATH=/usr/src/app/workflows
ENV CONSOLE_LOG_ACTIVE=true
ENV NODE_ENV=production
ENV APP_NAME=nanoservice-http

# run the app
USER node
EXPOSE 4000/tcp
EXPOSE 9091/tcp

#ENTRYPOINT [ "node", "-r", "./dist/opentelemetry_traces.js", "-r", "./dist/opentelemetry_metrics.js", "dist/index.js" ]
ENTRYPOINT [ "node", "-r", "./dist/opentelemetry_metrics.js", "dist/index.js" ]