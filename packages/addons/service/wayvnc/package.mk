# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayvnc"
PKG_VERSION="0.10.0"
PKG_SHA256="fcfda018d0e07ec00a80071420c8cc2a75885dc6d5e55bb50a9b12353754338f"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/any1/wayvnc"
PKG_URL="https://github.com/any1/wayvnc/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain aml jansson libdrm mesa neatvnc wayland wayland-protocols"
PKG_SECTION="service"
PKG_SHORTDESC="A VNC server for wlroots based Wayland compositors"
PKG_LONGDESC="WayVNC (${PKG_VERSION}) is a VNC server for wlroots based Wayland compositors. It allows you to remotely view and control a Wayland session."

PKG_BUILD_FLAGS="-sysroot"
PKG_DEPENDS_CONFIG="wayland wayland-protocols"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="WayVNC"
PKG_ADDON_ICON_NAME="WayVNC"
PKG_ADDON_TYPE="xbmc.service"

PKG_MESON_OPTS_TARGET="-Dman-pages=disabled \
                       -Dpam=disabled \
                       -Dscreencopy-dmabuf=enabled \
                       -Dsystemtap=false \
                       -Dtests=false"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private}

  cp ${PKG_INSTALL}/usr/bin/wayvnc \
     ${PKG_INSTALL}/usr/bin/wayvncctl \
     ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  # copy required libraries for wayvnc
  cp -p $(get_install_dir jansson)/usr/lib/libjansson.so.4 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir aml)/usr/lib/libaml.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir wayland)/usr/lib/libwayland-client.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
}
