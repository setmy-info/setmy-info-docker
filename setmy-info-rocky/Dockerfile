FROM rockylinux/rockylinux:9.1

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB rocky" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux" \
      org.opencontainers.image.version="9.1-3" \
      org.opencontainers.image.revision="9.1-3" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@eesti.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY setmy-info-scripts-0.51.0.noarch.rpm /tmp/

RUN dnf -y update && \
    dnf -y install tar gzip bzip2 wget && \
    rpm -i /tmp/setmy-info-scripts-0.51.0.noarch.rpm && \
    mkdir /tmp/sbcl && \
    cd /tmp/sbcl && \
    pwd && \
    curl https://deac-ams.dl.sourceforge.net/project/sbcl/sbcl/2.3.0/sbcl-2.3.0-x86-64-linux-binary.tar.bz2 --output sbcl-2.3.0-x86-64-linux-binary.tar.bz2 && \
    ls -la && \
    tar -xvf sbcl-2.3.0-x86-64-linux-binary.tar.bz2 -C /tmp/sbcl && \
    ls -la && \
    cd ./sbcl-2.3.0-x86-64-linux && \
    INSTALL_ROOT=/opt/sbcl sh install.sh && \
    rm -R /tmp/sbcl && \
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

ENV SBCL_HOME=/opt/sbcl
ENV LD_LIBRARY_PATH=/opt/has/lib
ENV PYTHONPATH=/opt/has/lib
ENV PATH=${SBCL_HOME}/bin:${PATH}

RUN source /etc/profile.d/setmy-info.sh && \
    cat /etc/redhat-release && \
    python3 --version && \
    sbcl --version && \
    curl --version && \
    smi-version
