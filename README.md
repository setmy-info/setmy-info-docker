# setmy-info-docker

Rocky Linux Docker images, built with the SMI toolset (setmy-info-scripts). `setmy-info-rocky` is the base image, the other folders are images built on it or on `setmy-info-rocky-java`.

In the root folder for all images in order, or in an image folder for that image only:

```shell
smi-docker-prepare
smi-docker-build
smi-docker-push
```

`SMI_DOCKER_BUILD_CLEANUP=true smi-docker-build` in the root folder first removes all `setmyinfo/setmy-info-rocky*` images and the dangling ones, so the full build starts clean.

Versions come from the `.package` files of setmy-info-scripts. For a version suffix, switch the commented `DOCKER_PROJECT_VERSION` line in the `build.sh` of the image.

## CI

`Jenkinsfile` removes all `setmyinfo/setmy-info-rocky*` images and builds all of them again on every branch, and pushes
them to Docker Hub only on `master` (Deploy/live: publish). The lock `setmy-info-docker` lets only one build of the
multibranch pipeline run at a time, the other branches wait for it.

Docker Hub:

* The `setmyinfo` organization (namespace) with a public repository for every image, or let the first push create them.
* A user with write access to them, and for that user a personal access token (Account settings, Personal access
  tokens) with **Read & Write** scope. The token is used instead of the password.

Jenkins:

* Credentials, kind **Username with password**, ID `docker-hub`: the Docker Hub user and the token.
* The node has `docker` (the user of the agent may use it, `docker` group or socket mounted), `git` and
  setmy-info-scripts installed.
* Plugins: Pipeline, Multibranch Pipeline, Git, Credentials Binding, Lockable Resources, Email Extension.

The login is kept in the workspace (`DOCKER_CONFIG`) and logged out after the push.
