FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux CI" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux CI" \
      org.opencontainers.image.version="2.388" \
      org.opencontainers.image.revision="2.388" \
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

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key && \
    dnf install -y tini fontconfig jenkins && \
#    systemctl enable jenkins && \
    firewall-cmd --permanent --new-service=jenkins && \
    firewall-cmd --permanent --service=jenkins --set-short="Jenkins ports" && \
    firewall-cmd --permanent --service=jenkins --set-description="Jenkins port exceptions" && \
    firewall-cmd --permanent --service=jenkins --add-port=8080/tcp && \
    firewall-cmd --permanent --add-service=jenkins && \
    firewall-cmd --zone=public --add-service=http --permanent && \
    firewall-cmd --reload

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/local/bin/jenkins.sh"
