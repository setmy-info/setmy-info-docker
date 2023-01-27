FROM setmyinfo/setmy-info-rocky:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Centos Java" \
      org.opencontainers.image.description="setmy.info Docker HUB Centos Java" \
      org.opencontainers.image.version="19.0.2" \
      org.opencontainers.image.revision="19.0.2" \
	  org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
	  org.opencontainers.image.documentation="" \
      org.opencontainers.authors="Imre Tabur" \
      org.opencontainers.source="" \
      org.opencontainers.url="" \
      org.opencontainers.ref.name=""

COPY jdk-19.0.2 /opt/jdk
RUN chown -R root:root /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN cd /opt/jdk && ls -la && java -version
