# Copyright Imre Tabur

ROCKY_VERSION="9"
ADDITIONAL_VERSION=0
DOCKER_PROJECT_NAME="setmy-info-rocky"
#DOCKER_PROJECT_VERSION="$(ROCKY_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(ROCKY_VERSION)"

DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1

all: build latest-tag show-images login push

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

.PHONY: all build latest-tag show-images login push
