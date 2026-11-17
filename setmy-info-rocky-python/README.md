# setmy-info-rocky-python

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-python:3.13.18 -t setmyinfo/setmy-info-rocky-python:latest .
```

Python is downloaded, built and installed inside the Docker BUILD stage with **smi-download-package**,
**smi-build-package** and **smi-install-package** (package **python313**).

## Execute

```shell
docker run --rm -it setmyinfo/setmy-info-rocky-python:latest python3
```
