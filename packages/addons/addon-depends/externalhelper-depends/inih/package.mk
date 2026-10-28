# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inih"
PKG_VERSION="58"
PKG_SHA256="e79216260d5dffe809bda840be48ab0eec7737b2bb9f02d2275c1b46344ea7b7"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/benhoyt/inih"
PKG_URL="https://github.com/benhoyt/inih/archive/refs/tags/r${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Simple .INI file parser in C"
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Ddefault_library=shared \
                       -Ddistro_install=true"

