# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wvkbd"
PKG_VERSION="0.20"
PKG_SHA256="b5fee580f826190fda94c06267e52e7c09f0fbbec2b02e5d140fe62a10a6c3b0"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/jjsullivan5196/wvkbd"
PKG_URL="https://github.com/jjsullivan5196/wvkbd/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols pango cairo wlroots"
PKG_DEPENDS_CONFIG="seatd wayland wayland-protocols wlroots"
PKG_LONGDESC="A Wayland kiosk "
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_TARGET () {
  make LAYOUT=mobintl all
}
