#!/bin/sh

set -e

. $(smi-include base.sh)
. $(smi-include commons.sh)
. $(smi-include packages.sh)
includePackages nginx

# https://nginx.org/en/download.html
# https://nginx.org/en/linux_packages.html
# https://nginx.org/en/linux_packages.html#RHEL
# https://nginx.org/packages/centos/10/x86_64/RPMS/

#sudo dnf install -y cpio wget
wget -O nginx.rpm https://nginx.org/packages/centos/10/x86_64/RPMS/nginx-${NGINX_VERSION}.el10.ngx.x86_64.rpm
rpm2cpio nginx.rpm | cpio -idmv './etc/*'
rm nginx.rpm
meld ../nginx/etc ../etc

exit 0
