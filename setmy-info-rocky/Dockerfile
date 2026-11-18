ARG ROCKY_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG SMI_VERSION
ARG SBCL_VERSION

# Stage 1: unpack and install SBCL and Quicklisp, same as sbcl.package does
FROM rockylinux/rockylinux:${ROCKY_VERSION} AS build

ARG SBCL_VERSION

COPY sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 /var/download/
COPY quicklisp.lisp /var/download/
WORKDIR /var/download
RUN dnf -y install tar bzip2 && \
    tar -xvf /var/download/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 && \
    ls -la && \
    cd ./sbcl-${SBCL_VERSION}-x86-64-linux && \
    INSTALL_ROOT=/opt/sbcl-${SBCL_VERSION}-x86-64-linux sh install.sh && \
    ls -la /opt/sbcl-${SBCL_VERSION}-x86-64-linux && \
    /opt/sbcl-${SBCL_VERSION}-x86-64-linux/bin/sbcl \
      --no-sysinit --no-userinit --disable-debugger \
      --load /var/download/quicklisp.lisp \
      --eval '(quicklisp-quickstart:install :path "/opt/quicklisp/")' \
      --eval '(ql-util:without-prompting (ql:add-to-init-file))' \
      --quit && \
    mkdir -p /opt/quicklisp/lib && \
    cp /var/download/quicklisp.lisp /opt/quicklisp/lib/quicklisp.lisp && \
    ls -la /opt/quicklisp && \
    cat /root/.sbclrc

# Stage 2: final image
FROM rockylinux/rockylinux:${ROCKY_VERSION}

ARG ROCKY_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG SMI_VERSION
ARG SBCL_VERSION

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
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="rockylinux/rockylinux:${ROCKY_VERSION}"

COPY setmy-info-scripts-${SMI_VERSION}.noarch.rpm /tmp/
COPY --from=build /opt/sbcl-${SBCL_VERSION}-x86-64-linux /opt/sbcl-${SBCL_VERSION}-x86-64-linux
# Shared Quicklisp for all users. lib/quicklisp.lisp is where quicklisp-setup puts
# the bootstrap, for quicklisp-user-setup of a user who wants an own ~/quicklisp.
COPY --from=build /opt/quicklisp /opt/quicklisp
# Init file written by ql:add-to-init-file, as system wide init file for every user
COPY --from=build /root/.sbclrc /etc/sbclrc

RUN dnf -y update && \
    dnf -y install tar gzip bzip2 wget yum-utils && \
    dnf clean all && rm -rf /var/cache/dnf && \
    rpm -i /tmp/setmy-info-scripts-${SMI_VERSION}.noarch.rpm && \
    rm /tmp/setmy-info-scripts-${SMI_VERSION}.noarch.rpm && \
    ln -sf /opt/sbcl-${SBCL_VERSION}-x86-64-linux /opt/sbcl && \
    chown -R root:root /opt/sbcl-${SBCL_VERSION}-x86-64-linux /opt/quicklisp && \
    chmod -R go+rX /opt/quicklisp && \
    chown root:root /etc/sbclrc && \
    chmod 0644 /etc/sbclrc && \
    install -d -m 0700 -o microservice -g microservice "$(getent passwd microservice | cut -d: -f6)" && \
#    useradd microservice --shell /sbin/nologin --no-create-home && \
    mkdir -p /opt/setmy.info/doc && \
    mkdir -p /var/opt/setmy.info/microservice/log && \
    chown -R microservice:microservice /var/opt/setmy.info/microservice && \
    cd /opt && ls -la && cd /opt/setmy.info && ls -la && cd /var/opt/ && ls -la && cd /var/opt/setmy.info && ls -la

ENV SBCL_HOME=/opt/sbcl/lib/sbcl
ENV LD_LIBRARY_PATH=/opt/setmy.info/lib
ENV PYTHONPATH=/opt/setmy.info/lib
ENV PATH=/opt/setmy.info/bin:/opt/sbcl/bin:${PATH}

RUN source /etc/profile.d/setmy-info.sh && \
    cat /etc/redhat-release && \
    id microservice && \
    python3 --version && \
    sbcl --version && \
    sbcl --noinform --non-interactive --eval '(format t "Quicklisp ~a~%" (ql:client-version))' && \
    sbcl --noinform --non-interactive --eval '(format t "~a~%" (asdf:already-loaded-systems))' && \
    runuser -u microservice -- sbcl --noinform --non-interactive --eval '(format t "Quicklisp ~a as microservice~%" (ql:client-version))' && \
    curl --version && \
    smi-version
