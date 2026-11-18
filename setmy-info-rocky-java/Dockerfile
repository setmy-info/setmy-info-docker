ARG JDK_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS build

ARG JDK_VERSION

COPY ./openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz /var/download/
WORKDIR /var/download
RUN tar xvzf /var/download/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky:latest

ARG JDK_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Java" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

COPY --from=build /var/download/jdk-${JDK_VERSION} /opt/jdk-${JDK_VERSION}
RUN ln -sf /opt/jdk-${JDK_VERSION} /opt/jdk && \
    chown -R root:root /opt/jdk/ && \
    chmod ugo+rx /opt/jdk/bin/*
ENV JAVA_HOME=/opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN cd /opt/jdk && ls -la && java -version
