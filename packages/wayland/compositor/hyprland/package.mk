# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprland"
PKG_VERSION="0.57.0"
PKG_SHA256="82d006ba9264fe67266c7d583c16f1a6c64d51424dbdc472c3e9c9d5ddfcd559"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://hyprland.org"
PKG_URL="https://github.com/hyprwm/Hyprland/releases/download/v${PKG_VERSION}/source-v${PKG_VERSION}.tar.gz"
PKG_SOURCE_NAME="source-v${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="hyprland-source"
PKG_DEPENDS_TARGET="toolchain hyprwayland-scanner:host wayland:host Python3:host glslang spirv-tools glaze aquamarine hyprlang hyprcursor hyprutils hyprgraphics hyprland-protocols re2 muparser libeis lua55 lcms2 cairo pango pixman libXcursor libdrm libinput seatd mesa util-linux libxkbcommon glib hyprwire:host hyprwire"
PKG_LONGDESC="Hyprland is an independent, highly customizable, dynamic tiling Wayland compositor."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DNO_CANBERRA=ON \
                       -DNO_RTKIT=ON \
                       -DNO_XWAYLAND=ON \
                       -DNO_SYSTEMD=ON \
                       -DNO_HYPRPM=ON \
                       -DBUILD_TESTING=OFF"

