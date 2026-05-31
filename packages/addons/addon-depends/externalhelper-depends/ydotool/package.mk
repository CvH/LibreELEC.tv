# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ydotool"
PKG_VERSION="708e96ff27e381a8c549418a9d34cdde12305317"
PKG_SHA256="0ddbb2694fbb25657a8b0fdb7db783f6ba0f166b10959d6496de9faef93679cf"
PKG_LICENSE="AGPL-3.0-only"
PKG_SITE="https://github.com/ReimuNotMoe/ydotool"
PKG_URL="https://github.com/ReimuNotMoe/ydotool/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain pkg-config:host"
PKG_SHORTDESC="Generic Linux command-line automation tool using uinput"
PKG_LONGDESC="ydotool is a command-line automation tool for Linux that emulates input device events through the Linux uinput framework."

PKG_CMAKE_OPTS_TARGET="-DBUILD_DOCS=OFF"
