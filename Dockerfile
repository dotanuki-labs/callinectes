# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:ae668a1a103e2d636a0d9ce59fdb2ad974fe48e5d1c48f2f3ae3fea4afe23fc5 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:ae668a1a103e2d636a0d9ce59fdb2ad974fe48e5d1c48f2f3ae3fea4afe23fc5
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
