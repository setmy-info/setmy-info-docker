FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos Java Infinispan" \
      org.label-schema.version="12.1.4" \
      org.label-schema.description="setmy.info Docker HUB Centos Java Infinispan" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

COPY infinispan-server-12.1.4.Final /opt/infinispan-server
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
