includePackages jdk

ADDITIONAL_VERSION=1
#DOCKER_PROJECT_VERSION=${JDK_VERSION}
DOCKER_PROJECT_VERSION=${JDK_VERSION}-${ADDITIONAL_VERSION}
DOCKER_BUILD_ARGS="JDK_VERSION"

docker_prepare() {
    smi-download-package jdk && \
    cp ${HOME_PACKAGES_DIR}/openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz ./
}
