FROM setmyinfo/setmy-info-rocky-java:latest
#FROM setmyinfo/setmy-info-rocky:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux CI" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux CI" \
      org.opencontainers.image.version="2.411" \
      org.opencontainers.image.revision="2.411" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

ENV LANG C.UTF-8

#ENV JAVA_HOME=/opt/jdk
#ENV PATH=$JAVA_HOME/bin:$PATH
#COPY jdk-17.0.2 /opt/jdk

COPY jenkins /var/lib/jenkins
#COPY .ssh /var/lib/jenkins/.ssh
COPY jenkins-cli.jar /opt/setmy.info/lib
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key && \
    dnf install -y fontconfig jenkins git && \
    chown -R jenkins:jenkins /var/lib/jenkins && ls -la /var/lib/jenkins && \
    java --version

# Initial (change it) default admin password
ENV JENKINS_ADMIN_PASSWORD=e0c926f9e29a4842befe68bc699e0224

USER jenkins
WORKDIR /var/lib/jenkins
EXPOSE 8080

#RUN java -jar /opt/setmy.info/lib/jenkins-cli.jar --plugins "blueocean docker-workflow"
CMD ["java", "-jar", "/usr/share/java/jenkins.war", "--enable-future-java"]
