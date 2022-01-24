# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nextpvr"
PKG_VERSION="bootstrap"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="https://nextpvr.com"
PKG_DEPENDS_TARGET="toolchain openssl-compat"
PKG_SECTION="service"
PKG_SHORTDESC="NextPVR Server"
PKG_LONGDESC="NextPVR is a personal video recorder application. It allows to watch or record live TV, provides great features like series recordings and web scheduling."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="NextPVR Server"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROJECTS="any"
PKG_ADDON_REQUIRES="tools.ffmpeg-tools:0.0.0 tools.dotnet-runtime:0.0.0"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
  cp -PL $(get_install_dir openssl-compat)/usr/local/lib/{libcrypto.so.1.1,libssl.so.1.1} ${ADDON_BUILD}/${PKG_ADDON_ID}/lib
}
