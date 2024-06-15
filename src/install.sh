#!/bin/bash
set -euo pipefail

## env
export PATH="./bin:$PATH"

## main
logger -sp DEBUG -- "Enter" "checksum=$(cat checksum)"

kind delete cluster
kind create cluster --verbosity 9 \
                    --config config.yaml
kind get kubeconfig  \
    | tee kubeconfig \
    | kubectl --kubeconfig /dev/stdin get nodes
