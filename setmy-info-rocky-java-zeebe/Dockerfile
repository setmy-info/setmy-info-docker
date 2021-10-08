FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos Java Zeebe" \
      org.label-schema.version="1.1.3" \
      org.label-schema.description="setmy.info Docker HUB Centos Java Zeebe" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

COPY camunda-cloud-zeebe-1.1.3 /opt/zeebe-broker
COPY src/zeebe-starter /opt/zeebe-broker/bin
RUN chown -R root:root /opt/zeebe-broker
RUN mkdir /opt/zeebe-broker/data
RUN mkdir /opt/zeebe-broker/logs
RUN chown -R microservice:microservice /opt/zeebe-broker/data
RUN chown -R microservice:microservice /opt/zeebe-broker/logs
ENV ZEEBE_HOME /opt/zeebe-broker
ENV PATH="${ZEEBE_HOME}/bin:${PATH}"
RUN cd /opt/zeebe-broker && ls -la
USER microservice
RUN whoami

WORKDIR /opt/zeebe-broker

#TODO
#VOLUME /opt/zeebe-broker/data

EXPOSE 26500/tcp 26501/tcp 26502/tcp

CMD ["/opt/zeebe-broker/bin/zeebe-starter"]
