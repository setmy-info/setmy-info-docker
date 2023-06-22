FROM setmyinfo/setmy-info-rocky-java:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux HSQLDB" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux HSQLDB" \
      org.opencontainers.image.version="2.7.2" \
      org.opencontainers.image.revision="2.7.2" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@eesti.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

RUN mkdir -p /opt/hsqldb/bin && \
    mkdir -p /opt/hsqldb/lib &&  \
    mkdir -p /var/opt/hsqldb/data

COPY hsqldb-2.7.2/hsqldb/lib/hsqldb.jar /opt/hsqldb/lib/
COPY src/server /opt/hsqldb/bin
RUN chmod ugo+rx /opt/hsqldb/bin/* && \
    chown -R root:root /opt/hsqldb && \
    chown -R root:root /var/opt/hsqldb && \
    chown -R microservice:microservice /var/opt/hsqldb/data

WORKDIR /opt/hsqldb/bin

EXPOSE 9001/tcp

USER microservice

CMD ["/opt/hsqldb/bin/server", "run"]
