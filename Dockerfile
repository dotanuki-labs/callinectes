# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:9276ca34712033fa8d12db5f07417c0f5e7eefa41ba9925fd8b5f87627cf2fec AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:9276ca34712033fa8d12db5f07417c0f5e7eefa41ba9925fd8b5f87627cf2fec
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]

LABEL org.opencontainers.image.source="https://github.com/dotanuki-labs/callinectes"
LABEL org.opencontainers.image.description="Dockerized quality and security checks for Rust projects"
LABEL org.opencontainers.image.licenses="MIT"
