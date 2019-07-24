FROM setmyinfo/setmy-info-centos:v1.0.5

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos NodeJS" \
      org.label-schema.version="v10.16.0-1" \
      org.label-schema.description="setmy.info Docker HUB Centos Node" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

COPY node-v10.16.0-linux-x64 /opt/node
RUN useradd node --shell /sbin/nologin --no-create-home
RUN chown -R root:root /opt/node
ENV NODE_HOME /opt/node
ENV PATH="${NODE_HOME}/bin:${PATH}"
RUN cd /opt/node && ls -la
RUN node --version
