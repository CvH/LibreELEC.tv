# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wvkbd"
PKG_VERSION="0.20"
PKG_SHA256="b5fee580f826190fda94c06267e52e7c09f0fbbec2b02e5d140fe62a10a6c3b0"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/jjsullivan5196/wvkbd"
PKG_URL="https://github.com/jjsullivan5196/wvkbd/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland:host wayland wayland-protocols cairo pango libxkbcommon"
PKG_DEPENDS_CONFIG="wayland wayland-protocols cairo pango libxkbcommon"
PKG_LONGDESC="On-screen keyboard for wlroots"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  make -C ${PKG_BUILD} \
    CC="${CC}" \
    PKG_CONFIG="pkg-config" \
    WAYLAND_SCANNER="wayland-scanner" \
    LAYOUT="mobintl" \
    wvkbd-mobintl
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p ${PKG_BUILD}/wvkbd-mobintl ${INSTALL}/usr/bin/
}
