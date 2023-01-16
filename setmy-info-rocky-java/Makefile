# Copyright Imre Tabur

JDK_VERSION=19.0.1
ADDITIONAL_VERSION=0
DOCKER_PROJECT_NAME="setmy-info-rocky-java"
#DOCKER_PROJECT_VERSION="$(JDK_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(JDK_VERSION)"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
JDK_DIR=jdk-$(JDK_VERSION)
JDK_TAR_FILE_NAME=openjdk-$(JDK_VERSION)_linux-x64_bin.tar.gz

all: download unpack build latest-tag show-images login push

download: $(JDK_TAR_FILE_NAME)

$(JDK_TAR_FILE_NAME):
	wget -c https://download.java.net/java/GA/jdk$(JDK_VERSION)/afdd2e245b014143b62ccb916125e3ce/10/GPL/$(JDK_TAR_FILE_NAME)

unpack: $(JDK_DIR)

$(JDK_DIR):
	tar xvzf $(JDK_TAR_FILE_NAME)

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
