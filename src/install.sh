#!/bin/bash
set -euo pipefail

## env
export PATH="./bin:$PATH"

## main
logger -sp DEBUG -- "Enter"

kind delete cluster --name kind
kind create cluster --config config.yaml
kind get kubeconfig --name kind \
    | tee kubeconfig \
    | kubectl --kubeconfig /dev/stdin get nodes
