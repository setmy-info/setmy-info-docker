# Copyright Imre Tabur

HSQLDB_VERSION=2.7.0
ADDITIONAL_VERSION=
DOCKER_PROJECT_NAME="setmy-info-rocky-java-hsqldb"
#DOCKER_PROJECT_VERSION="$(HSQLDB_VERSION)-$(ADDITIONAL_VERSION)"
DOCKER_PROJECT_VERSION="$(HSQLDB_VERSION)"
DOCKER_ID_ORGANIZATION="setmyinfo"
DOCKER_CONTENT_TRUST=1
HSQLDB_DIR_NAME=hsqldb-$(HSQLDB_VERSION)
HSQLDB_ZIP_FILE_NAME=$(HSQLDB_DIR_NAME).zip

all: download unpack build latest-tag show-images login push

download: $(HSQLDB_ZIP_FILE_NAME)

$(HSQLDB_ZIP_FILE_NAME):
	wget -c https://altushost-swe.dl.sourceforge.net/project/hsqldb/hsqldb/hsqldb_2_7/$(HSQLDB_ZIP_FILE_NAME)

unpack: $(HSQLDB_DIR_NAME)

$(HSQLDB_DIR_NAME):
	unzip $(HSQLDB_ZIP_FILE_NAME)

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
