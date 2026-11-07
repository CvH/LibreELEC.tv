# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wvkbd"
PKG_VERSION="71d56507cbc15a455f4f2d7fcd8a4630a2072c38"
PKG_SHA256="6f5d42351e0821eb5e06fd362d2b6fa9e9128b0a8db6871036c68684fc316f32"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/CvH/wvkbd"
PKG_URL="https://github.com/CvH/wvkbd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols libxkbcommon pango cairo"
PKG_LONGDESC="On-screen virtual keyboard for Wayland"
PKG_BUILD_FLAGS="-sysroot"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="PREFIX=/usr LAYOUT=mobintl"
PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr LAYOUT=mobintl"

post_makeinstall_target() {
  ln -sf wvkbd-mobintl "${INSTALL}/usr/bin/wvkbd"
}
