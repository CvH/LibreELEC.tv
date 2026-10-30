# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprwayland-scanner"
PKG_VERSION="0.4.6"
PKG_SHA256="05f55fd1a20d8ca81b5030980fdb7c87147749230145bdb3745af2741d617f5c"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/hyprwm/hyprwayland-scanner"
PKG_URL="https://github.com/hyprwm/hyprwayland-scanner/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host pugixml:host"
PKG_DEPENDS_TARGET="toolchain hyprwayland-scanner:host pugixml"
PKG_LONGDESC="A Hyprland implementation of wayland-scanner in and for C++"
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

post_makeinstall_host() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  if [ -f ${TOOLCHAIN}/lib/pkgconfig/hyprwayland-scanner.pc ]; then
    cp ${TOOLCHAIN}/lib/pkgconfig/hyprwayland-scanner.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/
  fi
  if [ -d ${TOOLCHAIN}/lib/cmake/hyprwayland-scanner ]; then
    mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake
    cp -r ${TOOLCHAIN}/lib/cmake/hyprwayland-scanner ${SYSROOT_PREFIX}/usr/lib/cmake/
  fi
}

