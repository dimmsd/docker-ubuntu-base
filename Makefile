#!/usr/bin/make

SHELL = /bin/sh

.DEFAULT_GOAL := help
.PHONY : help build build-s build-ds make-squash run

cnf ?= .env

ifneq ("$(wildcard $(cnf))","")
include $(cnf)
else
$(error "ERROR! File .env not found. Rename .env.example => .env")
endif

build-ds: build make-squash

help:
	@echo "Help:"
	@echo "\tbuild - build $(BASE_IMAGE):$(UBUNTU_VERSION) image"
	@echo "\tbuild-s - build $(BASE_IMAGE):$(UBUNTU_VERSION)-squash image with --squash option"
	@echo "\tbuild-ds - build image $(BASE_IMAGE):$(UBUNTU_VERSION)-squashed with docker-squash"
	@echo "\trun - run image $(BASE_IMAGE):$(UBUNTU_VERSION)-squashed and start interactive bash session"
build:
	@docker build --build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
                      -t $(BASE_IMAGE):$(UBUNTU_VERSION) .
build-s:
	@docker build --squash \
                      --build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
                      -t $(BASE_IMAGE):$(UBUNTU_VERSION)-squash .
make-squash:
	@docker-squash -t $(BASE_IMAGE):$(UBUNTU_VERSION)-squashed $(BASE_IMAGE):$(UBUNTU_VERSION)
run:
	@docker run --rm --name con-$(BASE_IMAGE) -it $(BASE_IMAGE):$(UBUNTU_VERSION)-squashed bash

