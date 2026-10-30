# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprutils"
PKG_VERSION="0.14.3"
PKG_SHA256="87bbfc9549ed96316b0d592c16d01f58729b23a2999a5293b73eec620b40c5f5"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/hyprwm/hyprutils"
PKG_URL="https://github.com/hyprwm/hyprutils/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host pixman:host"
PKG_DEPENDS_TARGET="toolchain pixman"
PKG_LONGDESC="Small C++ library for utilities used across the Hypr* ecosystem"
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

