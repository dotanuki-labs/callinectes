# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:31ee7fc65186be7e0e0ccb3f2ca305f14e4739e7642a1ae65753aa5d7b874523 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:31ee7fc65186be7e0e0ccb3f2ca305f14e4739e7642a1ae65753aa5d7b874523
RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

RUN apt-get update && apt-get install -qy libjemalloc-dev
WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
