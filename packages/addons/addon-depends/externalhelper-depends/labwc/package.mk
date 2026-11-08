# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="labwc"
PKG_VERSION="0.20.3"
PKG_SHA256="1e70a5b74f149c5b47da76063dbdf967c44b2d7b6e94d3fdf65f70fc252f65c9"
PKG_LICENSE="GPL-2.0-only"
PKG_SITE="https://github.com/labwc/labwc"
PKG_URL="https://github.com/labwc/labwc/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wlroots wayland wayland-protocols libinput libxkbcommon pixman libxml2 cairo pango glib seatd libdrm"
PKG_DEPENDS_CONFIG="seatd wayland wayland-protocols wlroots"
PKG_LONGDESC="A Wayland window-stacking compositor configured for kiosk mode"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled \
                       -Dxwayland=disabled \
                       -Dsvg=disabled \
                       -Dicon=disabled \
                       -Dnls=disabled \
                       -Dsystemd-session=disabled \
                       -Dtest=disabled"

