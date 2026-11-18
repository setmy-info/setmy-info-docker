
def runCommand(String command) {
    if (isUnix()) {
        sh command
    } else {
        bat command
    }
}

pipeline {

    agent any

    triggers {
        pollSCM('H/5 * * * *')
    }

    options {
        buildDiscarder(
            logRotator(
                numToKeepStr: '20',
                artifactNumToKeepStr: '10'
            )
        )

        quietPeriod(15)
        disableConcurrentBuilds(abortPrevious: true)
        lock('setmy-info-docker')
    }

    environment {
        SMI_PROFILES = 'ci'

        SMI_DOCKER_BUILD_CLEANUP = 'true'

        SMI_MAIL_TO = 'has@gintra'

        MASTER_TO_LIVE = 'DEPLOY'
        //DRAFT_TO_LIVE = 'DEPLOY'

        RELEASE_TO_PRELIVE = 'DEPLOY'
        HOTFIX_TO_PRELIVE = 'DEPLOY'

        DEVELOPMENT_TO_TEST_DRAFT = 'DEPLOY'
        RELEASE_TO_TEST_DRAFT = 'DEPLOY'
        HOTFIX_TO_TEST_DRAFT = 'DEPLOY'

        //DEVELOPMENT_TO_TEST_PUBLISH = 'DEPLOY'
        //RELEASE_TO_TEST_PUBLISH = 'DEPLOY'
        //HOTFIX_TO_TEST_PUBLISH = 'DEPLOY'

        DEVELOPMENT_TO_DEV = 'DEPLOY'
    }

    stages {
        stage('Inspection') {
            parallel {
                stage('Pre-build') {
                    steps {
                        echo "Jenkins node: ${env.NODE_NAME}"
                        echo "Operating system: ${isUnix() ? 'Unix/Linux' : 'Windows'}"

                        script {
                            if (!fileExists('README.md')) {
                                error('README.md missing')
                            }
                            if (!fileExists('build.sh')) {
                                error('build.sh missing')
                            }
                            if (!fileExists('setmy-info-rocky/Dockerfile')) {
                                error('setmy-info-rocky/Dockerfile missing')
                            }
                        }

                        runCommand 'git --version'
                        runCommand 'docker --version'
                        runCommand 'docker info'
                    }
                }
                stage('Build tools') {
                    steps {
                        echo 'Build tools installation and preparation (setup, config)'
                        echo 'Nothing to install: docker and setmy-info-scripts (SMI) are the whole toolchain'
                        runCommand 'smi-version'
                    }
                }
            }
        }

        stage('Preparation') {
            parallel {
                stage('Install') {
                    steps {
                        runCommand 'smi-docker-prepare'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Clean: SMI_DOCKER_BUILD_CLEANUP=true, smi-docker-build removes all setmy-info-rocky images first'

                echo 'Resources are copied by smi-docker-prepare'

                echo 'Nothing to compile'

                echo 'No unit tests: the version checks are inside the Dockerfiles'

                echo 'No integration tests'

                echo 'No mutation tests'

                echo 'No reports'

                echo 'No site'

                echo 'No e2e tests'

                echo 'No system tests'
                echo 'No acceptance tests'

                runCommand 'smi-docker-build'

                echo 'No local publishing: the images stay in the Docker of the Jenkins node'
            }
        }

        stage('Publish') {
            parallel {
                stage('Release') {
                    when {
                        branch 'master'
                    }
                    steps {
                        echo 'No release repository: the images are pushed to Docker Hub by Deploy/live: publish'
                    }
                }
                stage('Snapshot') {
                    when {
                        branch pattern: 'devel.*', comparator: 'REGEXP'
                    }
                    steps {
                        echo 'No snapshot: Docker Hub has one version line, only master is pushed'
                    }
                }
                stage('Release reports') {
                    when {
                        branch 'master'
                    }
                    steps {
                        echo 'No reports'
                    }
                }
                stage('Snapshot reports') {
                    when {
                        branch pattern: 'devel.*', comparator: 'REGEXP'
                    }
                    steps {
                        echo 'No reports'
                    }
                }
            }
        }
        stage('Deploy') {
            parallel {
                stage('dev') {
                    when {
                        environment name: 'DEVELOPMENT_TO_DEV', value: 'DEPLOY'
                        branch pattern: 'devel.*', comparator: 'REGEXP'
                    }
                    steps {
                        echo 'No DEV deployment: the images are in the Docker of the Jenkins node'
                    }
                }
                stage('test: draft') {
                    when {
                        anyOf {
                            allOf {
                                environment name: 'DEVELOPMENT_TO_TEST_DRAFT', value: 'DEPLOY'
                                branch pattern: 'devel.*', comparator: 'REGEXP'
                            }
                            allOf {
                                environment name: 'RELEASE_TO_TEST_DRAFT', value: 'DEPLOY'
                                branch pattern: 'release.*', comparator: 'REGEXP'
                            }
                            allOf {
                                environment name: 'HOTFIX_TO_TEST_DRAFT', value: 'DEPLOY'
                                branch pattern: 'hotfix.*', comparator: 'REGEXP'
                            }
                        }
                    }
                    steps {
                        echo 'No TEST deployment: images are taken from Docker Hub by the projects using them'
                    }
                }
                stage('test: publish') {
                    when {
                        anyOf {
                            allOf {
                                environment name: 'DEVELOPMENT_TO_TEST_PUBLISH', value: 'DEPLOY'
                                branch pattern: 'devel.*', comparator: 'REGEXP'
                            }
                            allOf {
                                environment name: 'RELEASE_TO_TEST_PUBLISH', value: 'DEPLOY'
                                branch pattern: 'release.*', comparator: 'REGEXP'
                            }
                            allOf {
                                environment name: 'HOTFIX_TO_TEST_PUBLISH', value: 'DEPLOY'
                                branch pattern: 'hotfix.*', comparator: 'REGEXP'
                            }
                        }
                    }
                    steps {
                        echo 'No TEST deployment: images are taken from Docker Hub by the projects using them'
                    }
                }
                stage('prelive') {
                    when {
                        anyOf {
                            allOf {
                                environment name: 'RELEASE_TO_PRELIVE', value: 'DEPLOY'
                                branch pattern: 'release.*', comparator: 'REGEXP'
                            }
                            allOf {
                                environment name: 'HOTFIX_TO_PRELIVE', value: 'DEPLOY'
                                branch pattern: 'hotfix.*', comparator: 'REGEXP'
                            }
                        }
                    }
                    steps {
                        echo 'No PRELIVE deployment: images are taken from Docker Hub by the projects using them'
                    }
                }
                stage('live: draft') {
                    when {
                        environment name: 'DRAFT_TO_LIVE', value: 'DEPLOY'
                        branch 'draft'
                    }
                    steps {
                        echo 'No draft: master pushes the images to Docker Hub'
                    }
                }
                stage('live: publish') {
                    when {
                        environment name: 'MASTER_TO_LIVE', value: 'DEPLOY'
                        branch 'master'
                    }
                    environment {
                        DOCKER_CONFIG = "${env.WORKSPACE}/.docker"
                    }
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_TOKEN')]) {
                            runCommand 'echo "${DOCKER_HUB_TOKEN}" | docker login -u "${DOCKER_HUB_USER}" --password-stdin'
                        }
                        runCommand 'smi-docker-push'
                    }
                    post {
                        always {
                            runCommand 'docker logout'
                        }
                    }
                }
            }
        }
        stage('Tag') {
            when {
                environment name: 'MASTER_TO_LIVE', value: 'DEPLOY'
                branch 'master'
            }
            steps {
                echo 'No tagging: every image has its own version, from the .package files and build.sh'
            }
        }
    }

    post {
        always {
            runCommand 'docker image list "setmyinfo/setmy-info-rocky*"'
        }

        success {
            emailext (
                to: "${SMI_MAIL_TO}",
                subject: "Jenkins job: $JOB_NAME, build: $BUILD_NUMBER type: SUCCESSFUL",
                body: "Job: $JOB_NAME, build: $BUILD_NUMBER, url: ${env.BUILD_URL}, git: ${env.GIT_URL}, branch: ${env.GIT_BRANCH} SUCCESSFUL post step"
            )
        }

        unstable {
            emailext (
                to: "${SMI_MAIL_TO}",
                subject: "Jenkins job: $JOB_NAME, build: $BUILD_NUMBER type: UNSTABLE",
                body: "Job: $JOB_NAME, build: $BUILD_NUMBER, url: ${env.BUILD_URL}, git: ${env.GIT_URL}, branch: ${env.GIT_BRANCH} UNSTABLE post step"
            )
        }

        failure {
            emailext (
                to: "${SMI_MAIL_TO}",
                subject: "Jenkins job: $JOB_NAME, build: $BUILD_NUMBER type: FAILED",
                body: "Job: $JOB_NAME, build: $BUILD_NUMBER, url: ${env.BUILD_URL}, git: ${env.GIT_URL}, branch: ${env.GIT_BRANCH}  FAILED post step",
                attachLog: true,
                compressLog: true
            )
        }
    }
}
