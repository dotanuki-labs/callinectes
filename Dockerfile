# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

FROM rust:slim@sha256:5d89afc3c52b58c6fe5308a46c1e2e1b0f34c2691cfd8cc47c5a7f3af98294d6 AS builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim@sha256:5d89afc3c52b58c6fe5308a46c1e2e1b0f34c2691cfd8cc47c5a7f3af98294d6
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
