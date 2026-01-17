#! /usr/bin/env bash
# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -euo pipefail

echo
echo "🦀 Installing Rust toolchains"
echo
rustup target add aarch64-unknown-linux-gnu
rustup target add x86_64-unknown-linux-gnu
rustup component add rustfmt
rustup component add clippy

echo
echo "🦀 Installing cargo-deny"
cargo install cargo-deny@0.19.0 --force --quiet --locked

echo
echo "🦀 Installing cargo-msrv"
cargo install cargo-msrv@0.18.4 --force --quiet --locked

echo
echo "🦀 Installing cargo-machete"
cargo install cargo-machete@0.9.1 --force --quiet --locked

echo
echo "🦀 Installing cargo-cyclonedx"
cargo install cargo-cyclonedx@0.5.7 --force --quiet --locked

echo
echo "✅ Done"
echo
