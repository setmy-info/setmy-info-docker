FROM setmyinfo/setmy-info-rocky-java:latest as BUILD

COPY ./target/download /var/download
WORKDIR /var/download
RUN dnf -y install unzip tar xz && \
    tar xvzf /var/download/jenkins-1.0.1.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

MAINTAINER Imre Tabur "imre.tabur@mail.ee"

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux CI" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux CI" \
      org.opencontainers.image.version="2.467-2" \
      org.opencontainers.image.revision="" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-ci" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-ci" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

ENV LANG C.UTF-8
ENV PATH=/opt/setmy.info/bin:/opt/leiningen/bin:/opt/maven/bin:/opt/gradle/bin:/opt/cmake/bin:/opt/node/bin:/opt/go/bin:/opt/julia/bin:/usr/bin:$PATH

RUN mkdir -p /opt/leiningen/bin && \
    mkdir -p /opt/leiningen/lib && \
    mkdir -p /opt/leiningen/self-installs

COPY --from=BUILD /var/download/jenkins /var/lib/jenkins
COPY ./target/download/jenkins-cli.jar /opt/setmy.info/lib/jenkins-cli.jar
COPY ./src/main/sh/do-install /opt/setmy.info/bin/

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key && \
    dnf install -y epel-release && \
    dnf --enablerepo=epel group && \
    dnf config-manager --set-enabled crb && \
    dnf config-manager --set-enabled plus && \
    dnf config-manager --set-enabled rt && \
    dnf update -y && \
    dnf install -y  fontconfig jenkins git make sudo rsync \
		    unzip tar xz make yum-utils rpmdevtools \
		    rpm-build git mercurial meld openssl-devel \
		    sqlite sqlite-devel cpp gcc g++ boost-test dos2unix rpmlint && \
    id jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers && \
    chown -R jenkins:jenkins /var/lib/jenkins && \
    ls -la /var/lib/jenkins

USER jenkins

WORKDIR /var/lib/jenkins

RUN git config --global init.defaultBranch master && \
    git config --global user.name "Jenkins" && \
    git config --global user.email example@example.com

EXPOSE 8080

CMD [ "smi-docker-command", "do-install", "java", "-jar", "/usr/share/java/jenkins.war", "--enable-future-java" ]
