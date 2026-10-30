# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lua55"
PKG_VERSION="5.5.1"
PKG_SHA256="1c4b4068d67061f2a2231ad2b5422e77acea1487ea9890f6320af614f4373dce"
PKG_LICENSE="MIT"
PKG_SITE="https://www.lua.org"
PKG_URL="http://www.lua.org/ftp/lua-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Lua is a powerful, efficient, lightweight, embeddable scripting language."
PKG_BUILD_FLAGS="+pic"

make_target() {
  make CC=${CC} AR="${AR} rcu" MYCFLAGS="-fPIC" posix
  ${CC} -shared -o src/liblua$(get_pkg_version_maj_min).so -Wl,--whole-archive src/liblua.a -Wl,--no-whole-archive -lm
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/include/lua$(get_pkg_version_maj_min)
  cp src/lua.h src/luaconf.h src/lualib.h src/lauxlib.h src/lua.hpp ${SYSROOT_PREFIX}/usr/include/lua$(get_pkg_version_maj_min)

  mkdir -p ${SYSROOT_PREFIX}/usr/lib
  cp src/liblua.a ${SYSROOT_PREFIX}/usr/lib/liblua$(get_pkg_version_maj_min).a
  cp src/liblua$(get_pkg_version_maj_min).so ${SYSROOT_PREFIX}/usr/lib/
  ln -sf liblua$(get_pkg_version_maj_min).a ${SYSROOT_PREFIX}/usr/lib/liblua55.a
  ln -sf liblua$(get_pkg_version_maj_min).so ${SYSROOT_PREFIX}/usr/lib/liblua55.so

  mkdir -p ${INSTALL}/usr/lib
  cp src/liblua$(get_pkg_version_maj_min).so ${INSTALL}/usr/lib/
  ln -sf liblua$(get_pkg_version_maj_min).so ${INSTALL}/usr/lib/liblua55.so

  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  cp ${PKG_DIR}/config/lua55.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  sed -e "s/@@VERSION@@/${PKG_VERSION}/g" \
      -e "s/@@VERSION_MM@@/$(get_pkg_version_maj_min)/g" \
      -i ${SYSROOT_PREFIX}/usr/lib/pkgconfig/lua55.pc
  ln -sf lua55.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/lua5.5.pc
  ln -sf lua55.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/lua-5.5.pc
  ln -sf lua55.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/lua.pc
}

