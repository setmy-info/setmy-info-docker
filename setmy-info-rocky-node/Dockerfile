ARG NODE_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG NODE_VERSION

COPY ./node-v${NODE_VERSION}-linux-x64.tar.xz /var/download/
WORKDIR /var/download
RUN dnf -y install xz && \
    tar xvJf /var/download/node-v${NODE_VERSION}-linux-x64.tar.xz && \
    ls -la

FROM setmyinfo/setmy-info-rocky:latest

ARG NODE_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky NodeJS" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Node" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-node" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-node" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

COPY --from=BUILD /var/download/node-v${NODE_VERSION}-linux-x64 /opt/node-v${NODE_VERSION}-linux-x64
RUN ln -sf /opt/node-v${NODE_VERSION}-linux-x64 /opt/node && \
    useradd node --shell /sbin/nologin --no-create-home && \
    chown -R root:root /opt/node/ && \
    chmod ugo+rx /opt/node/bin/* && \
    dnf -y install libatomic && \
    dnf clean all && rm -rf /var/cache/dnf
ENV NODE_HOME=/opt/node
ENV PATH="${NODE_HOME}/bin:${PATH}"
RUN cd /opt/node && ls -la && node --version && id node
