ARG INFINISPAN_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS build

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

LABEL org.opencontainers.image.title="Docker HUB Rocky Java Infinispan" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java Infinispan" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-infinispan" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-infinispan" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

COPY --from=build /var/download/infinispan-server-${INFINISPAN_VERSION} /opt/infinispan-server-${INFINISPAN_VERSION}
COPY src/infinispan-starter /opt/infinispan-server-${INFINISPAN_VERSION}/bin/
RUN ln -sf /opt/infinispan-server-${INFINISPAN_VERSION} /opt/infinispan && \
    chown -R root:root /opt/infinispan/ && \
    mkdir -p /opt/infinispan/server && \
    mkdir -p /opt/infinispan/server/log && \
    mkdir -p /var/opt/infinispan && \
    chown -R microservice:microservice /var/opt/infinispan && \
    chown -R microservice:microservice /opt/infinispan/server && \
    cd /opt/infinispan && \
    ls -la

ENV PATH="/opt/infinispan/bin:${PATH}"

USER microservice

WORKDIR /var/opt/infinispan

EXPOSE 11222/tcp 7800/tcp 11221/tcp 8080/tcp 9990/tcp

CMD ["infinispan-starter"]
