ARG JDK_VERSION=27.0.1.0.3
#ARG VERSION=${JDK_VERSION}
ARG VERSION=${JDK_VERSION}-1
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG JDK_VERSION

COPY ./openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz /var/download/
WORKDIR /var/download
RUN dnf -y install tar && \
    tar xvzf /var/download/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky:latest

ARG JDK_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Java" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

COPY --from=BUILD /var/download/jdk-${JDK_VERSION} /opt/jdk
RUN chown -R root:root /opt/jdk && \
    chmod ugo+rx /opt/jdk/bin/*
ENV JAVA_HOME=/opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN cd /opt/jdk && ls -la && java -version
