# Copyright Imre Tabur

JDK_VERSION=12.0.2
ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME="setmy-info-centos-java"
DOCKER_PROJECT_VERSION="v$(JDK_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_ID_USER="xxxxxx"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
JDK_DIR=jdk-$(JDK_VERSION)
JDK_TAR_FILE_NAME=openjdk-$(JDK_VERSION)_linux-x64_bin.tar.gz

all: download unback build image show-images login push

download: $(JDK_TAR_FILE_NAME)

$(JDK_TAR_FILE_NAME):
	wget -c https://download.java.net/java/GA/jdk$(JDK_VERSION)/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/$(JDK_TAR_FILE_NAME) -O $(JDK_TAR_FILE_NAME)

unback: $(JDK_DIR)

$(JDK_DIR):
	tar xvzf $(JDK_TAR_FILE_NAME)

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
