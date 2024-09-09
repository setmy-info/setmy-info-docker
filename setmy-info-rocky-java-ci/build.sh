includePackages maven gradle node cmake dvc jenkins jenkins_home go julia leiningen

ADDITIONAL_VERSION=2
DOCKER_PROJECT_NAME=setmy-info-rocky-java-jenkins
DOCKER_PROJECT_VERSION=${JENKINS_VERSION}-${ADDITIONAL_VERSION}
#DOCKER_PROJECT_VERSION=${JENKINS_VERSION}
DOCKER_ID_ORGANIZATION=setmyinfo
DOCKER_CONTENT_TRUST=1

SMI_HOME_PACKAGES_LOCATION=$(smi-home-packages-location)

docker_prepare() {
    mkdir -p ./target/download
    cp ${SMI_HOME_PACKAGES_LOCATION}/${JENKINS_HOME_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${MAVEN_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${CMAKE_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${GO_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${JULIA_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${NODE_TAR_XZ_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${DVC_RPM_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${GRADLE_ZIP_FILE_NAME} ./target/download && \
    #cp ${SMI_HOME_PACKAGES_LOCATION}/${LEININGEN_FILE_NAME} ./target/download && \
    cp ${SMI_HOME_PACKAGES_LOCATION}/jenkins.war ./target/download && \
    unzip ./target/download/jenkins.war "WEB-INF/lib/cli-${JENKINS_VERSION}.jar" -d ./target/download
    mv ./target/download/WEB-INF/lib/cli-${JENKINS_VERSION}.jar ./target/download/jenkins-cli.jar
    rm -r ./target/download/WEB-INF
}

docker_build() {
    return
}
