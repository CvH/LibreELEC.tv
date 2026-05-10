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
PKG_DEPENDS_TARGET="toolchain meson:host ninja:host pkg-config:host \
                    libxkbcommon pixman jansson neatvnc aml \
                    wayland wayland-protocols libdrm"
PKG_SECTION="service"
PKG_SHORTDESC="A VNC server for wlroots based Wayland compositors"
PKG_LONGDESC="WayVNC (${PKG_VERSION}) is a VNC server for wlroots based Wayland compositors. It allows you to remotely view and control a Wayland session."

#PKG_BUILD_FLAGS="-sysroot"
PKG_DEPENDS_CONFIG="wayland wayland-protocols"

if [ "${DISPLAYSERVER}" != "wl" ]; then
  PKG_DEPENDS_CONFIG="wayland wayland-protocols"
fi

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="WayVNC"
PKG_ADDON_ICON_NAME="WayVNC"
PKG_ADDON_TYPE="xbmc.service"

PKG_MESON_OPTS_TARGET="-Dpam=disabled \
                       -Dscreencopy-dmabuf=enabled \
                       -Dman-pages=disabled \
                       -Dsystemtap=false \
					   -Dtests=false"

pre_configure_target() {
  # wayvnc does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function")
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private,resources,resources/language/English}

  cp ${PKG_INSTALL}/usr/bin/wayvnc \
     ${PKG_INSTALL}/usr/bin/wayvncctl \
     ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  # copy required libraries for wayvnc
  cp -p $(get_install_dir libxkbcommon)/usr/lib/libxkbcommon.so.* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir pixman)/usr/lib/libpixman-1.so.* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir jansson)/usr/lib/libjansson.so.* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir aml)/usr/lib/libaml.so.* ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  
  # copy addon files
  cp -r ${PKG_DIR}/source/* ${ADDON_BUILD}/${PKG_ADDON_ID}/
}
