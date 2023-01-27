FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Centos Java Infinispan" \
      org.opencontainers.image.description="setmy.info Docker HUB Centos Java Infinispan" \
      org.opencontainers.image.version="14.0.6" \
      org.opencontainers.image.revision="14.0.6" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY infinispan-server-14.0.6.Final /opt/infinispan-server
COPY src/infinispan-starter /opt/infinispan-server/bin
RUN chown -R root:root /opt/infinispan-server
RUN mkdir /opt/infinispan-server/server/data
RUN mkdir /opt/infinispan-server/server/logs
RUN chown -R microservice:microservice /opt/infinispan-server/server/data
RUN chown -R microservice:microservice /opt/infinispan-server/server/logs
ENV INFINISPAN_HOME /opt/infinispan-server
ENV PATH="${INFINISPAN_HOME}/bin:${PATH}"
RUN cd /opt/infinispan-server && ls -la
USER microservice
RUN whoami

WORKDIR /opt/infinispan-server

EXPOSE 11222/tcp 7800/tcp 11221/tcp 8080/tcp 9990/tcp

CMD ["/opt/infinispan-server/bin/infinispan-starter"]
