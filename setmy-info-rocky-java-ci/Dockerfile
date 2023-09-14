FROM setmyinfo/setmy-info-rocky:latest as BUILD

COPY ./target/download /var/download
WORKDIR /var/download
RUN dnf -y install unzip tar xz && \
    tar xvzf /var/download/jenkins-1.0.1.tar.gz && \
    # tar xvzf /var/download/openjdk-17.0.2_linux-x64_bin.tar.gz && \
    tar xvzf /var/download/apache-ant-1.10.13-bin.tar.gz && \
    tar xvzf /var/download/apache-maven-3.9.3-bin.tar.gz && \
    tar xvzf /var/download/cmake-3.26.4-linux-x86_64.tar.gz && \
    tar xvzf /var/download/go1.20.5.linux-amd64.tar.gz && \
    tar xvzf /var/download/julia-1.9.1-linux-x86_64.tar.gz && \
    tar xvf  /var/download/node-v18.16.1-linux-x64.tar.xz && \
    unzip /var/download/gradle-8.1.1-bin.zip && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@mail.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux CI" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux CI" \
      org.opencontainers.image.version="2.413" \
      org.opencontainers.image.revision="2.413" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="" \
      org.opencontainers.image.url="" \
      org.opencontainers.image.ref.name=""

ENV LANG C.UTF-8
# ENV JAVA_HOME=/opt/jdk
# ENV PATH=/opt/ant/bin:/opt/maven/bin:/opt/gradle/bin:/opt/cmake/bin:/opt/node/bin:/opt/go/bin:/opt/julia/bin:/usr/bin:$JAVA_HOME/bin:$PATH
ENV PATH=/opt/ant/bin:/opt/maven/bin:/opt/gradle/bin:/opt/cmake/bin:/opt/node/bin:/opt/go/bin:/opt/julia/bin:/usr/bin:$PATH

#COPY --from=BUILD /var/download/jdk-17.0.2 /opt/jdk
COPY --from=BUILD /var/download/apache-ant-1.10.13 /opt/ant
COPY --from=BUILD /var/download/apache-maven-3.9.3 /opt/maven
COPY --from=BUILD /var/download/gradle-8.1.1 /opt/gradle
COPY --from=BUILD /var/download/cmake-3.26.4-linux-x86_64 /opt/cmake
COPY --from=BUILD /var/download/node-v18.16.1-linux-x64 /opt/node
COPY --from=BUILD /var/download/go /opt/go
COPY --from=BUILD /var/download/julia-1.9.1 /opt/julia
COPY --from=BUILD /var/download/jenkins /var/lib/jenkins
COPY ./target/download/jenkins-cli.jar /opt/setmy.info/lib
COPY ./target/download/dvc-3.2.1-1.x86_64.rpm /opt/setmy.info/lib/dvc.rpm

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key && \
    dnf install -y fontconfig jenkins git make && \
    dnf install -y /opt/setmy.info/lib/dvc.rpm && \
    id jenkins && \
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

USER jenkins

WORKDIR /var/lib/jenkins

RUN git config --global init.defaultBranch master && \
    git config --global user.name "Jenkins" && \
    git config --global user.email example@example.com

EXPOSE 8080

CMD ["java", "-jar", "/usr/share/java/jenkins.war", "--enable-future-java"]
