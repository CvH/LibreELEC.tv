# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="muparser"
PKG_VERSION="2.3.5"
PKG_SHA256="20b43cc68c655665db83711906f01b20c51909368973116dfc8d7b3c4ddb5dd4"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://beltoforion.de/en/muparser/"
PKG_URL="https://github.com/beltoforion/muparser/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fast math parser library."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DENABLE_SAMPLES=OFF \
                       -DENABLE_OPENMP=OFF"

