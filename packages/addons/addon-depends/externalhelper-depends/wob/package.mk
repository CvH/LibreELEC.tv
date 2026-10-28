# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wob"
PKG_VERSION="0.16"
PKG_SHA256="8a5850beec72b5b19be631a6eb21315a20082bf9135447080f9e9045f143938b"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/francma/wob"
PKG_URL="https://github.com/francma/wob/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland:host wayland wayland-protocols inih"
PKG_DEPENDS_CONFIG="wayland wayland-protocols inih"
PKG_LONGDESC="A lightweight overlay volume/backlight bar for Wayland"
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled \
                       -Dtests=disabled \
                       -Dseccomp=disabled \
                       -Dsystemd-unit-files=disabled"
