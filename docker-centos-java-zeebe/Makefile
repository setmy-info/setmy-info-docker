# Copyright Imre Tabur

ZEEBE_VERSION=0.22.2
#ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME="setmy-info-centos-java-zeebe"
#DOCKER_PROJECT_VERSION="$(ZEEBE_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(ZEEBE_VERSION)"
DOCKER_ID_USER="xxxxxx"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
ZEEBE_DIR_NAME=zeebe-broker-$(ZEEBE_VERSION)
ZEEBE_TAR_FILE_NAME=zeebe-distribution-$(ZEEBE_VERSION).tar.gz

all: download unpack build image show-images login push

download: $(ZEEBE_TAR_FILE_NAME)

$(ZEEBE_TAR_FILE_NAME):
	wget -c https://github.com/zeebe-io/zeebe/releases/download/$(ZEEBE_VERSION)/zeebe-distribution-$(ZEEBE_VERSION).tar.gz

unpack: $(ZEEBE_DIR_NAME)

$(ZEEBE_DIR_NAME):
	tar xvzf $(ZEEBE_TAR_FILE_NAME)

build:
	docker build -t  "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)" .

image:
	docker image tag "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)" $(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):latest

show-images:
	docker images

login:
	docker login

push:
	docker image push $(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):latest
	docker image push "$(DOCKER_ID_ORGANIZATION)/$(DOCKER_PROJECT_NAME):$(DOCKER_PROJECT_VERSION)"

.PHONY: all download unpack build image show-images login push
