#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -e

usage() {
    echo
    echo "Available checks:"
    echo
    echo "code      # Runs static analysers against Rust sources"
    echo "deps      # Inspects dependencies and drive SCA checks"
    echo
}

check_code_smells() {
    echo
    echo "🦀 Checking code formatting (rustfmt)"
    echo
    rustup component add rustfmt
    cargo fmt --check

    echo
    echo "🦀 Checking code smells (clippy)"
    echo
    rustup component add clippy
    cargo clippy --all-targets --all-features -- -D warnings

    echo
    echo "✅ Code quality checked with success"
    echo
}

check_supply_chain() {
    echo
    echo "🦀 Running cargo-msrv"
    echo
    cargo msrv verify

    echo
    echo "🦀 Running cargo-deny"
    echo
    cargo deny check

    echo
    echo "🦀 Running cargo-cyclonedx"
    echo
    cargo cyclonedx --format json

    echo
    echo "🦀 Running cargo-udeps"
    rustup default nightly
    cargo +nightly udeps

    echo
    echo "✅ Supply-chain checked with success"
    echo
}

readonly what="$1"

if [[ -z "$what" ]]; then
    usage
    exit 0
fi

case "$what" in
"code")
    check_code_smells
    ;;
"deps")
    check_supply_chain
    ;;
*)
    echo "Error: unsupported check → $what"
    usage
    exit 1
    ;;
esac
