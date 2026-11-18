ARG FREENGINX_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS build

ARG FREENGINX_VERSION

RUN source /etc/profile.d/setmy-info.sh && \
    dnf -y install epel-release && \
    dnf -y install mercurial gcc make pcre2-devel openssl-devel zlib-devel sudo && \
    mkdir -p $(smi-home-packages-location) && \
    smi-download-package freenginx && \
    smi-build-package freenginx && \
    smi-install-package freenginx && \
    ls -la /opt && \
    test -d /opt/freenginx-${FREENGINX_VERSION} && \
    /opt/freenginx/sbin/nginx -V && \
    mkdir -p /dist && \
    cp -a /opt/freenginx /opt/freenginx-* /dist/

FROM setmyinfo/setmy-info-rocky:latest

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky freenginx" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux with freenginx" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="BSD-2-Clause,MIT" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-freenginx" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-freenginx" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

RUN dnf -y install pcre2 openssl-libs zlib && \
    dnf clean all && rm -rf /var/cache/dnf && \
    useradd nginx --shell /sbin/nologin --no-create-home

COPY --from=build /dist/ /opt/

COPY ./opt/freenginx/conf/nginx.conf   /opt/freenginx/conf/nginx.conf
COPY ./opt/freenginx/conf/conf.d/      /opt/freenginx/conf/conf.d/
COPY ./usr/share/freenginx/www/        /usr/share/freenginx/www/

RUN chown -R -H root:root /opt/freenginx && \
    chown -R root:nginx /usr/share/freenginx/www && \
    chmod -R u+rX,g+rX,o+rX /usr/share/freenginx/www && \
    chmod -R u+r,go+r /opt/freenginx/conf && \
    chmod ugo+rx /opt/freenginx/sbin/nginx && \
    mkdir -p /opt/freenginx/logs && \
    ln -sf /dev/stdout /opt/freenginx/logs/access.log && \
    ln -sf /dev/stderr /opt/freenginx/logs/error.log

ENV FREENGINX_HOME=/opt/freenginx
ENV PATH="${FREENGINX_HOME}/sbin:${PATH}"

RUN nginx -V

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
