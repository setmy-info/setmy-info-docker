# setmy-info-rocky-elixir

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-elixir:1.20.5 -t setmyinfo/setmy-info-rocky-elixir:latest .
```

Erlang/OTP **29.1.2** and Elixir **1.20.5** are downloaded, built and installed inside the Docker build stages with
**smi-download-package**, **smi-build-package** and **smi-install-package** (packages **erlang** and **elixir**).
Erlang is installed first and is on PATH for the Elixir build.

## Execute

```shell
docker run --rm -it setmyinfo/setmy-info-rocky-elixir:latest iex
docker run --rm -it setmyinfo/setmy-info-rocky-elixir:latest erl
```
