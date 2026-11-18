# experiment

Test image for `smi-docker-command`: at start, `do-install` runs once as root, sudo is removed, and `do-main-work` runs as `microservice` with the container arguments. It is not part of the root build and needs `setmyinfo/setmy-info-rocky:latest`.

Build and run, also in `build-run.sh`:

```shell
docker build -t setmyinfo/experiment .
docker run -it setmyinfo/experiment
```

Arguments replace the default `a b c` of `do-main-work`:

```shell
docker run -it setmyinfo/experiment x y
```

Shell as root, without the start flow:

```shell
docker run -u root -it --entrypoint /bin/sh setmyinfo/experiment
```
