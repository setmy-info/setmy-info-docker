includePackages infinispan

ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME=setmy-info-rocky-java-infinispan
DOCKER_PROJECT_VERSION=${INFINISPAN_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${INFINISPAN_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    cp ${SMI_HOME_PACKAGES_LOCATION}/infinispan-server-${INFINISPAN_VERSION}.Final.zip ./
    unzip infinispan-server-${INFINISPAN_VERSION}.Final.zip
    cd ${CUR_DIR}
}

docker_build() {
     CUR_DIR=$(pwd)
     # Nothing here right now
     cd ${CUR_DIR}
 }
