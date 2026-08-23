FROM rockylinux/rockylinux:10.2

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=10.2-4

ARG SMI_VERSION=0.112.1
ARG SBCL_VERSION=2.6.7

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name=""

COPY setmy-info-scripts-${SMI_VERSION}.noarch.rpm /tmp/
COPY sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2  /tmp/

RUN yum -y update && \
    yum -y install tar gzip bzip2 wget yum-utils && \
    rpm -i /tmp/setmy-info-scripts-${SMI_VERSION}.noarch.rpm && \
    mkdir /tmp/sbcl && \
    cd /tmp/sbcl && \
    pwd && \
    ls -la && \
    tar -xvf /tmp/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 -C /tmp/sbcl && \
    ls -la && \
    cd ./sbcl-${SBCL_VERSION}-x86-64-linux && \
    INSTALL_ROOT=/opt/sbcl sh install.sh && \
    rm -R /tmp/sbcl && \
#    useradd microservice --shell /sbin/nologin --no-create-home && \
    mkdir -p /opt/setmy.info/bin && \
    mkdir -p /opt/setmy.info/lib && \
    mkdir -p /opt/setmy.info/doc && \
    mkdir -p /opt/setmy.info/man && \
    mkdir -p /opt/setmy.info/etc && \
    mkdir -p /var/setmy.info/setmy.info && \
    mkdir -p /var/opt/setmy.info/microservice && \
    mkdir -p /var/opt/setmy.info/microservice/log && \
    chown -R root:root /opt/setmy.info && \
    chown -R microservice:microservice /var/opt/setmy.info && \
    chmod -R u+rwx /opt/setmy.info && \
    chmod -R go+rx /opt/setmy.info && \
    chmod -R go-w  /opt/setmy.info && \
    cd /opt && ls -la && cd /opt/setmy.info && ls -la && cd /var/opt/ && ls -la && cd /var/opt/setmy.info && ls -la

ENV SBCL_HOME=/opt/sbcl
ENV LD_LIBRARY_PATH=/opt/setmy.info/lib
ENV PYTHONPATH=/opt/setmy.info/lib
ENV PATH=/opt/setmy.info/bin:${SBCL_HOME}/bin:${PATH}

RUN source /etc/profile.d/setmy-info.sh && \
    cat /etc/redhat-release && \
    python3 --version && \
    sbcl --version && \
    curl --version && \
    smi-version
