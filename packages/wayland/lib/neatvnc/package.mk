# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="neatvnc"
PKG_VERSION="1.0.0"
PKG_SHA256="993dedc30e72981650770c04438e9759537e4677010e2dab5e792c39afe74601"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/any1/neatvnc"
PKG_URL="https://github.com/any1/neatvnc/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain meson:host ninja:host pkg-config:host \
                    libjpeg-turbo libxkbcommon pixman jansson gnutls ffmpeg"
PKG_SHORTDESC="VNC server library that is intended to be fast and neat"

PKG_BUILD_FLAGS="-sysroot"
PKG_DEPENDS_CONFIG="wayland wayland-protocols"

if [ "${DISPLAYSERVER}" != "wl" ]; then
  PKG_DEPENDS_CONFIG="wayland wayland-protocols"
fi

PKG_MESON_OPTS_TARGET="-Dtests=false \
                       -Dexamples=false \
					   -Dgbm=enabled \
					   -Dh264=enabled \
					   -Dnettle=disabled \
					   -Djpeg=enabled"

pre_configure_target() {
  # neatvnc does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function")
}
