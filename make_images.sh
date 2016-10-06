#!/usr/bin/env bash
##########################################################
# Builds all the docker images.
# The dependency tree of the images is
#
# linux-setup-base
#  |
#   --> linux-setup-combine
#        |
#         --> linux-setup-notebook
#
# see also: https://github.com/jupyter/docker-stacks/blob/master/Makefile
##########################################################

OWNER=matthiaskoenig
GIT_MASTER_HEAD_SHA=$(git rev-parse --short=12 --verify HEAD)

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}

# build latest `linux-setup-base` image
DOCKER_BASE=linux-setup-base
docker build -t ${DOCKER_BASE} ./${DOCKER_BASE}

##tag the latest stack image with the HEAD git SHA
docker tag -f ${DOCKER_BASE}:latest ${DOCKER_BASE}:${GIT_MASTER_HEAD_SHA}

# TODO: test

# TODO: push to docker hub

# Use commit for tagging


# docker push $(OWNER)/$(notdir $@):latest
# docker push $(OWNER)/$(notdir $@):$(GIT_MASTER_HEAD_SHA)

# 032014150ae6
