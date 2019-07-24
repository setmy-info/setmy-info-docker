# Copyright Imre Tabur

TOMCAT_VERSION=9.0.22
ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME="setmy-info-centos-java-tomcat"
DOCKER_PROJECT_VERSION="v$(TOMCAT_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_ID_USER="xxxxxx"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
TOMCAT_DIR_NAME=apache-tomcat-$(TOMCAT_VERSION)
TOMCAT_TAR_FILE_NAME=$(TOMCAT_DIR_NAME).tar.gz

all: download unback build image show-images login push

download: $(TOMCAT_TAR_FILE_NAME)

$(TOMCAT_TAR_FILE_NAME):
	wget -c https://www-eu.apache.org/dist/tomcat/tomcat-9/v$(TOMCAT_VERSION)/bin/$(TOMCAT_TAR_FILE_NAME) -O $(TOMCAT_TAR_FILE_NAME)

unback: $(TOMCAT_DIR_NAME)

$(TOMCAT_DIR_NAME):
	tar xvzf $(TOMCAT_TAR_FILE_NAME)

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

.PHONY: all download unback build image show-images login push
