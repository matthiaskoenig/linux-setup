#!/usr/bin/env bash
VERSION=v0.1.1a

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

# make `linux-setup-base`
DOCKER_BASE=linux-setup-base
docker build -t ${DOCKER_BASE}:${VERSION} ./${DOCKER_BASE}

# push to docker hub

