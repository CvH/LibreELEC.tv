# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXcursor"
PKG_VERSION="1.2.3"
PKG_SHA256="fde9402dd4cfe79da71e2d96bb980afc5e6ff4f8a7d74c159e1966afb2b2c2c0"
PKG_LICENSE="HPND-sell-variant"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libXfixes libXrender"
PKG_LONGDESC="X Cursor management library"
PKG_BUILD_FLAGS="+pic"

post_configure_target() {
  libtool_remove_rpath libtool
}
