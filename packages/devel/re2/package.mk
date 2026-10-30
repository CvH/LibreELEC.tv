# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="re2"
PKG_VERSION="2023-03-01"
PKG_SHA256="7a9a4824958586980926a300b4717202485c4b4115ac031822e29aa4ef207e48"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/google/re2"
PKG_URL="https://github.com/google/re2/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RE2 is a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DRE2_BUILD_TESTING=OFF"

