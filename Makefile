
DOCKER_FOLDERS=setmy-info-centos setmy-info-centos-java setmy-info-centos-java-tomcat setmy-info-centos-nginx setmy-info-centos-node setmy-info-centos-java-zeebe setmy-info-centos-java-infinispan

all: $(DOCKER_FOLDERS)

setmy-info-centos:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-java:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-java-tomcat:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-nginx:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-node:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-java-zeebe:
	@cd $(@); pwd; $(MAKE)

setmy-info-centos-java-infinispan:
	@cd $(@); pwd; $(MAKE)

.PHONY: all $(DOCKER_FOLDERS)
