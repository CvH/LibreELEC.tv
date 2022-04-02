# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lxc"
PKG_VERSION="4.0.12"
PKG_SHA256="d0549ffbc0c920416d7842030091353b3ddf44d577b42e4f899d3440d6b373f2"
PKG_LICENSE="LGPLv2"
PKG_SITE="https://linuxcontainers.org/lxc"
PKG_URL="https://github.com/lxc/lxc/archive/lxc-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libseccomp linux"
PKG_LONGDESC="Low-level Linux container runtime"

# workaround to fix error at meson build script
export SOURCE_DATE_EPOCH="$(date +%s)"

makeinstall_target() {
  :
}
