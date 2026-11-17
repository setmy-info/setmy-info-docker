ARG FREENGINX_VERSION=1.30.2
ARG VERSION=${FREENGINX_VERSION}
#ARG VERSION=${FREENGINX_VERSION}-0
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS BUILD

ARG FREENGINX_VERSION

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install epel-release && \
    dnf -y install mercurial gcc make pcre2-devel openssl-devel zlib-devel sudo && \
    mkdir -p $(smi-home-packages-location) && \
    printf '%s\n' \
        "FREENGINX_VERSION=${FREENGINX_VERSION}" \
        'FREENGINX_HG_TAG=release-${FREENGINX_VERSION}' \
        'FREENGINX_OPT_DIR=/opt/${FREENGINX_NAME}-${FREENGINX_VERSION}' \
        > $(smi-home-packages-location)/freenginx.package && \
    smi-download-package freenginx && \
    smi-build-package freenginx && \
    smi-install-package freenginx && \
    ls -la /opt && \
    /opt/freenginx-${FREENGINX_VERSION}/sbin/nginx -V

FROM setmyinfo/setmy-info-rocky:latest

ARG FREENGINX_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky freenginx" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with freenginx" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="BSD-2-Clause,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-freenginx" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-freenginx" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install pcre2 openssl-libs zlib && \
    dnf clean all && rm -rf /var/cache/dnf && \
    useradd nginx --shell /sbin/nologin --no-create-home

COPY --from=BUILD /opt/freenginx-${FREENGINX_VERSION} /opt/freenginx-${FREENGINX_VERSION}
RUN ln -sf /opt/freenginx-${FREENGINX_VERSION} /opt/freenginx

COPY ./opt/freenginx/conf/nginx.conf   /opt/freenginx/conf/nginx.conf
COPY ./opt/freenginx/conf/conf.d/      /opt/freenginx/conf/conf.d/
COPY ./usr/share/freenginx/www/        /usr/share/freenginx/www/

RUN chown -R root:root /opt/freenginx-${FREENGINX_VERSION} && \
    chown -R root:nginx /usr/share/freenginx/www && \
    chmod -R u+rX,g+rX,o+rX /usr/share/freenginx/www && \
    chmod -R u+r,go+r /opt/freenginx/conf && \
    chmod ugo+rx /opt/freenginx/sbin/nginx

ENV FREENGINX_HOME=/opt/freenginx
ENV PATH="${FREENGINX_HOME}/sbin:${PATH}"

RUN nginx -V

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
