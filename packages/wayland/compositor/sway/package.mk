# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sway"
PKG_VERSION="1.12"
PKG_SHA256="29ca7caac960d13e02d8213418d91a5422c7c23102a283ceab944c57c5e1efcf"
PKG_LICENSE="MIT"
PKG_SITE="https://swaywm.org/"
PKG_URL="https://github.com/swaywm/sway/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols libdrm libxkbcommon libinput cairo pango libjpeg-turbo dbus json-c wlroots swaybg"
PKG_LONGDESC="i3-compatible Wayland compositor"

PKG_DEPENDS_CONFIG="wayland wayland-protocols seatd gdk-pixbuf shared-mime-info"

PKG_MESON_OPTS_TARGET="-Ddefault-wallpaper=false \
                       -Dzsh-completions=false \
                       -Dbash-completions=false \
                       -Dfish-completions=false \
                       -Dswaybar=false \
                       -Dswaynag=false \
                       -Dtray=disabled \
                       -Dgdk-pixbuf=enabled \
                       -Dman-pages=disabled \
                       -Dsd-bus-provider=auto"

pre_configure_target() {
  # sway does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-variable")
}

