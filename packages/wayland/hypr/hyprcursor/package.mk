# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprcursor"
PKG_VERSION="0.1.13"
PKG_SHA256="82af8b2ce27242ffdd6baebaa71b3f6c8665dc25c52bfcfccc16912622896af8"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://hyprland.org"
PKG_URL="https://github.com/hyprwm/hyprcursor/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain hyprlang libzip cairo tomlplusplus"
PKG_LONGDESC="The hyprcursor library / format / utilities."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DNO_SVG=ON \
                       -DBUILD_TESTING=OFF"

