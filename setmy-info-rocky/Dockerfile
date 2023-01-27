FROM rockylinux/rockylinux:9.1

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB rocky" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux" \
      org.opencontainers.image.version="9.1-1" \
      org.opencontainers.image.revision="9.1-1" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

RUN dnf -y update && \
    cat /etc/rocky-release && \
    useradd microservice --shell /sbin/nologin --no-create-home && \
    mkdir -p /opt/has/bin && \
    mkdir -p /opt/has/lib && \
    mkdir -p /opt/has/doc && \
    mkdir -p /opt/has/man && \
    mkdir -p /opt/has/etc && \
    mkdir -p /var/opt/has && \
    mkdir -p /var/opt/has/microservice && \
    chown -R root:root /opt/has && \
    chown -R microservice:microservice /var/opt/has && \
    chmod -R u+rwx /opt/has && \
    chmod -R go+rx /opt/has && \
    chmod -R go-w  /opt/has && \
    cd /opt && ls -la && cd /opt/has && ls -la && cd /var/opt/ && ls -la && cd /var/opt/has && ls -la
