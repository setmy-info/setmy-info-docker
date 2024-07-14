FROM setmyinfo/setmy-info-rocky:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Nginx" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Node" \
      org.opencontainers.image.version="1.24.0-9" \
      org.opencontainers.image.revision="1.24.0-9" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY ./etc/yum.repos.d/nginx.repo     /etc/yum.repos.d/nginx.repo
COPY ./usr/share/nginx/www/index.html /usr/share/nginx/www/index.html
COPY ./usr/share/nginx/www/error.html /usr/share/nginx/www/error.html

RUN dnf -y update && \
    rpm --import https://nginx.org/keys/nginx_signing.key && \
    dnf -y install nginx && \
    #yum-config-manager --enable nginx-mainline && \
    ls -la /etc/nginx/ && \
    ls -la /etc/nginx/conf.d && \
    cat /etc/nginx/nginx.conf && \
    #cat /etc/nginx/nginx.conf.default && \
    cat /etc/nginx/conf.d/default.conf

COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
