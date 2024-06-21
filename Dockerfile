FROM rust:slim-buster@sha256:bed077243d5e7e02226ac4a2d816999806708b7dedd553c80d568ce4f0b6c964 as builder

RUN apt-get update && apt-get install -qy pkg-config libssl-dev
COPY ./cargo-plugins.sh /bin/cargo-plugins.sh
RUN cargo-plugins.sh

FROM rust:slim-buster@sha256:bed077243d5e7e02226ac4a2d816999806708b7dedd553c80d568ce4f0b6c964
COPY --from=builder /usr/local/cargo/ /usr/local/cargo/
COPY ./callinectes.sh /bin/callinectes

WORKDIR /usr/src

ENTRYPOINT [ "callinectes" ]
