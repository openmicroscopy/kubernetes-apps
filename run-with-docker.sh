#!/bin/bash

# A helper script to start a Docker environment with kubectl helm helmfile
# preinstalled

if [ "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" != "$PWD" ]; then
    echo Must be run from script parent directory
    exit 2
fi

if [ $# -ne 1 ]; then
    echo USAGE $(basename $0) path/to/kube-config
    exit 1
fi

KUBECONFIG=$(realpath $1)
shift

exec docker run -it --rm \
    -v "$KUBECONFIG:/home/kube/.kube/config" \
    -v "$PWD/..:/k8s:ro" -w /k8s/apps \
    kube-helm-docker "$@"
