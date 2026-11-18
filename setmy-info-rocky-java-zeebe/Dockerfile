ARG ZEEBE_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS build

ARG ZEEBE_VERSION

COPY ./camunda-zeebe-${ZEEBE_VERSION}.tar.gz /var/download/
WORKDIR /var/download
RUN tar xvzf /var/download/camunda-zeebe-${ZEEBE_VERSION}.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

ARG ZEEBE_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Java Zeebe" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java Zeebe" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-zeebe" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-zeebe" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

COPY --from=build /var/download/camunda-zeebe-${ZEEBE_VERSION} /opt/camunda-zeebe-${ZEEBE_VERSION}
COPY src/zeebe-starter /opt/camunda-zeebe-${ZEEBE_VERSION}/bin/
RUN ln -sf /opt/camunda-zeebe-${ZEEBE_VERSION} /opt/zeebe && \
    chown -R root:root /opt/zeebe/ && \
    mkdir /opt/zeebe/data && \
    mkdir /opt/zeebe/logs && \
    chown -R microservice:microservice /opt/zeebe/data && \
    chown -R microservice:microservice /opt/zeebe/logs
ENV ZEEBE_HOME=/opt/zeebe
ENV PATH="${ZEEBE_HOME}/bin:${PATH}"
RUN cd /opt/zeebe && ls -la
USER microservice
RUN whoami

WORKDIR /opt/zeebe

#TODO
#VOLUME /opt/zeebe/data

EXPOSE 26500/tcp 26501/tcp 26502/tcp 8080/tcp 9600/tcp

CMD ["/opt/zeebe/bin/zeebe-starter"]
