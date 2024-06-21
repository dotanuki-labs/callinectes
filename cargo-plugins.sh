#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -euo pipefail

echo
echo "🦀 Installing Rust toolchains"
rustup target add aarch64-unknown-linux-gnu
rustup target add x86_64-unknown-linux-gnu

echo
echo "🦀 Installing cargo-deny"
cargo install cargo-deny@0.14.24 --force --quiet --locked

echo
echo "🦀 Installing cargo-msrv"
cargo install cargo-msrv@0.15.1 --force --quiet --locked

echo
echo "🦀 Installing cargo-udeps"
cargo install cargo-udeps@0.1.47 --force --quiet --locked

echo
echo "🦀 Installing cargo-cyclonedx"
cargo install cargo-cyclonedx@0.5.2 --force --quiet --locked

echo
echo "✅ Done"
echo
