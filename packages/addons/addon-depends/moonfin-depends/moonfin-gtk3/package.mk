# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory gtk3)/package.mk

PKG_NAME="moonfin-gtk3"
PKG_LONGDESC="gtk3 with Wayland support for Moonfin"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain at-spi2-core atk cairo gdk-pixbuf glib libepoxy pango libxkbcommon wayland wayland-protocols"
PKG_DEPENDS_CONFIG="pango gdk-pixbuf shared-mime-info wayland wayland-protocols"
PKG_DEPENDS_UNPACK+=" gtk3"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dbroadway_backend=false \
                       -Dcloudproviders=false \
                       -Dcolord=no \
                       -Ddemos=false \
                       -Dexamples=false \
                       -Dgtk_doc=false \
                       -Dintrospection=false \
                       -Dman=false \
                       -Dprint_backends=file,lpr \
                       -Dquartz_backend=false \
                       -Dtests=false \
                       -Dwayland_backend=true \
                       -Dwin32_backend=false \
                       -Dxinerama=no \
                       -Dbuiltin_immodules=yes \
                       -Dx11_backend=false"

unpack() {
  mkdir -p ${PKG_BUILD}
  ${SCRIPTS}/get ${PKG_NAME:8}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME:8}/gtk*-${PKG_VERSION}.tar.xz -C ${PKG_BUILD}
}
