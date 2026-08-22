includePackages erlang elixir lfe

ADDITIONAL_VERSION=1
DOCKER_PROJECT_NAME=setmy-info-rocky-elixir
DOCKER_PROJECT_VERSION=${ERLANG_VERSION}-${ADDITIONAL_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    CUR_DIR=$(pwd)
    # Erlang, Elixir, and LFE are downloaded and built inside the Docker BUILD stage.
    cd ${CUR_DIR}
}

docker_build() {
    CUR_DIR=$(pwd)
    # Nothing here right now
    cd ${CUR_DIR}
}
