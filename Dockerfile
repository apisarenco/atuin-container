ARG GIT_TAG=${GIT_TAG:-main}
ARG ALPINE_VERSION=${ALPINE_VERSION:-3.21}

#####################
FROM alpine:${ALPINE_VERSION} AS base
FROM base AS downloader

ARG GIT_TAG

RUN apk add --update --upgrade --no-cache curl bash

WORKDIR /setup

COPY setup.sh setup.sh
RUN chmod +x setup.sh

WORKDIR /atuin

RUN /setup/setup.sh "${GIT_TAG}"

#####################
FROM base AS final

ENV TZ=Etc/UTC \
    RUST_LOG=atuin::api=info \
    ATUIN_CONFIG_DIR=/config

RUN adduser -D -g 'atuin user' atuin && \
    mkdir /config && \
    chown atuin:atuin /config && \
    apk add --no-cache \
    --update \
    --upgrade \
    ca-certificates

WORKDIR /app

USER atuin

COPY --from=downloader /atuin/atuin /usr/local/bin/atuin

CMD atuin
