################################################### 
# Makefile for docker images.
#
# Handles the image creation, tagging, testing,
# and pushing of the images to docker hub.
#
# Inspired by
# https://github.com/jupyter/docker-stacks/blob/master/Makefile
#
# Copyright (c) Matthias Koenig
# Distributed under LGPLv3
###################################################

# special targets not associated with files
.PHONY: build-all help release-all

# Use bash for inline if-statements in test target
SHELL:=bash
OWNER:=matthiaskoenig

# need to list these manually because there's a dependency tree
ALL_STACKS:=linux-setup-base \
	linux-setup-combine \
	linux-setup-notebook

ALL_IMAGES:=$(ALL_STACKS)

GIT_MASTER_HEAD_SHA:=$(shell git rev-parse --short=12 --verify HEAD)

RETRIES:=10

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@echo "matthiaskoenig/linux-setup"
	@echo "=========================="
	@echo "Replace % with a stack directory name (e.g., make build/minimal-notebook)"
	@echo
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build/%: DARGS?=
build/%: ## build the latest image for a stack
#	docker build $(DARGS) --rm --force-rm -t $(OWNER)/$(notdir $@):latest ./$(notdir $@)
	docker build $(DARGS) --no-cache --rm --force-rm -t $(OWNER)/$(notdir $@):latest ./$(notdir $@)

build-all: $(ALL_IMAGES:%=build/%) ## build all stacks


test/%: ## test the created image
	exit 1

test-all: $(ALL_IMAGES:%=test/%) ## test all stacks


build-test-all: $(foreach I,$(ALL_IMAGES),build/$(I) test/$(I) ) ## build and test all stacks


refresh/%: ## pull the latest image from Docker Hub for a stack
# skip if error: a stack might not be on dockerhub yet
	-docker pull $(OWNER)/$(notdir $@):latest

refresh-all: $(ALL_IMAGES:%=refresh/%) ## refresh all stacks


tag/%: ## tag the latest stack image with the HEAD git SHA
	docker tag -f $(OWNER)/$(notdir $@):latest $(OWNER)/$(notdir $@):$(GIT_MASTER_HEAD_SHA)

tag-all: $(ALL_IMAGES:%=tag/%) ## tag all stacks

push/%: ## push the latest and HEAD git SHA tags for a stack to Docker Hub
	docker push $(OWNER)/$(notdir $@):latest
	docker push $(OWNER)/$(notdir $@):$(GIT_MASTER_HEAD_SHA)

push-all: $(ALL_IMAGES:%=push/%) ## push all stacks


release-all: refresh-all \
	build-test-all \
	tag-all \
	push-all
release-all: ## build, test, tag, and push all stacks


