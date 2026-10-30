# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland"
PKG_VERSION="1.26.0"
PKG_SHA256="64176eaa46e4969903e286f8e5ef8331affc17fdf03ac9b58381d2b23162b7a3"
PKG_LICENSE="MIT"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/wayland/-/releases/${PKG_VERSION}/downloads/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="libffi:host expat:host libxml2:host meson:host"
PKG_DEPENDS_TARGET="toolchain wayland:host libffi expat libxml2"
PKG_LONGDESC="a display server protocol"

PKG_BUILD_FLAGS="-ndebug"

PKG_MESON_OPTS_HOST="-Dlibraries=false \
                     -Dscanner=true \
                     -Dtests=false \
                     -Ddocumentation=false \
                     -Ddtd_validation=false"

PKG_MESON_OPTS_TARGET="-Dlibraries=true \
                       -Dscanner=false \
                       -Dtests=false \
                       -Ddocumentation=false \
                       -Ddtd_validation=false"

post_makeinstall_host() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  sed -e "s|^prefix=.*|prefix=/usr|" \
      -e "s|^bindir=.*|bindir=${TOOLCHAIN}/bin|" \
      ${TOOLCHAIN}/lib/pkgconfig/wayland-scanner.pc > ${SYSROOT_PREFIX}/usr/lib/pkgconfig/wayland-scanner.pc
  mkdir -p ${SYSROOT_PREFIX}/usr/share/wayland
  cp -f ${TOOLCHAIN}/share/wayland/wayland.xml ${SYSROOT_PREFIX}/usr/share/wayland/
}
