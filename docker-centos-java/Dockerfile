FROM setmyinfo/setmy-info-centos:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB Centos Java" \
      org.label-schema.version="14.0.1" \
      org.label-schema.description="setmy.info Docker HUB Centos Java" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

COPY jdk-14.0.1 /opt/jdk
RUN chown -R root:root /opt/jdk
ENV JAVA_HOME /opt/jdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN cd /opt/jdk && ls -la
RUN java -version
# TODO : cert import
#keytool -import -trustcacerts -file ${PEM_FILE} -alias ${CERT_ALIAS} -keystore ${KEY_FILE_CACERTS}
#keytool -import -trustcacerts -file ${PEM_FILE} -alias ${CERT_ALIAS} -keystore ${KEY_FILE_JSSCACERTS}
