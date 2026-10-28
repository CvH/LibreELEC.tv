# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory sway)/package.mk

PKG_NAME="sway-kiosk"
PKG_LONGDESC="Sway kiosk compositor for externalhelper"
PKG_URL=""
PKG_DEPENDS_UNPACK+=" sway"
PKG_BUILD_FLAGS="-sysroot"

# Minimal dependency chain required for Sway kiosk operation
PKG_DEPENDS_TARGET="toolchain wayland:host wayland wayland-protocols libdrm libxkbcommon libinput cairo pango dbus json-c pcre2 wlroots"
PKG_DEPENDS_CONFIG="wayland wayland-protocols wlroots cairo pango json-c pcre2 libxkbcommon"

PKG_MESON_OPTS_TARGET="-Ddefault-wallpaper=false \
                       -Dzsh-completions=false \
                       -Dbash-completions=false \
                       -Dfish-completions=false \
                       -Dswaybar=false \
                       -Dswaynag=false \
                       -Dtray=disabled \
                       -Dgdk-pixbuf=disabled \
                       -Dman-pages=disabled \
                       -Dsd-bus-provider=auto"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/sway/sway-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/etc
  safe_remove ${INSTALL}/usr/share/wayland-sessions
}

post_install() {
  :
}
