FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Centos Tomcat" \
      org.opencontainers.image.description="setmy.info Docker HUB Centos Tomcat" \
      org.opencontainers.image.version="10.0.27" \
      org.opencontainers.image.revision="10.0.27" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

COPY apache-tomcat-10.0.27 /opt/tomcat
RUN mkdir -p /opt/tomcat/{logs,temp}
RUN mkdir -p /opt/tomcat/conf/Catalina/
RUN useradd tomcat --shell /sbin/nologin --no-create-home
RUN chown -R root:root     /opt/tomcat
RUN chown -R tomcat:tomcat /opt/tomcat/work/
RUN chown -R tomcat:tomcat /opt/tomcat/temp/
RUN chown -R tomcat:tomcat /opt/tomcat/logs/
RUN chown -R tomcat:tomcat /opt/tomcat/webapps/
RUN chown -R tomcat:tomcat /opt/tomcat/conf/Catalina/
RUN chmod goa+r /opt/tomcat/conf/*
# TODO : tomcat std apps deletion

ENV CATALINA_HOME /opt/tomcat
ENV PATH="${CATALINA_HOME}/bin:${PATH}"

WORKDIR /opt/tomcat

USER tomcat
RUN cd /opt/tomcat && ls -la && pwd && whoami

EXPOSE 8080/tcp

CMD ["catalina.sh", "run"]
