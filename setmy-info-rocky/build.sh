includePackages smi sbcl

ROCKY_VERSION=9.2
ADDITIONAL_VERSION=4
DOCKER_PROJECT_NAME=setmy-info-rocky
DOCKER_PROJECT_VERSION=${ROCKY_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${ROCKY_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    cp ${SMI_HOME_PACKAGES_LOCATION}/setmy-info-scripts-*.noarch.rpm ./
    cp ${SMI_HOME_PACKAGES_LOCATION}/sbcl-*-x86-64-linux-binary.tar.bz2 ./
    cd ${CUR_DIR}
}

docker_build() {
    CUR_DIR=$(pwd)
    # Nothing here right now
    cd ${CUR_DIR}
 }
