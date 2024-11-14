# Makefile
# usage: run the "make" command in the root, than make <<cmd>>...
include $(wildcard lib/make/*.mk)
include $(wildcard src/make/*.mk)

# set ALL of your global variables here, setting vars in functions outsite the funcs does not work
BUILD_NUMBER := $(if $(BUILD_NUMBER),$(BUILD_NUMBER),"0")
COMMIT_SHA := $(if $(COMMIT_SHA),$(COMMIT_SHA),$$(git rev-parse --short HEAD))
COMMIT_MESSAGE := $(if $(COMMIT_MESSAGE),$(COMMIT_MESSAGE),$$(git log -1  --pretty='%s'))
DOCKER_BUILDKIT := $(or 0,$(shell echo $$DOCKER_BUILDKIT))


SHELL = bash
PROJ := $(shell basename $$PWD)
product := $(shell echo `basename $$PWD`|tr '[:upper:]' '[:lower:]')
PROCESSOR_ARCHITECTURE := $(shell uname -m)
ORG_DIR := $(shell basename $(dir $(abspath $(dir $$PWD))))
org_dir := $(shell echo ${ORG_DIR}|tr '[:upper:]' '[:lower:]')
BASE_PATH := $(shell source $$PWD/lib/bash/funcs/resolve-dirname.func.sh ; resolve_dirname $$PWD"/../" )
PROJ_PATH := $(shell echo $$PWD)
PYTHON_DIR := $(PROJ_PATH)/src/python/$(product)

APPUSR := appusr
APPGRP := appgrp
ROOT_DOCKER_NAME = ${ORG_DIR}-${product}
MOUNT_WORK_DIR := $(BASE_PATH)/$(ORG_DIR)
HOST_AWS_DIR := $$HOME/.aws
DOCKER_AWS_DIR := /home/${APPUSR}/.aws
HOST_SSH_DIR := $$HOME/.ssh
DOCKER_SSH_DIR := /home/${APPUSR}/.ssh
HOST_KUBE_DIR := $$HOME/.kube
DOCKER_KUBE_DIR := /home/${APPUSR}/.kube

# dockerfile variables
PROJ_PATH := $(BASE_PATH)/$(ORG_DIR)/$(PROJ)
HOME_PROJ_PATH := "/home/$(APPUSR)$(BASE_PATH)/$(ORG_DIR)/$(PROJ)"
DOCKER_HOME := /home/$(APPUSR)
DOCKER_SHELL := /bin/$(SHELL)
RUN_SCRIPT := $(HOME_PROJ_PATH)/run
DOCKER_INIT_SCRIPT := $(HOME_PROJ_PATH)/src/bash/run/docker-init-$(PROJ).sh

UID := $(shell id -u)
GID := $(shell id -g)

TPL_GEN_PORT=

.PHONY: bar ## @-> bar both the tpl-gen and the tpl-gen containers
bar:
	@echo BASE_PATH:
	@echo $(BASE_PATH)
	@echo BASE_PATH as shell var:
	@echo ${BASE_PATH}
	@echo PROJ_PATH
	@echo $(PROJ_PATH)
	@echo MOUNT_WORK_DIR:
	@echo $(MOUNT_WORK_DIR)

.PHONY: install ## @-> install both the tpl-gen and the tpl-gen containers
install:
	@clear
	make clean-install-$(product)
