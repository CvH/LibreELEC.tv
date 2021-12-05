# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pico-tts"
PKG_VERSION="21089d223e177ba3cb7e385db8613a093dff74b5"
PKG_SHA256="f9556495fd56b96160cdae873ca2dbb0f0a578259c74f4ca939effa3fa1cb101"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/naggety/picotts"
PKG_URL="https://github.com/naggety/picotts/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A text to speech voice sinthesizer from SVox."
PKG_TOOLCHAIN="configure"

PKG_BUILD_FLAGS="-sysroot"

pre_configure_target() {
  cd ${PKG_BUILD}/pico
  ./autogen.sh
}

configure_package() {
  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/pico/configure"
}

make_target(){
  make picolangdir=lang
}
