# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:6cff8a33b03d328aa58d00dedda6a3c5bbee4b41e21533932bffd90d7d58f9c4 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:6cff8a33b03d328aa58d00dedda6a3c5bbee4b41e21533932bffd90d7d58f9c4
RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

RUN apt-get update && apt-get install -qy libjemalloc-dev
WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
