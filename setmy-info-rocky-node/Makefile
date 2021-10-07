# Copyright Imre Tabur

NODE_VERSION=16.3.0
ADDITIONAL_VERSION=0
DOCKER_PROJECT_NAME="setmy-info-centos-node"
#DOCKER_PROJECT_VERSION="$(NODE_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(NODE_VERSION)"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
NODE_DIR_NAME=node-v$(NODE_VERSION)-linux-x64
NODE_TAR_FILE_NAME=$(NODE_DIR_NAME).tar.xz

all: download unpack build latest-tag show-images login push

download: $(NODE_TAR_FILE_NAME)

$(NODE_TAR_FILE_NAME):
	wget -c https://nodejs.org/dist/v$(NODE_VERSION)/$(NODE_TAR_FILE_NAME) -O $(NODE_TAR_FILE_NAME)

unpack: $(NODE_DIR_NAME)

$(NODE_DIR_NAME):
	tar xvJf $(NODE_TAR_FILE_NAME)

build:
	docker build -t  "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)" .

latest-tag:
	docker image tag "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)" $(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):latest

show-images:
	docker images

login:
	docker login

push:
	docker image push $(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):latest
	docker image push "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)"

.PHONY: all download unpack build latest-tag show-images login push
