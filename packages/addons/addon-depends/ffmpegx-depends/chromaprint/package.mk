# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="chromaprint"
PKG_VERSION="1.6.2"
PKG_SHA256="d54ada62c16b2db396d3251ec54fc7a58909c163131a1cfcf7fa6407dbc14360"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://acoustid.org/chromaprint"
PKG_URL="https://github.com/acoustid/chromaprint/releases/download/v${PKG_VERSION}/chromaprint-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ffmpeg"
PKG_LONGDESC="Chromaprint is the client-side library that implements a custom algorithm for extracting fingerprints from any audio source."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_TOOLS=OFF \
                       -DBUILD_TESTS=OFF \
                       -DFFT_LIB=avtx \
                       -DFFMPEG_ROOT=${SYSROOT_PREFIX}/usr"

post_makeinstall_target() {
  sed 's/^Libs:.*-lchromaprint/& -lavutil -lstdc++ -lm/' -i ${INSTALL}/usr/lib/pkgconfig/libchromaprint.pc
}
