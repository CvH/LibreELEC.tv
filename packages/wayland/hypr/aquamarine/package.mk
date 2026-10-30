# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aquamarine"
PKG_VERSION="0.15.1"
PKG_SHA256="2f9de98c0bd1b7b1b09c576e390a2fef436449762fb334163c414f0c300296f2"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://hyprland.org"
PKG_URL="https://github.com/hyprwm/aquamarine/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain hyprwayland-scanner:host hwdata:host wayland:host wayland wayland-protocols hyprutils libdisplay-info libinput libdrm pixman seatd mesa systemd"
PKG_LONGDESC="Aquamarine is a very light linux rendering backend library."
PKG_TOOLCHAIN="cmake"

