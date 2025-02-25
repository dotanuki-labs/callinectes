# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:656b27d4e2eef8905f3edebb96214ebaab9931b9416fb91918e992ec8a6bdea0 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:656b27d4e2eef8905f3edebb96214ebaab9931b9416fb91918e992ec8a6bdea0
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
