# setmy-info-rocky-freenginx

## Prerequisites

**~/.pki/.dev-certs/** should have CA certs and keys and localhost certs and keys created.

## Build

```shell
docker build --no-cache --progress=plain -t setmyinfo/setmy-info-rocky-freenginx:1.30.2 -t setmyinfo/setmy-info-rocky-freenginx:latest .
```

freenginx is downloaded (Mercurial tag **release-1.30.2**), built and installed inside the Docker BUILD stage with
**smi-download-package**, **smi-build-package** and **smi-install-package** (package **freenginx**).

## Execute

```shell
docker run --rm -p 80:80 -p 443:443 -v ~/.pki/.dev-certs/localhost.crt:/etc/pki/tls/localhost.crt:ro -v ~/.pki/.dev-certs/localhost.priv.key:/etc/pki/tls/localhost.priv.key:ro setmyinfo/setmy-info-rocky-freenginx:latest
```

Windows

```shell
docker run --rm -p 80:80 -p 443:443 -v C:\Users\<USERNAME>\.pki\.dev-certs\localhost.crt:/etc/pki/tls/localhost.crt:ro -v C:\Users\<USERNAME>\.pki\.dev-certs\localhost.priv.key:/etc/pki/tls/localhost.priv.key:ro setmyinfo/setmy-info-rocky-freenginx:latest
```

Installation directory **/opt/freenginx**, configuration **/opt/freenginx/conf/nginx.conf** and
**/opt/freenginx/conf/conf.d/**, locations **/opt/freenginx/conf/conf.d/locations/*.location.conf**,
web root **/usr/share/freenginx/www**, logs **/opt/freenginx/logs**.
