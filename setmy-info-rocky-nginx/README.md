# Readme

## Prerequisites

**~/.pki/.dev-certs/** should have CA certs and keys and localhost certs and keys created.

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-nginx:11.0.15 -t setmyinfo/setmy-info-rocky-nginx:latest .
docker run --rm -p 80:80 -v ~/.pki/.dev-certs/localhost.crt:/etc/pki/tls/localhost.crt:ro -v ~/.pki/.dev-certs/localhost.priv.key:/etc/pki/tls/localhost.priv.key:ro -p 443:443 setmyinfo/setmy-info-rocky-nginx:latest
```

Windows

```shell
docker run --rm -p 80:80 -v C:\Users\<USERNAME>\.pki\.dev-certs\localhost.crt:/etc/pki/tls/localhost.crt:ro -v C:\Users\<USERNAME>\.pki\.dev-certs\localhost.priv.key:/etc/pki/tls/localhost.priv.key:ro -p 443:443 setmyinfo/setmy-info-rocky-nginx:latest
```
