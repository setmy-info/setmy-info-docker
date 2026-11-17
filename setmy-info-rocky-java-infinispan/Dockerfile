ARG INFINISPAN_VERSION=16.3.1
ARG VERSION=${INFINISPAN_VERSION}
#ARG VERSION=${INFINISPAN_VERSION}-4
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG INFINISPAN_VERSION

COPY ./infinispan-server-${INFINISPAN_VERSION}.zip /var/download/
WORKDIR /var/download
RUN dnf -y install unzip && \
    unzip /var/download/infinispan-server-${INFINISPAN_VERSION}.zip && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

ARG INFINISPAN_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Java Infinispan" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java Infinispan" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-infinispan" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-infinispan" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

COPY --from=BUILD /var/download/infinispan-server-${INFINISPAN_VERSION} /opt/infinispan-server
COPY src/infinispan-starter /opt/infinispan-server/bin
RUN chown -R root:root /opt/infinispan-server && \
    mkdir -p /opt/infinispan-server/server && \
    mkdir -p /opt/infinispan-server/server/log && \
    mkdir -p /var/opt/infinispan-server && \
    chown -R microservice:microservice /var/opt/infinispan-server && \
    chown -R microservice:microservice /opt/infinispan-server/server && \
    cd /opt/infinispan-server && \
    ls -la && \
    /opt/infinispan-server/bin/cli.sh user create admin -p admin -g admin

ENV PATH="/opt/infinispan-server/bin:${PATH}"

USER microservice

WORKDIR /var/opt/infinispan-server

EXPOSE 11222/tcp 7800/tcp 11221/tcp 8080/tcp 9990/tcp

CMD ["infinispan-starter"]
