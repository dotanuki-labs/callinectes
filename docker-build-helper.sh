#! /usr/bin/env bash
# Copyright 2024 Dotanuki Labs
# SPDX-License-Identifier: MIT

set -e

readonly runner="$RUNNER_NAME"

prepare_env_for_build() {
    case "$runner" in
    *arm64*)
        echo "platform=arm64" >>"$GITHUB_OUTPUT"
        ;;
    *amd64*)
        echo "platform=amd64" >>"$GITHUB_OUTPUT"
        ;;
    *)
        echo "Error: unsupported runner → $runner"
        exit 1
        ;;
    esac
}

collect_digest() {
    local
    mkdir -p /tmp/digests
    digest="$argument"
    touch "/tmp/digests/$digest#sha256"
}

merge_and_push_manifest() {
    local merged
    merged=$(jq -cr '.tags | map("-t " + .) | join(" ")' <<<"$DOCKER_METADATA_OUTPUT_JSON")

    local name
    name=$(printf "$argument@sha256:%s " *)
    docker buildx imagetools create "$merged" "$name"
}

readonly task="$1"
readonly argument="$2"

case "$task" in
prepare-environment)
    prepare_env_for_build
    ;;
collect-digest)
    collect_build_digest
    ;;
update-manifest)
    merge_and_push_manifest
    ;;
*)
    echo "Error: unsupported task → $task"
    exit 1
    ;;
esac
