# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kasmvnc"
PKG_VERSION="1.4.0"
PKG_SHA256="792EE7A5DDFE1A35FE77C80C78BF24DF909E3A96187344E3EEF859D592F6C0DB"
PKG_REV="0"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/kasmtech/KasmVNC"
PKG_URL="https://github.com/kasmtech/KasmVNC/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host zlib libpng libjpeg-turbo freetype gnutls libwebp libdrm libgbm openssl"
PKG_SECTION="service"
PKG_SHORTDESC="${PKG_ADDON_NAME} server"
PKG_LONGDESC="${PKG_ADDON_NAME} (${PKG_VERSION}) is a modern VNC server with web-based access using DRM/GBM output"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="KasmVNC"
PKG_ADDON_ICON_NAME="KASM VNC"
PKG_ADDON_TYPE="xbmc.service"

PKG_CMAKE_OPTS_TARGET="-DBUILD_VIEWER=off -Wno-dev -DENABLE_GNUTLS=ON"

makeinstall_target() {
  : # nothing to do
}

# find ${1}.so.[0-9]* in ${2} and copy it to dest
_pkg_copy_lib() {
  find "${2}/usr/lib" -regextype sed -regex ".*/${1}\.so\.[0-9]*" \
    -exec cp {} "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private" \;
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private,www}

  # Copy binaries
  cp ${PKG_BUILD}/.${TARGET_NAME}/unix/xserver/Xvnc \
     ${PKG_BUILD}/.${TARGET_NAME}/unix/vncserver/vncserver \
     ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/

  # Copy web interface
  cp -r ${PKG_BUILD}/kasmweb/dist/* ${ADDON_BUILD}/${PKG_ADDON_ID}/www/

  # Copy required libraries for DRM/GBM output; no X11 runtime libraries are shipped
  _pkg_copy_lib libpng $(get_install_dir libpng)
  _pkg_copy_lib libjpeg-turbo $(get_install_dir libjpeg-turbo)
  _pkg_copy_lib freetype $(get_install_dir freetype)
  _pkg_copy_lib gnutls $(get_install_dir gnutls)
  _pkg_copy_lib libwebp $(get_install_dir libwebp)
  _pkg_copy_lib libdrm $(get_install_dir libdrm)
  _pkg_copy_lib libgbm $(get_install_dir libgbm)
  _pkg_copy_lib libssl $(get_install_dir openssl)
  _pkg_copy_lib libcrypto $(get_install_dir openssl)
}
