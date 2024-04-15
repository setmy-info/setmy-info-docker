includePackages infinispan

ADDITIONAL_VERSION=7
DOCKER_PROJECT_NAME=setmy-info-rocky-java-hsqldb
DOCKER_PROJECT_VERSION=${HSQLDB_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${HSQLDB_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    cp ${SMI_HOME_PACKAGES_LOCATION}/hsqldb-${HSQLDB_VERSION}.zip ./
    unzip hsqldb-${HSQLDB_VERSION}.zip
    cd ${CUR_DIR}
}

docker_build() {
     CUR_DIR=$(pwd)
     # Nothing here right now
     cd ${CUR_DIR}
 }
