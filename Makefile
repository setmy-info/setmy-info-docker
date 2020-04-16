
DOCKER_ID_USER="xxxxxx"
DOCKER_FOLDERS=docker-centos docker-centos-java docker-centos-java-tomcat docker-centos-nginx docker-centos-node docker-centos-java-zeebe docker-centos-java-infinispan

all: $(DOCKER_FOLDERS)

docker-centos:
	@cd $(@); pwd; $(MAKE)

docker-centos-java:
	@cd $(@); pwd; $(MAKE)

docker-centos-java-tomcat:
	@cd $(@); pwd; $(MAKE)

docker-centos-nginx:
	@cd $(@); pwd; $(MAKE)

docker-centos-node:
	@cd $(@); pwd; $(MAKE)

docker-centos-java-zeebe:
	@cd $(@); pwd; $(MAKE)

docker-centos-java-infinispan:
	@cd $(@); pwd; $(MAKE)

.PHONY: all $(DOCKER_FOLDERS)
