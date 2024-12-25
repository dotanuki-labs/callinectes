# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:1c800be3f6064ca76224ed0faf44f1867b9eeb5d2aa7ba2e2a57115d10404981 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:1c800be3f6064ca76224ed0faf44f1867b9eeb5d2aa7ba2e2a57115d10404981
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
