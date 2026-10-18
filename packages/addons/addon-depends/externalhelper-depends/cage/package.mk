# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cage"
PKG_VERSION="bb97c647bbae2d84c96165a17611846eb6bab471"
PKG_SHA256="640679630d846d19547f4383b22438af115370e75453a5f2197eea008e2e32d1"
PKG_LICENSE="MIT"
PKG_SITE="https://www.hjdskes.nl/projects/cage"
PKG_URL="https://github.com/cvh/cage/archive/${PKG_VERSION}.zip"
PKG_DEPENDS_TARGET="toolchain libxkbcommon seatd wayland wayland-protocols wlroots"
PKG_DEPENDS_CONFIG="seatd wayland wayland-protocols wlroots"
PKG_LONGDESC="A Wayland kiosk "
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled"
