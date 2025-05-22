# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:989095388527710c84035fb19f851eee7c1ef3280f20885afaa3f1ca40c132a0 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:989095388527710c84035fb19f851eee7c1ef3280f20885afaa3f1ca40c132a0
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
