# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="reframe"
PKG_VERSION="1.15.1"
PKG_SHA256="6b8f7ce807443144e9a98b1aa404f9322e8d53d14389ff54f5c9e963ceb1883f"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL-3.0-only"
PKG_SITE="https://github.com/AlynxZhou/reframe"
PKG_URL="https://github.com/AlynxZhou/reframe/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libvncserver meson libdrm libxkbcommon"
PKG_SECTION="service"
PKG_SHORTDESC="DRM/KMS based remote desktop for Linux"
PKG_LONGDESC="ReFrame is a DRM/KMS based remote desktop for Linux that supports Wayland, NVIDIA, and headless setups."

PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="ReFrame"
PKG_ADDON_ICON_NAME="ReFrame"
PKG_ADDON_TYPE="xbmc.service"

# Assuming it uses meson
PKG_MESON_OPTS_TARGET="-Dneatvnc=false -Dsystemd=true"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private}

  cp ${PKG_INSTALL}/usr/bin/reframe-server \
     ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  # copy required libraries
  cp -p $(get_install_dir libdrm)/usr/lib/libdrm.so.2 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir libxkbcommon)/usr/lib/libxkbcommon.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir aml)/usr/lib/libaml.so.1 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir epoxy)/usr/lib/libepoxy.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir pixman)/usr/lib/libpixman-1.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
  cp -p $(get_install_dir glib)/usr/lib/libglib-2.0.so.0 ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/
}