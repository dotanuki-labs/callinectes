#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -e

readonly runner="$RUNNER_ARCH"
readonly docker_image="ghcr.io/dotanuki-labs/callinectes"

prepare_env_for_build() {
    case "$runner" in
    *ARM64*)
        echo "platform=arm64" >>"$GITHUB_OUTPUT"
        ;;
    *X64*)
        echo "platform=amd64" >>"$GITHUB_OUTPUT"
        ;;
    *)
        echo "Error: unsupported runner → $runner"
        exit 1
        ;;
    esac
}

merge_and_push_manifest() {
    local package="$docker_image:$argument"
    local latest="$docker_image:latest"

    docker manifest create "$latest" --amend "$package"-amd64 --amend "$package"-arm64
    docker manifest annotate --arch amd64 --os linux "$latest" "$package"-amd64
    docker manifest annotate --arch arm64 --os linux "$latest" "$package"-arm64
    docker manifest inspect "$latest"
    docker manifest push "$latest"
}

readonly task="$1"
readonly argument="$2"

case "$task" in
prepare-environment)
    prepare_env_for_build
    ;;
push-merged-manifest)
    merge_and_push_manifest
    ;;
*)
    echo "Error: unsupported task → $task"
    exit 1
    ;;
esac
