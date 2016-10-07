#!/usr/bin/env bash
##########################################################
# Builds all the docker images.

#
# see also: https://github.com/jupyter/docker-stacks/blob/master/Makefile
##########################################################

OWNER=matthiaskoenig
GIT_MASTER_HEAD_SHA=$(git rev-parse --short=12 --verify HEAD)

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

# build latest `linux-setup-base` image
DOCKER_BASE=linux-setup-base
docker build -t ${OWNER}/${DOCKER_BASE} ./${DOCKER_BASE}

# tag the latest stack image with the HEAD git SHA
docker tag ${OWNER}/${DOCKER_BASE}:latest ${OWNER}/${DOCKER_BASE}:${GIT_MASTER_HEAD_SHA}

# created images can be viewed with:
# docker images

# TODO: test

# push to docker hub
docker push ${OWNER}/${DOCKER_BASE}:latest
docker push ${OWNER}/${DOCKER_BASE}:$(GIT_MASTER_HEAD_SHA)

