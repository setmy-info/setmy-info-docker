# Copyright Imre Tabur

TOMCAT_VERSION=10.0.13
ADDITIONAL_VERSION=0
DOCKER_PROJECT_NAME="setmy-info-rocky-java-tomcat"
#DOCKER_PROJECT_VERSION="$(TOMCAT_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(TOMCAT_VERSION)"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
TOMCAT_DIR_NAME=apache-tomcat-$(TOMCAT_VERSION)
TOMCAT_TAR_FILE_NAME=$(TOMCAT_DIR_NAME).tar.gz

all: download unpack build latest-tag show-images login push

download: $(TOMCAT_TAR_FILE_NAME)

$(TOMCAT_TAR_FILE_NAME):
	wget -c https://dlcdn.apache.org/tomcat/tomcat-10/v$(TOMCAT_VERSION)/bin/$(TOMCAT_TAR_FILE_NAME) -O $(TOMCAT_TAR_FILE_NAME)

unpack: $(TOMCAT_DIR_NAME)

$(TOMCAT_DIR_NAME):
	tar xvzf $(TOMCAT_TAR_FILE_NAME)

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
