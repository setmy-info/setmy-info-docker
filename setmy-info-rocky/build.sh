includePackages smi sbcl

ROCKY_VERSION=10.3
ADDITIONAL_VERSION=0
DOCKER_PROJECT_VERSION=${ROCKY_VERSION}
#DOCKER_PROJECT_VERSION=${ROCKY_VERSION}-${ADDITIONAL_VERSION}
DOCKER_BUILD_ARGS="ROCKY_VERSION SMI_VERSION SBCL_VERSION"

docker_prepare() {
    smi-download-package smi sbcl && \
    smi-build-package smi && \
    cp ${HOME_PACKAGES_DIR}/setmy-info-scripts-${SMI_VERSION}.noarch.rpm ./ && \
    cp ${HOME_PACKAGES_DIR}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 ./ && \
    cp ${HOME_PACKAGES_DIR}/quicklisp.lisp ./
}
