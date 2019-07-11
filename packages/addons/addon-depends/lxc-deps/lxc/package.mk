# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lxc"
PKG_VERSION="3.0.4"
PKG_SHA256="12a126e634a8df81507fd9d3a4984bacaacf22153c11f024e215810ea78fcc4f"
PKG_LICENSE="LGPLv2"
PKG_SITE="https://linuxcontainers.org/lxc"
PKG_URL="https://github.com/lxc/lxc/archive/lxc-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libseccomp"
PKG_LONGDESC="Low-level Linux container runtime"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  cd $PKG_BUILD
    ./autogen.sh

    ./configure \
    --prefix=/usr \
    --sbindir=/usr/bin \
    --localstatedir=/var \
    --libexecdir=/usr/lib \
    --libdir=/usr/lib \
    --sysconfdir=/etc \
    --disable-apparmor \
    --enable-openssl \
    --disable-selinux \
    --enable-capabilities \
    --disable-examples \
    --enable-seccomp \
    --with-init-script=systemd \
    --with-distro=${DISTRONAME} \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --disable-pam \
    --disable-werror \
    --disable-doc \
    --disable-tests \
    --disable-api-docs \
    --disable-api-docs
}
make_target() {
  make
}
makeinstall_target() {
  :
}
