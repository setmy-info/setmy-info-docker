FROM setmyinfo/setmy-info-rocky-java:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Java Zeebe" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java Zeebe" \
      org.opencontainers.image.version="8.5.5-1" \
      org.opencontainers.image.revision="8.5.5-1" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY camunda-zeebe-8.5.5 /opt/zeebe-broker
COPY src/zeebe-starter /opt/zeebe-broker/bin
RUN chown -R root:root /opt/zeebe-broker && \
    mkdir /opt/zeebe-broker/data && \
    mkdir /opt/zeebe-broker/logs && \
    chown -R microservice:microservice /opt/zeebe-broker/data && \
    chown -R microservice:microservice /opt/zeebe-broker/logs
ENV ZEEBE_HOME /opt/zeebe-broker
ENV PATH="${ZEEBE_HOME}/bin:${PATH}"
RUN cd /opt/zeebe-broker && ls -la
USER microservice
RUN whoami

WORKDIR /opt/zeebe-broker

#TODO
#VOLUME /opt/zeebe-broker/data

EXPOSE 26500/tcp 26501/tcp 26502/tcp

CMD ["/opt/zeebe-broker/bin/zeebe-starter"]
