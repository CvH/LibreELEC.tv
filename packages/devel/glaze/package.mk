# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glaze"
PKG_VERSION="7.2.0"
PKG_SHA256="17dba19ae63ae48f94994f00d49d5cb3c8f1306db1046c534c4828662490b7d4"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/stephenberry/glaze"
PKG_URL="https://github.com/stephenberry/glaze/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Extremely fast, in memory, JSON and interface library for modern C++."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-Dglaze_DEVELOPER_MODE=OFF"

