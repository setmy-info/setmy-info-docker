includePackages zeebe

#ADDITIONAL_VERSION=4
DOCKER_PROJECT_NAME=setmy-info-rocky-java-zeebe
#DOCKER_PROJECT_VERSION=${ZEEBE_VERSION}-${ADDITIONAL_VERSION}
DOCKER_PROJECT_VERSION=${ZEEBE_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    cp ${SMI_HOME_PACKAGES_LOCATION}/camunda-zeebe-${ZEEBE_VERSION}.tar.gz ./
    tar xvzf camunda-zeebe-${ZEEBE_VERSION}.tar.gz
    cd ${CUR_DIR}
}

docker_build() {
     CUR_DIR=$(pwd)
     # Nothing here right now
     cd ${CUR_DIR}
 }
