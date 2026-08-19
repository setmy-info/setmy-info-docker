FROM setmyinfo/setmy-info-rocky-java:latest as BUILD

ARG JENKINS_VERSION=2.568.2

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=${JENKINS_VERSION}-4

COPY ./target/download /var/download
WORKDIR /var/download
RUN dnf -y install unzip tar xz && \
    tar xvzf /var/download/jenkins-2.1.0.tar.gz && \
    ls -la

FROM setmyinfo/setmy-info-rocky-java:latest

# http://label-schema.org/rc1/ replaced with https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.title="Docker HUB Rocky Linux CI" \
      org.opencontainers.image.description="setmy.info Docker HUB Rocky Linux CI" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Hear And See Systems LLC" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.documentation="" \
      org.opencontainers.image.authors="Imre Tabur" \
      org.opencontainers.image.source="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-ci" \
      org.opencontainers.image.url="https://github.com/setmy-info/setmy.info/tree/master/setmy-info-docker/setmy-info-rocky-java-ci" \
      org.opencontainers.image.ref.name="" \
      org.opencontainers.image.base.name="setmyinfo/setmy-info-rocky-java:latest"

ENV LANG=C.UTF-8
ENV PATH=/opt/setmy.info/bin:/opt/leiningen/bin:/opt/maven/bin:/opt/gradle/bin:/opt/groovy/bin:/opt/cmake/bin:/opt/node/bin:/opt/go/bin:/opt/julia/bin:/usr/bin:$PATH

RUN mkdir -p /opt/leiningen/bin && \
    mkdir -p /opt/leiningen/lib && \
    mkdir -p /opt/leiningen/self-installs

COPY --from=BUILD /var/download/jenkins/.jenkins  /var/lib/jenkins
COPY ./target/download/jenkins-cli.jar   /opt/setmy.info/lib/jenkins-cli.jar
COPY ./target/download/jenkins-agent.jar /opt/setmy.info/lib/jenkins-agent.jar
COPY ./src/main/sh/do-install /opt/setmy.info/bin/
COPY ./src/main/sh/do-start   /opt/setmy.info/bin/
COPY ./src/main/sh/do-role    /opt/setmy.info/bin/

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo && \
    dnf install -y epel-release && \
    dnf --enablerepo=epel group && \
    dnf config-manager --set-enabled crb && \
    dnf config-manager --set-enabled plus && \
    dnf config-manager --set-enabled rt && \
    dnf update -y && \
    dnf install -y fontconfig jenkins git make sudo rsync \
		    unzip tar xz make yum-utils rpmdevtools \
		    rpm-build git mercurial meld openssl-devel \
            zlib-devel bzip2-devel xz-devel \
            # Python build dependencies \
            libffi-devel readline-devel tk-devel gdbm-devel ncurses-devel uuid-devel libuuid-devel expat-devel \
		    sqlite sqlite-devel cpp gcc g++ boost-test dos2unix rpmlint && \
    id jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers && \
    chmod 0755 /opt/setmy.info/bin/do-install /opt/setmy.info/bin/do-start /opt/setmy.info/bin/do-role && \
    chown -R jenkins:jenkins /var/lib/jenkins && \
    ls -la /var/lib/jenkins

USER jenkins

# Home of the live installation. smi-jenkins-controller uses it as the Jenkins
# home, smi-jenkins-node keeps the node work directories below it.
ENV JENKINS_HOME=/var/lib/jenkins

# Kept together with EXPOSE below. The role of the container is not set here,
# it is detected by ./src/main/sh/do-start.
ENV SMI_JENKINS_PORT=7070

WORKDIR /var/lib/jenkins

RUN git config --global init.defaultBranch master && \
    git config --global user.name "Jenkins" && \
    git config --global user.email example@example.com

EXPOSE 7070

# The role is written down as the jenkins user, before smi-docker-command
# crosses to root. sudo rebuilds the environment, so do-install cannot read the
# variables of the container, but it can read the file.
CMD [ "sh", "-c", "do-role > /tmp/smi-jenkins-role; exec smi-docker-command do-install do-start" ]
