# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tomlplusplus"
PKG_VERSION="3.4.0"
PKG_SHA256="8517f65938a4faae9ccf8ebb36631a38c1cadfb5efa85d9a72e15b9e97d25155"
PKG_LICENSE="MIT"
PKG_SITE="https://marzer.github.io/tomlplusplus/"
PKG_URL="https://github.com/marzer/tomlplusplus/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Header-only TOML config file parser and serializer for C++20."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Dbuild_lib=true \
                       -Dbuild_tests=false \
                       -Dbuild_examples=false \
                       -Dgenerate_cmake_config=false"
