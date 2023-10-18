FROM setmyinfo/setmy-info-rocky:latest as BUILD

COPY ./openjdk-21.0.1_linux-x64_bin.tar.gz /var/download/
WORKDIR /var/download
RUN dnf -y install tar && \
    tar xvzf /var/download/openjdk-21.0.1_linux-x64_bin.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Java" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Java" \
      org.opencontainers.image.version="21.0.1" \
      org.opencontainers.image.revision="21.0.1" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY --from=BUILD /var/download/jdk-21.0.1 /opt/jdk
RUN chown -R root:root /opt/jdk && \
    chmod ugo+rx /opt/jdk/bin/*
ENV JAVA_HOME /opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN cd /opt/jdk && ls -la && java -version
