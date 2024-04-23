# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lxc"
PKG_VERSION="6.0.0"
PKG_SHA256="3f6981c61ff39f9e550a18cf22d6e26792cde5dd34f9d3c93badfeaaee8814b2"
PKG_LICENSE="APL"
PKG_SITE="https://linuxcontainers.org"
PKG_URL="https://linuxcontainers.org/downloads/lxc/lxc-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libcap rsync libseccomp"
PKG_LONGDESC="A daemon to control runC, built for performance and density."
#PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dman=false \
-Dpam-cgroup=false \
-Dtools-multicall=false \
-Dapparmor=false \
-Dselinux=false \
-Dseccomp=true \
-Dexamples=false \
-Dinit-script=systemd \
--prefix=/storage/lxc \
--sysconfdir=/storage/lxc/conf \
-Dlog-path=/storage/lxc/logs \
-Drootfs-mount-path=/storage/lxc/rootfs \
-Dtests=false"

# --prefix=/storage/lxc \
# -Dlog-path=/storage/lxc/logs \
# -Ddata-path=/storage/lxc/data \
# -Ddistrosysconfdir=storage/lxc/defaults \
# -Drootfs-mount-path=/storage/lxc/rootfs \
# -Dusernet-config-path=/storage/lxc/lxc-usernet \
# -Dusernet-db-path=/storage/lxc/nics \

pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_install_dir libseccomp)/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
}
