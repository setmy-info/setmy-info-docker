FROM setmyinfo/setmy-info-rocky-java:latest

ARG TOMCAT_VERSION=11.0.24

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=${TOMCAT_VERSION}-4

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Tomcat" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Tomcat" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/README.md" \
      org.opencontainers.image.authors="Imre Tabur <imre.tabur@mail.ee>" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-tomcat" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-tomcat" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

COPY apache-tomcat-${TOMCAT_VERSION}/ /opt/tomcat/

RUN mkdir -p /opt/tomcat/logs && \
    mkdir -p /opt/tomcat/temp && \
    mkdir -p /opt/tomcat/conf/Catalina/ && \
    useradd tomcat --shell /sbin/nologin --no-create-home && \
    chown -R root:root     /opt/tomcat && \
    chown -R tomcat:tomcat /opt/tomcat/work/ \
                           /opt/tomcat/temp/ \
                           /opt/tomcat/logs/ \
                           /opt/tomcat/webapps/ \
                           /opt/tomcat/conf/Catalina/ && \
    chmod ugo+rx /opt/tomcat && \
    chmod ugo+rx /opt/tomcat/bin && \
    chmod ugo+rx /opt/tomcat/conf && \
    chmod -R ugo+rX /opt/tomcat/lib && \
    chmod ugo+r  /opt/tomcat/bin/* && \
    chmod ugo+x  /opt/tomcat/bin/*.sh && \
    chmod ugo+r  /opt/tomcat/conf/*
# TODO : tomcat std apps deletion

ENV CATALINA_HOME=/opt/tomcat
ENV PATH="${CATALINA_HOME}/bin:${PATH}"

WORKDIR /opt/tomcat

USER tomcat

RUN cd /opt/tomcat && \
    ls -la && \
    pwd && \
    whoami && \
    ls -la /opt/tomcat/lib/*.jar && \
    ls -la /opt/tomcat/lib

EXPOSE 8080/tcp

CMD ["catalina.sh", "run"]
