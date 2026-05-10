# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wlrctl"
PKG_VERSION="0.2.2"
PKG_SHA256="b5b3836091c41de09a832df1e5eb4747841d7ae670367e413487d5be7a5f2849"
PKG_LICENSE="MIT"
PKG_SITE="https://git.sr.ht/~brocellous/wlrctl"
PKG_URL="https://git.sr.ht/~brocellous/wlrctl/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols"
PKG_LONGDESC="Utility for miscellaneous wlroots Wayland extensions."

if [ "${DISPLAYSERVER}" != "wl" ]; then
  PKG_BUILD_FLAGS="-sysroot"
  PKG_DEPENDS_CONFIG="wayland wayland-protocols"
fi

pre_configure_target() {
  # Upstream uses -Werror; suppress char signedness false-positive on aarch64.
  export TARGET_CFLAGS="${TARGET_CFLAGS} -Wno-type-limits"
}
