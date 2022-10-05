FROM setmyinfo/setmy-info-rocky:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos Nginx" \
      org.label-schema.version="1.22.0" \
      org.label-schema.description="setmy.info Docker HUB Centos Node" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

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
