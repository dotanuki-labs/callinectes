# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:acd31912499aa22b34ead9bb9869d02eead249d84e51d36238bd3f2245e88d2a AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:acd31912499aa22b34ead9bb9869d02eead249d84e51d36238bd3f2245e88d2a
RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

RUN apt-get update && apt-get install -qy libjemalloc-dev
WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
