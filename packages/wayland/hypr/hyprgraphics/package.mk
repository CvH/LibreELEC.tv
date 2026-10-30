# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hyprgraphics"
PKG_VERSION="0.5.1"
PKG_SHA256="861ecaad872835922dd5745a612d7a4cc7bfc4babb1d06bc92bc63c2ac013b74"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://hyprland.org"
PKG_URL="https://github.com/hyprwm/hyprgraphics/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa libdrm pixman cairo pango hyprutils libjpeg-turbo file libpng"
PKG_LONGDESC="Small C++ library for graphics / resource utilities used across the Hypr* ecosystem."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING=OFF"

