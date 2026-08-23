FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG BUILD_DATE
ARG VCS_REF
ARG PYTHON314_VERSION=3.14.7

# Install Python build dependencies.
# glibc-langpack-en ensures UTF-8 locale is available during build.
RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install git gcc gcc-c++ make openssl-devel bzip2-devel libffi-devel \
                   zlib-devel readline-devel sqlite-devel xz-devel sudo glibc-langpack-en && \
    smi-download-package python314 && \
    smi-install-package python314 && \
    dnf clean all && rm -rf /var/cache/dnf

FROM setmyinfo/setmy-info-rocky:latest

ARG BUILD_DATE
ARG VCS_REF
ARG PYTHON314_VERSION=3.14.7
ARG VERSION=1-1

LABEL org.opencontainers.image.title="Docker HUB Rocky Python" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with Python 3.14" \
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

# Install runtime libraries that the compiled Python binary links against.
# The -devel packages stay in the BUILD stage; only the shared libs are needed here.
RUN dnf -y install glibc-langpack-en openssl-libs bzip2-libs libffi zlib readline sqlite-libs xz-libs && \
    dnf clean all && rm -rf /var/cache/dnf

COPY --from=BUILD /opt/python-${PYTHON314_VERSION} /opt/python-${PYTHON314_VERSION}

RUN ln -sf /opt/python-${PYTHON314_VERSION} /opt/python314 && \
    ln -sf /opt/python-${PYTHON314_VERSION} /opt/python && \
    chown -R root:root /opt/python-${PYTHON314_VERSION} && \
    chmod ugo+rx /opt/python-${PYTHON314_VERSION}/bin/*

ENV LANG=en_US.UTF-8
ENV PYTHON_HOME=/opt/python314
ENV PATH="${PYTHON_HOME}/bin:${PATH}"

RUN python3 --version && \
    python3 -c 'print("Hello, World!")'
