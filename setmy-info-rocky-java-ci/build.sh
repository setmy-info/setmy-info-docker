includePackages mvn gradle node cmake dvc jenkins jenkins_home go julia lein

ADDITIONAL_VERSION=0
DOCKER_PROJECT_NAME=setmy-info-rocky-java-jenkins
DOCKER_PROJECT_VERSION=${JENKINS_VERSION}
#DOCKER_PROJECT_VERSION=${JENKINS_VERSION}-${ADDITIONAL_VERSION}
DOCKER_BUILD_ARGS="JENKINS_HOME_VERSION"

docker_prepare() {
    smi-download-package jenkins jenkins_home && \
    mkdir -p ./target/download && \
    # Unpacked by the BUILD stage of the Dockerfile as the Jenkins home.
    cp ${HOME_PACKAGES_DIR}/${JENKINS_HOME_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${MAVEN_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${CMAKE_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${GO_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${JULIA_TAR_GZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${NODE_TAR_XZ_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${DVC_REPO_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${GRADLE_ZIP_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/${LEININGEN_FILE_NAME} ./target/download && \
    #cp ${HOME_PACKAGES_DIR}/leiningen-${LEININGEN_VERSION}-standalone.jar ./target/download && \
    cp ${HOME_PACKAGES_DIR}/jenkins.war ./target/download && \
    unzip -q -o ./target/download/jenkins.war "WEB-INF/lib/cli-${JENKINS_VERSION}.jar" -d ./target/download && \
    unzip -q -o ./target/download/jenkins.war "WEB-INF/lib/remoting*.jar" -d ./target/download && \
    mv ./target/download/WEB-INF/lib/cli-${JENKINS_VERSION}.jar ./target/download/jenkins-cli.jar && \
    # The agent JAR is the remoting JAR of the WAR, same as in jenkins.package
    mv ./target/download/WEB-INF/lib/remoting*.jar ./target/download/jenkins-agent.jar && \
    rm -r ./target/download/WEB-INF
}
