FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Rocky Linux HSQLDB" \
      org.label-schema.version="2.6.1-3" \
      org.label-schema.description="setmy.info Docker HUB Rocky Linux HSQLDB" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

RUN mkdir -p /opt/hsqldb/{bin,lib}
RUN mkdir -p /var/opt/hsqldb/data

COPY src/server /opt/hsqldb/bin
COPY hsqldb-2.6.1/hsqldb/lib/hsqldb.jar /opt/hsqldb/lib
RUN chown -R root:root /opt/hsqldb
RUN chown -R root:root /var/opt/hsqldb
RUN chown -R microservice:microservice /var/opt/hsqldb/data

WORKDIR /opt/hsqldb/bin

EXPOSE 9001/tcp

USER microservice

CMD ["/opt/hsqldb/bin/server", "run"]
