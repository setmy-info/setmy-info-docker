FROM setmyinfo/setmy-info-rocky:latest

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1.30.4-3
# https://nginx.org/packages/centos/10/x86_64/RPMS/

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Nginx" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Node" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="BSD-2-Clause,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-nginx" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-nginx" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky:latest"

COPY ./etc/yum.repos.d/nginx.repo     /etc/yum.repos.d/nginx.repo
COPY ./usr/share/nginx/www/index.html /usr/share/nginx/www/index.html
COPY ./usr/share/nginx/www/error.html /usr/share/nginx/www/error.html
COPY ./usr/share/nginx/www/favicon.ico /usr/share/nginx/www/favicon.ico

RUN dnf -y update && \
    rpm --import https://nginx.org/keys/nginx_signing.key && \
    dnf -y install nginx && \
    #yum-config-manager --enable nginx-mainline && \
    ls -la /etc/nginx/ && \
    ls -la /etc/nginx/conf.d && \
    cat /etc/nginx/nginx.conf && \
    #cat /etc/nginx/nginx.conf.default && \
    cat /etc/nginx/conf.d/default.conf && \
    dnf clean all && rm -rf /var/cache/dnf

COPY ./etc/nginx/conf.d/             /etc/nginx/conf.d/

RUN chown -R root:nginx /usr/share/nginx/www && \
    chmod -R u+rX,g+rX,o+rX /usr/share/nginx/www && \
    chmod -R u+r,go+r /etc/nginx

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
