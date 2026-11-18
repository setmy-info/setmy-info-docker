DOCKER_MODULES="
    setmy-info-rocky
    setmy-info-rocky-java
    setmy-info-rocky-node
    setmy-info-rocky-nginx
    setmy-info-rocky-freenginx
    setmy-info-rocky-java-tomcat
    setmy-info-rocky-java-zeebe
    setmy-info-rocky-java-infinispan
    setmy-info-rocky-java-hsqldb
    setmy-info-rocky-java-ci
    setmy-info-rocky-elixir
    setmy-info-rocky-python
"

docker_in_modules() {
    for DOCKER_MODULE in ${DOCKER_MODULES}; do
        echo "=== ${1} ${DOCKER_MODULE}"
        (cd ${DOCKER_MODULE} && ${1}) || return
    done
}

docker_prepare() {
    docker_in_modules smi-docker-prepare
}

docker_build() {
    if [ "${SMI_DOCKER_BUILD_CLEANUP}" = "true" ]; then
        docker images -aq --filter 'reference=setmyinfo/setmy-info-rocky*' | sort -u | xargs -r docker image rm -f
        docker image prune -f
    fi
    docker_in_modules smi-docker-build
}

docker_push() {
    docker_in_modules smi-docker-push
}
