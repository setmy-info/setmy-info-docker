FROM setmyinfo/setmy-info-centos-java:v12.0.2-1

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos Tomcat" \
      org.label-schema.version="v9.0.17" \
      org.label-schema.description="setmy.info Docker HUB Centos Tomcat" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

COPY apache-tomcat-9.0.22 /opt/tomcat
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
#USER tomcat
RUN cd /opt/tomcat && ls -la && ps axf && pwd && whoami

EXPOSE 8080/tcp

CMD ["catalina.sh", "run"]