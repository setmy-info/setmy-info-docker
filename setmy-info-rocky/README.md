# setmy-info-rocky

Base image of the setmy.info images, see the root `README.md` for building. It prepares for every derived image:

* Rocky Linux, updated, with `tar`, `gzip`, `bzip2`, `wget` and `yum-utils`.
* The setmy-info-scripts RPM: `/opt/setmy.info`, the `microservice` user with its home and `/var/opt/setmy.info/microservice/log`.
* SBCL in `/opt/sbcl`, Quicklisp in `/opt/quicklisp`, loaded for every user by `/etc/sbclrc`.
* `PATH`, `LD_LIBRARY_PATH` and `PYTHONPATH` with `/opt/setmy.info/bin` and `/opt/setmy.info/lib`.
* The full list of OCI labels, empty ones included; derived images set only what differs.
