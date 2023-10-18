includePackages nginx

ADDITIONAL_VERSION=6
DOCKER_PROJECT_NAME=setmy-info-rocky-nginx
DOCKER_PROJECT_VERSION=${NGINX_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${NGINX_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    # Nothing here right now
    cd ${CUR_DIR}
}

docker_build() {
     CUR_DIR=$(pwd)
     # Nothing here right now
     cd ${CUR_DIR}
 }
