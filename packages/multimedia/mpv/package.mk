# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpv"
PKG_VERSION="0.41.0"
PKG_SHA256="ee21092a5ee427353392360929dc64645c54479aefdb5babc5cfbb5fad626209"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://mpv.io/"
PKG_URL="https://github.com/mpv-player/mpv/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ffmpeg libass alsa-lib mesa zlib libplacebo"
PKG_DEPENDS_CONFIG="libplacebo"
PKG_SECTION="multimedia"
PKG_SHORTDESC="A free, open-source, and cross-platform media player (libmpv library)"
PKG_LONGDESC="mpv is a media player based on MPlayer and mplayer2 with a shared library libmpv."

if [ -d "$(get_pkg_directory wayland)" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
fi

if [ -d "$(get_pkg_directory libva)" ]; then
  PKG_DEPENDS_TARGET+=" libva"
fi

PKG_MESON_OPTS_TARGET="-Dlibmpv=true \
                       -Dcplayer=false \
                       -Dlua=disabled \
                       -Djavascript=disabled \
                       -Dmanpage-build=disabled \
                       -Dhtml-build=disabled \
                       -Dpdf-build=disabled \
                       -Dtests=false \
                       -Dalsa=enabled \
                       -Degl=enabled \
                       -Dwayland=enabled \
                       -Ddrm=enabled \
                       -Dvaapi=auto \
                       -Diconv=disabled \
                       -Duchardet=disabled \
                       -Drubberband=disabled \
                       -Dlcms2=disabled \
                       -Dlibarchive=disabled \
                       -Dlibbluray=disabled \
                       -Ddvdnav=disabled"

post_makeinstall_target() {
  # Provide compatibility symlink for bundles expecting libmpv.so.1
  if [ -e "${INSTALL}/usr/lib/libmpv.so" ] && [ ! -e "${INSTALL}/usr/lib/libmpv.so.1" ]; then
    ln -sf libmpv.so "${INSTALL}/usr/lib/libmpv.so.1"
  fi
}
