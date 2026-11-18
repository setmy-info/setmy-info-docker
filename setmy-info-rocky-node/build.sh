includePackages node

ADDITIONAL_VERSION=0
DOCKER_PROJECT_VERSION=${NODE_VERSION}
#DOCKER_PROJECT_VERSION=${NODE_VERSION}-${ADDITIONAL_VERSION}
DOCKER_BUILD_ARGS="NODE_VERSION"

docker_prepare() {
    smi-download-package node && \
    cp ${HOME_PACKAGES_DIR}/node-v${NODE_VERSION}-linux-x64.tar.xz ./
}
