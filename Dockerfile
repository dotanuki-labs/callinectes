# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:7d3701660d2aa7101811ba0c54920021452aa60e5bae073b79c2b137a432b2f4 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:7d3701660d2aa7101811ba0c54920021452aa60e5bae073b79c2b137a432b2f4
RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

RUN apt-get update && apt-get install -qy libjemalloc-dev
WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
