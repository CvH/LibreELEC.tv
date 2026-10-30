# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprwire"
PKG_VERSION="0.3.1"
PKG_SHA256="92a673d40ae6a7d66fbcd0a34ec071e026e17eaeeb0040c3375e4b2a80dba737"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://hyprland.org"
PKG_URL="https://github.com/hyprwm/hyprwire/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host pugixml:host hyprutils:host libffi:host"
PKG_DEPENDS_TARGET="toolchain hyprwire:host pugixml hyprutils libffi"
PKG_LONGDESC="A fast and consistent wire protocol for IPC."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

post_makeinstall_host() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  if [ -f ${TOOLCHAIN}/lib/pkgconfig/hyprwire-scanner.pc ]; then
    cp -f ${TOOLCHAIN}/lib/pkgconfig/hyprwire-scanner.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/
  fi
  if [ -d ${TOOLCHAIN}/lib/cmake/hyprwire-scanner ]; then
    mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake
    cp -rf ${TOOLCHAIN}/lib/cmake/hyprwire-scanner ${SYSROOT_PREFIX}/usr/lib/cmake/
  fi
}

