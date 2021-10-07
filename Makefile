
DOCKER_FOLDERS=setmy-info-rocky setmy-info-rocky-java setmy-info-rocky-java-tomcat setmy-info-rocky-nginx setmy-info-rocky-node setmy-info-rocky-java-zeebe setmy-info-rocky-java-infinispan

all: $(DOCKER_FOLDERS)

setmy-info-rocky:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-java:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-java-tomcat:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-nginx:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-node:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-java-zeebe:
	@cd $(@); pwd; $(MAKE)

setmy-info-rocky-java-infinispan:
	@cd $(@); pwd; $(MAKE)

.PHONY: all $(DOCKER_FOLDERS)
