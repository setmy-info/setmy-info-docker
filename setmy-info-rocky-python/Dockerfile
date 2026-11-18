ARG PYTHON313_VERSION
ARG VERSION
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
    test -d /opt/python-${PYTHON313_VERSION} && \
    /opt/python313/bin/python3 --version && \
    mkdir -p /dist && \
    cp -a /opt/python /opt/python313 /opt/python-* /dist/

FROM setmyinfo/setmy-info-rocky:latest

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Python" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Python 3.13" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-python" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-python" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install glibc-langpack-en openssl-libs bzip2-libs libffi zlib readline sqlite-libs xz-libs && \
    dnf clean all && rm -rf /var/cache/dnf

COPY --from=BUILD /dist/ /opt/
RUN chown -R -H root:root /opt/python313 && \
    chmod ugo+rx /opt/python313/bin/*
ENV LANG=en_US.UTF-8
ENV PYTHON_HOME=/opt/python313
ENV PATH="${PYTHON_HOME}/bin:${PATH}"
RUN python3 --version && \
    python3 -c 'print("Hello, World!")'
