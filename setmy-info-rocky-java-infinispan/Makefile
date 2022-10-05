# Copyright Imre Tabur

INFINISPAN_VERSION=14.0.0
#ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME="setmy-info-rocky-java-infinispan"
#DOCKER_PROJECT_VERSION="$(INFINISPAN_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(INFINISPAN_VERSION)"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
INFINISPAN_DIR_NAME=infinispan-server-$(INFINISPAN_VERSION).Final
INFINISPAN_ZIP_FILE_NAME=infinispan-server-$(INFINISPAN_VERSION).Final.zip

all: download unpack build latest-tag show-images login push

download: $(INFINISPAN_ZIP_FILE_NAME)

$(INFINISPAN_ZIP_FILE_NAME):
	wget -c https://downloads.jboss.org/infinispan/$(INFINISPAN_VERSION).Final/$(INFINISPAN_ZIP_FILE_NAME)

unpack: $(INFINISPAN_DIR_NAME)

$(INFINISPAN_DIR_NAME):
	unzip $(INFINISPAN_ZIP_FILE_NAME)

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
