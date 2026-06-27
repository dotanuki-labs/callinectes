# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:6abf73f05806f36362d0ff2722f2250c6153398831edd0455e0e0baa1f78ecc7 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:6abf73f05806f36362d0ff2722f2250c6153398831edd0455e0e0baa1f78ecc7
RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

RUN apt-get update && apt-get install -qy libjemalloc-dev
WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
