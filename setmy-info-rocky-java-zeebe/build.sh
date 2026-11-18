includePackages zeebe

ADDITIONAL_VERSION=0
DOCKER_PROJECT_VERSION=${ZEEBE_VERSION}
#DOCKER_PROJECT_VERSION=${ZEEBE_VERSION}-${ADDITIONAL_VERSION}
DOCKER_BUILD_ARGS="ZEEBE_VERSION"

docker_prepare() {
    smi-download-package zeebe && \
    cp ${HOME_PACKAGES_DIR}/camunda-zeebe-${ZEEBE_VERSION}.tar.gz ./
}
