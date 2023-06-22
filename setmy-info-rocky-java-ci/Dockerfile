FROM setmyinfo/setmy-info-rocky-java:latest

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
ENV JAVA_HOME=/opt/jdk
ENV PATH=$JAVA_HOME/bin:$PATH

COPY jenkins.tar.gz /var/lib
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key && \
    dnf install -y fontconfig jenkins && \
    tar xvzf /var/lib/jenkins.tar.gz -C /var/lib && \
    chown -R jenkins:jenkins /var/lib/jenkins
    #/usr/bin/systemctl enable jenkins
    #firewall-cmd --permanent --new-service=jenkins && \
    #firewall-cmd --permanent --service=jenkins --set-short="Jenkins ports" && \
    #firewall-cmd --permanent --service=jenkins --set-description="Jenkins port exceptions" && \
    #firewall-cmd --permanent --service=jenkins --add-port=8080/tcp && \
    #firewall-cmd --permanent --add-service=jenkins && \
    #firewall-cmd --zone=public --add-service=http --permanent && \
    #firewall-cmd --reload && \
    #ls -la /var/lib/jenkins/jenkins.war && \

# Initial default admin password (change it at first use): e0c926f9e29a4842befe68bc699e0224
ENV JENKINS_ADMIN_PASSWORD=e0c926f9e29a4842befe68bc699e0224

# docker -e GITHUB_TOKEN=$GITHUB_TOKEN -e OTHER_VARIABLE=$OTHER_VARIABLE ...GITHUB_USERNAME,   to pass tokens into Jenkins, to access repos in github
# docker volume create jenkins-data

USER jenkins
WORKDIR /var/lib/jenkins
EXPOSE 8080

#RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
#CMD ["/sbin/init"]
CMD ["java", "-jar", "/usr/share/java/jenkins.war", "--enable-future-java"]
