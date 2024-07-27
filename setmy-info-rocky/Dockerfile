FROM rockylinux/rockylinux:9.4

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux" \
      org.opencontainers.image.version="9.4-3" \
      org.opencontainers.image.revision="9.4-3" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY setmy-info-scripts-0.80.1.noarch.rpm /tmp/
COPY sbcl-2.4.6-x86-64-linux-binary.tar.bz2  /tmp/

RUN yum -y update && \
    yum -y install tar gzip bzip2 wget yum-utils && \
    rpm -i /tmp/setmy-info-scripts-0.80.1.noarch.rpm && \
    mkdir /tmp/sbcl && \
    cd /tmp/sbcl && \
    pwd && \
    ls -la && \
    tar -xvf /tmp/sbcl-2.4.6-x86-64-linux-binary.tar.bz2 -C /tmp/sbcl && \
    ls -la && \
    cd ./sbcl-2.4.6-x86-64-linux && \
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
