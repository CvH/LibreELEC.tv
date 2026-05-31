# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wvkbd"
PKG_VERSION="0.19.4"
PKG_SHA256="0f259d6c60e52149937020eeb2ab5b2a0d7dff2df735b9b0c54a5654d998d980"
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