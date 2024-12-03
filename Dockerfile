# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:d5e099796bcfe12393ed610f2e6f972cd6be4b87e137fc7d60424d0430698d80 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:d5e099796bcfe12393ed610f2e6f972cd6be4b87e137fc7d60424d0430698d80
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
