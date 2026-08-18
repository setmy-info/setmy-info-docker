FROM setmyinfo/setmy-info-rocky:latest

ARG NODE_VERSION=24.19.0

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=${NODE_VERSION}-2

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky NodeJS" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Node" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-node" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-node" \
      org.opencontainers.image.ref.name="rocky-node:${VERSION}" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

COPY node-v${NODE_VERSION}-linux-x64 /opt/node
RUN useradd node --shell /sbin/nologin --no-create-home && \
    chown -R root:root /opt/node && \
    chmod ugo+rx /opt/node/bin/*
ENV NODE_HOME=/opt/node
ENV PATH="${NODE_HOME}/bin:${PATH}"
RUN cd /opt/node && ls -la && node --version
