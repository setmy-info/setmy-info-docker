FROM setmyinfo/setmy-info-rocky:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.opencontainers.image.title="Docker HUB Centos Nginx" \
      org.opencontainers.image.description="setmy.info Docker HUB Centos Node" \
      org.opencontainers.image.version="1.22.1" \
      org.opencontainers.image.revision="1.22.1" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY ./etc/yum.repos.d/nginx.repo     /etc/yum.repos.d/nginx.repo
COPY ./usr/share/nginx/www/index.html /usr/share/nginx/www/index.html
COPY ./usr/share/nginx/www/error.html /usr/share/nginx/www/error.html

RUN dnf -y update
RUN rpm --import https://nginx.org/keys/nginx_signing.key
RUN dnf -y install yum-utils
RUN dnf -y install nginx

RUN cat /etc/nginx/nginx.conf
#RUN cat /etc/nginx/nginx.conf.default
COPY ./etc/nginx/conf.d/default.conf  /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
