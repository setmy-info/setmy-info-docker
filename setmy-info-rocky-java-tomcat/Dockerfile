ARG TOMCAT_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

FROM setmyinfo/setmy-info-rocky:latest AS build

ARG TOMCAT_VERSION

COPY ./apache-tomcat-${TOMCAT_VERSION}.tar.gz /var/download/
WORKDIR /var/download
RUN tar xvzf /var/download/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm -rf apache-tomcat-${TOMCAT_VERSION}/webapps/docs \
           apache-tomcat-${TOMCAT_VERSION}/webapps/examples \
           apache-tomcat-${TOMCAT_VERSION}/webapps/manager \
           apache-tomcat-${TOMCAT_VERSION}/webapps/host-manager && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

ARG TOMCAT_VERSION
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="Docker HUB Rocky Tomcat" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Tomcat" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="Apache-2.0,MIT" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="https://github.com/setmy-info/setmy-info-docker/blob/master/README.md" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-tomcat" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy-info-docker/tree/master/setmy-info-rocky-java-tomcat" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

COPY --from=build /var/download/apache-tomcat-${TOMCAT_VERSION} /opt/apache-tomcat-${TOMCAT_VERSION}

RUN ln -sf /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
    mkdir -p /opt/tomcat/logs && \
    mkdir -p /opt/tomcat/temp && \
    mkdir -p /opt/tomcat/conf/Catalina/ && \
    useradd tomcat --shell /sbin/nologin --no-create-home && \
    chown -R root:root     /opt/tomcat/ && \
    chown -R tomcat:tomcat /opt/tomcat/work/ \
                           /opt/tomcat/temp/ \
                           /opt/tomcat/logs/ \
                           /opt/tomcat/webapps/ \
                           /opt/tomcat/conf/Catalina/ && \
    chmod -R go+rX /opt/tomcat/

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
