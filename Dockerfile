# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:b09c0706d4899803440b99bd3234ef256d51e97454ab2e70b3cc91bc4396834f AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:b09c0706d4899803440b99bd3234ef256d51e97454ab2e70b3cc91bc4396834f
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
