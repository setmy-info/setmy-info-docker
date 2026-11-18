ARG HSQLDB_VERSION
ARG H2_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG HSQLDB_VERSION

COPY ./hsqldb-${HSQLDB_VERSION}.zip /var/download/
WORKDIR /var/download
RUN dnf -y install unzip && \
    unzip /var/download/hsqldb-${HSQLDB_VERSION}.zip && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

ARG HSQLDB_VERSION
ARG H2_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Linux HSQLDB and H2" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux HSQLDB and H2" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-hsqldb" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-hsqldb" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

RUN mkdir -p /var/opt/hsqldb/data /var/opt/h2/data

COPY --from=BUILD /var/download/hsqldb-${HSQLDB_VERSION}/hsqldb/lib/hsqldb.jar /opt/hsqldb/lib/hsqldb.jar
COPY ./h2-${H2_VERSION}.jar /opt/h2/lib/h2.jar
COPY src/server /opt/hsqldb/bin/
RUN chmod ugo+rx /opt/hsqldb/bin/* && \
    chown -R root:root /opt/hsqldb && \
    chown -R root:root /var/opt/hsqldb && \
    chown -R microservice:microservice /var/opt/hsqldb/data && \
    chown -R root:root /opt/h2 && \
    chown -R root:root /var/opt/h2 && \
    chown -R microservice:microservice /var/opt/h2/data

WORKDIR /var/opt/hsqldb/data

EXPOSE 9001/tcp
EXPOSE 9092/tcp
EXPOSE 8082/tcp

USER microservice

ENTRYPOINT ["/opt/hsqldb/bin/server"]
CMD ["hsqldb", "microservicedb"]
