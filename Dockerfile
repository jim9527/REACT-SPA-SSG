FROM node:20.12.2-alpine as client

RUN echo @edge https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && echo @edge https://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
  && apk -U upgrade \
  && apk add --no-cache \
    chromium@edge \
    nss@edge \
    freetype@edge \
    harfbuzz@edge \
    ttf-freefont@edge \
    libstdc++@edge \
    wayland-libs-client@edge \
    wayland-libs-server@edge \
    wayland-libs-cursor@edge \
    wayland-libs-egl@edge \
    wayland@edge

WORKDIR /app
COPY docker-package.json ./package.json
COPY yarn.lock index.html tsconfig.json vite.config.ts ./
COPY ./src ./src

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v0.11.0 works with Chromium 63.
RUN yarn add puppeteer@0.13.0

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app

# Run everything after as non-privileged user.
USER pptruser

RUN yarn --frozen-lockfile
RUN yarn build

FROM node:20.12.2-alpine AS base
WORKDIR /app
RUN yarn add serve
ENV NODE_ENV production
COPY --from=client /app/dist ./dist
COPY package.json ./

EXPOSE 80
ENV PORT 80

CMD yarn prod

# FROM node:20.12.2-alpine AS base

# # Install dependencies
# FROM base AS deps
# WORKDIR /app

# COPY package.json yarn.lock*  ./
# RUN yarn --frozen-lockfile

# # build the sourcecode 
# FROM base as builder
# RUN apk update && apk upgrade && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
#     apk add --no-cache \
#       chromium@edge \
#       nss@edge
# WORKDIR /app
# COPY --from=deps /app/node_modules ./node_modules
# COPY . .
# RUN yarn build

# # production image, copy all the files and run 
# FROM base AS runner
# WORKDIR /app

# ENV NODE_ENV production
# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/dist ./dist
# COPY --from=builder /app/package.json ./

# EXPOSE 80
# ENV PORT 80

# CMD yarn prod

