# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libeis"
PKG_VERSION="1.3.0"
PKG_SHA256="162dc7b0d86a4575cdde1d3cb04f364f89a8b1ba6d95fe0b442564e0444d851d"
PKG_LICENSE="MIT"
PKG_SITE="https://gitlab.freedesktop.org/libinput/libei"
PKG_URL="https://gitlab.freedesktop.org/libinput/libei/-/archive/${PKG_VERSION}/libei-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3:host Jinja2:host attrs:host libevdev libxkbcommon systemd"
PKG_LONGDESC="Emulated Input library for Wayland and X11"
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddocumentation=[] \
                       -Dtests=disabled \
                       -Dliboeffis=disabled"

