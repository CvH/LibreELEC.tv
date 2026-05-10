# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wl-kbptr"
PKG_VERSION="0.4.1"
PKG_SHA256="03ac52afa42d7aa88f909f96b2c0e57f5706a11d5d0ff451f6052927571e0624"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/moverest/wl-kbptr"
PKG_URL="https://github.com/moverest/wl-kbptr/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols cairo libxkbcommon"
PKG_LONGDESC="Control the mouse pointer with the keyboard on Wayland."

# Keep package footprint small by disabling optional OpenCV target detection.
PKG_MESON_OPTS_TARGET="-Dopencv=disabled"
