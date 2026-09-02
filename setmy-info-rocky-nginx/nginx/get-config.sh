#!/bin/sh

set -eu

# https://nginx.org/en/download.html
# https://nginx.org/en/linux_packages.html
# https://nginx.org/en/linux_packages.html#RHEL
# https://nginx.org/packages/centos/10/x86_64/RPMS/
# https://nginx.org/packages/centos/10/x86_64/RPMS/nginx-1.30.4-1.el10.ngx.x86_64.rpm

#sudo dnf install -y cpio wget
wget -O nginx.rpm https://nginx.org/packages/centos/10/x86_64/RPMS/nginx-1.30.4-1.el10.ngx.x86_64.rpm
rpm2cpio nginx.rpm | cpio -idmv './etc/*'
rm nginx.rpm

exit 0
