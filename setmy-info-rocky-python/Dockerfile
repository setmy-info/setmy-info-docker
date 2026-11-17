ARG PYTHON313_VERSION=3.13.18
ARG VERSION=${PYTHON313_VERSION}
#ARG VERSION=${PYTHON313_VERSION}-0
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG PYTHON313_VERSION

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install tar gcc gcc-c++ make openssl-devel bzip2-devel libffi-devel \
                   zlib-devel readline-devel sqlite-devel xz-devel sudo glibc-langpack-en && \
    smi-download-package python313 && \
    smi-build-package python313 && \
    smi-install-package python313 && \
    ls -la /opt && \
    /opt/python-${PYTHON313_VERSION}/bin/python3 --version

FROM setmyinfo/setmy-info-rocky:latest

ARG PYTHON313_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Python" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Python 3.13" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-python" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-python" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install glibc-langpack-en openssl-libs bzip2-libs libffi zlib readline sqlite-libs xz-libs && \
    dnf clean all && rm -rf /var/cache/dnf

COPY --from=BUILD /opt/python-${PYTHON313_VERSION} /opt/python-${PYTHON313_VERSION}
RUN chown -R root:root /opt/python-${PYTHON313_VERSION} && \
    chmod ugo+rx /opt/python-${PYTHON313_VERSION}/bin/* && \
    ln -sf /opt/python-${PYTHON313_VERSION} /opt/python313 && \
    ln -sf /opt/python-${PYTHON313_VERSION} /opt/python-${PYTHON313_VERSION%.*} && \
    ln -sf /opt/python-${PYTHON313_VERSION} /opt/python
ENV LANG=en_US.UTF-8
ENV PYTHON_HOME=/opt/python313
ENV PATH="${PYTHON_HOME}/bin:${PATH}"
RUN python3 --version && \
    python3 -c 'print("Hello, World!")'
