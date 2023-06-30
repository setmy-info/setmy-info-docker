FROM setmyinfo/setmy-info-rocky:latest

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
ENV PATH=/opt/ant/bin:/opt/maven/bin:/opt/gradle/bin:/opt/cmake/bin:/opt/node/bin:/opt/go/bin:/opt/julia/bin:$PATH

COPY jenkins /var/lib/jenkins
COPY jenkins-cli.jar /opt/setmy.info/lib
COPY dvc-3.2.1-1.x86_64.rpm /opt/setmy.info/lib/dvc.rpm
COPY zulu17.42.21-ca-crac-jdk17.0.7-linux_x64 /opt/jdk
COPY apache-ant-1.10.13 /opt/ant
COPY apache-maven-3.9.3 /opt/maven
COPY gradle-8.1.1 /opt/gradle
COPY cmake-3.26.4-linux-x86_64 /opt/cmake
COPY node-v18.16.1-linux-x64 /opt/node
COPY go /opt/go
COPY julia-1.9.1 /opt/julia

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key && \
    dnf install -y fontconfig jenkins git make && \
    dnf install -y /opt/setmy.info/lib/dvc.rpm && \
    chown -R jenkins:jenkins /var/lib/jenkins && ls -la /var/lib/jenkins && \
    ls -la /opt && \
    ls -la /opt/julia/lib && \
    ant -version && \
    mvn --version && \
    gradle --version && \
    node --version && \
    cmake --version && \
    dvc --version && \
    go version && \
    julia --version && \
    java --version

# Initial (change it) default admin password
ENV JENKINS_ADMIN_PASSWORD=e0c926f9e29a4842befe68bc699e0224

USER jenkins
WORKDIR /var/lib/jenkins
EXPOSE 8080

#RUN java -jar /opt/setmy.info/lib/jenkins-cli.jar --plugins "blueocean docker-workflow"
CMD ["java", "-jar", "/usr/share/java/jenkins.war", "--enable-future-java"]
