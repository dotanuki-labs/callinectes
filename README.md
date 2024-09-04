# Callinectes

> Dockerized quality and security checks for Rust projects 🦀

## About

This project bakes and publishes a Docker image intended for Rust CI pipelines with an eye on quality,
supply-chain security and reproducible results.

The following tools are pre-installed :

- Latest Rust toolchain + components (`fmt`, `clippy`)
- Latest [cargo-deny](https://github.com/EmbarkStudios/cargo-deny)
- Latest [cargo-machete](https://github.com/bnjbvr/cargo-machete)
- Latest [cargo-msrv](https://github.com/foresterre/cargo-msrv)
- Latest [cargo-cyclonedx](https://github.com/CycloneDX/cyclonedx-rust-cargo)

All Cargo extensions have pinned versions by design, ensuring reproducibility as containerized executions.
New versions for these extensions are automatically managed by
[Renovate](https://github.com/renovatebot/renovate) along with our merging + publishing CI/CD automation.

## Using

You can bring `callinectes` to your CI pipeline with Docker:

```bash
docker run --rm -v "${PWD}:/usr/src" "ghcr.io/dotanuki-labs/callinectes:latest" <task> <task> ...
```

where `task` is one of the following

- `fmt`
- `clippy`
- `msrv`
- `deny`
- `cyclonedx`

For example, to check quality on Rust sources:

```bash
docker run --rm -v "${PWD}:/usr/src" "ghcr.io/dotanuki-labs/callinectes:latest" fmt clippy
```

Please check our entrypoint script to learn specifics on how those tasks are executed.

## Outro

[callinectes](https://en.wikipedia.org/wiki/Callinectes) is also known as the Atlantic blue crab.

## License

Copyright (c) 2024 - Dotanuki Labs - [The MIT license](https://choosealicense.com/licenses/mit)
