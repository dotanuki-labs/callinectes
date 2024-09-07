#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
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
echo "🦀 Installing cargo-binstall"
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

echo
echo "🦀 Installing cargo-deny"
cargo binstall cargo-deny@0.16.1 --force --quiet --locked --no-confirm

echo
echo "🦀 Installing cargo-msrv"
cargo binstall cargo-msrv@0.15.1 --force --quiet --locked --no-confirm

echo
echo "🦀 Installing cargo-machete"
cargo binstall cargo-machete@0.6.2 --force --quiet --locked --no-confirm

echo
echo "🦀 Installing cargo-cyclonedx"
cargo binstall cargo-cyclonedx@0.5.5 --force --quiet --locked --no-confirm

echo
echo "✅ Done"
echo
