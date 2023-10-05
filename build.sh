docker_prepare_in_dir() {
    CUR_DIR=$(pwd)
    IN_DIR=${1}
    cd ${IN_DIR}
    smi-docker-prepare
    cd ${CUR_DIR}
}

docker_build_in_dir() {
    CUR_DIR=$(pwd)
    IN_DIR=${1}
    cd ${IN_DIR}
    smi-docker-build
    cd ${CUR_DIR}
}

docker_prepare() {
    smi-download-package all
    docker_prepare_in_dir setmy-info-rocky
    docker_prepare_in_dir setmy-info-rocky-java
    docker_prepare_in_dir setmy-info-rocky-node
    docker_prepare_in_dir setmy-info-rocky-nginx
    docker_prepare_in_dir setmy-info-rocky-java-tomcat
    docker_prepare_in_dir setmy-info-rocky-java-zeebe
    docker_prepare_in_dir setmy-info-rocky-java-infinispan
    docker_prepare_in_dir setmy-info-rocky-java-hsqldb
    docker_prepare_in_dir setmy-info-rocky-java-ci
}

docker_build() {
    docker_build_in_dir setmy-info-rocky
    docker_build_in_dir setmy-info-rocky-java
    docker_build_in_dir setmy-info-rocky-node
    docker_build_in_dir setmy-info-rocky-nginx
    docker_build_in_dir setmy-info-rocky-java-tomcat
    docker_build_in_dir setmy-info-rocky-java-zeebe
    docker_build_in_dir setmy-info-rocky-java-infinispan
    docker_build_in_dir setmy-info-rocky-java-hsqldb
    docker_build_in_dir setmy-info-rocky-java-ci
}

docker_prepare
docker_build
