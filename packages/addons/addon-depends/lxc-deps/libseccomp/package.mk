# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libseccomp"
PKG_VERSION="2.4.1"
PKG_SHA256="1ca3735249af66a1b2f762fe6e710fcc294ad7185f1cc961e5bd83f9988006e8"
PKG_LICENSE="LGPL2.1"
PKG_SITE="https://github.com/seccomp/libseccomp"
PKG_URL="https://github.com/seccomp/libseccomp/releases/download/v${PKG_VERSION}/libseccomp-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A interface to the Linux Kernel's syscall filtering mechanism."

makeinstall_target() {
  :
}
