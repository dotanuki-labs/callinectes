#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly temp_folder="$script_dir/.tmp"

rm -rf "$temp_folder" && mkdir "$temp_folder"
git clone https://github.com/dotanuki-labs/gradle-wrapper-validator.git "$temp_folder"

echo
echo "🔥 Building Docker image"
echo
docker build . -t dotanuki-labs/callinectes

echo
echo "🔥 Checking code smells"
echo
docker run --rm -v "$temp_folder:/usr/src" dotanuki-labs/callinectes fmt clippy

echo
echo "🔥 Checking MSRV"
echo
docker run --rm -v "$temp_folder:/usr/src" dotanuki-labs/callinectes msrv

echo
echo "🔥 Checking dependencies"
echo
docker run --rm -v "$temp_folder:/usr/src" dotanuki-labs/callinectes deny machete cyclonedx

echo
echo "✅ Done"
echo
