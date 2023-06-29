FROM setmyinfo/setmy-info-rocky:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky NodeJS" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Node" \
      org.opencontainers.image.version="18.16.1-2" \
      org.opencontainers.image.revision="18.16.1-2" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@eesti.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY node-v18.16.1-linux-x64 /opt/node
RUN useradd node --shell /sbin/nologin --no-create-home && \
    chown -R root:root /opt/node && \
    chmod ugo+rx /opt/node/bin/*
ENV NODE_HOME /opt/node
ENV PATH="${NODE_HOME}/bin:${PATH}"
RUN cd /opt/node && ls -la && node --version
