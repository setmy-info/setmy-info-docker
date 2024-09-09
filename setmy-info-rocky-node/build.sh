includePackages node

ADDITIONAL_VERSION=2
DOCKER_PROJECT_NAME=setmy-info-rocky-node
DOCKER_PROJECT_VERSION=${NODE_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${NODE_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    cp ${SMI_HOME_PACKAGES_LOCATION}/node-v${NODE_VERSION}-linux-x64.tar.xz ./
    tar xvf node-v${NODE_VERSION}-linux-x64.tar.xz
    cd ${CUR_DIR}
}

docker_build() {
     CUR_DIR=$(pwd)
     # Nothing here right now
     cd ${CUR_DIR}
 }
