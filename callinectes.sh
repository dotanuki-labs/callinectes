#! /usr/bin/env bash
# Copyright 2025 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -e

usage() {
    echo
    echo "Available checks:"
    echo
    echo "fmt           # Checks formatting on Rust source files"
    echo "clippy        # Runs Clippy lints against Rust source files"
    echo "deny          # Checks vulnerabilities and compliance of project dependencies"
    echo "machete       # Checks unused dependencies declared in Cargo.toml files"
    echo "msrv          # Checks the Minimal Supported Rust Version for the project"
    echo "cyclonedx     # Generates a CycloneDx SBOM file from project dependencies"
    echo
}

check_sources_formatting() {
    echo
    echo "🦀 Checking code formatting (rustfmt)"
    echo
    cargo fmt --check
}

lint_source_files() {
    echo
    echo "🦀 Checking code smells (clippy)"
    echo
    cargo clippy --all-targets --all-features -- -D warnings
}

check_vulnerable_dependencies() {
    echo
    echo "🦀 Checking supply chain issues (cargo-deny)"
    echo
    cargo deny check licenses sources
}

check_unused_dependencies() {
    echo
    echo "🦀 Checking declared and unused dependencies (cargo-machete)"
    echo
    cargo machete
}

check_msrv() {
    echo
    echo "🦀 Checking Minimal Supported Rust Version (cargo-msrv)"
    echo
    cargo msrv verify
}

generate_cyclonedx_sbom() {
    echo
    echo "🦀 Generating CycloneDX SBOM (cargo-cyclonedx)"
    echo
    cargo cyclonedx --format json
}

if test "$#" -eq 0; then
    usage
    exit 0
fi

while test "$#" -gt 0; do
    case "$1" in
    "fmt")
        check_sources_formatting
        ;;
    "clippy")
        lint_source_files
        ;;
    "deny")
        check_vulnerable_dependencies
        ;;
    "machete")
        check_unused_dependencies
        ;;
    "msrv")
        check_msrv
        ;;
    "cyclonedx")
        generate_cyclonedx_sbom
        ;;
    *)
        echo "Error: unsupported checks → $1"
        usage
        exit 1
        ;;
    esac
    shift
done
