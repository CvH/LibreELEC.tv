# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="moonfin"
PKG_VERSION="2.7.0"
PKG_REV="1"
PKG_ARCH="x86_64 aarch64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/Moonfin-Client/Moonfin-Core"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain mpv libsecret moonfin-gtk3 at-spi2-core atk cairo gdk-pixbuf harfbuzz-icu pango libepoxy"
PKG_SECTION="script"
PKG_SHORTDESC="Moonfin: Jellyfin and Emby Client"
PKG_LONGDESC="Moonfin is a modern, fast, and feature-rich Jellyfin and Emby media client built with Flutter."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Moonfin"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_PROVIDES="executable"
PKG_ADDON_REQUIRES="tools.externalhelper:0.0.0"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/resources"

  # Launcher binary script
  cp -P "${PKG_DIR}/source/bin/moonfin-start" "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/"
  chmod 755 "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/moonfin-start"

  # mpv (libmpv)
  cp -PL $(get_install_dir mpv)/usr/lib/libmpv.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # libsecret
  cp -PL $(get_install_dir libsecret)/usr/lib/libsecret-1.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

  # GTK3 (with Wayland support from moonfin-gtk3) and display stack libraries
  cp -PL $(get_install_dir moonfin-gtk3)/usr/lib/libgtk-3.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir moonfin-gtk3)/usr/lib/libgdk-3.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir atk)/usr/lib/libatk-1.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir at-spi2-core)/usr/lib/libatk-bridge-2.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir at-spi2-core)/usr/lib/libatspi.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir cairo)/usr/lib/libcairo.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir cairo)/usr/lib/libcairo-gobject.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir gdk-pixbuf)/usr/lib/libgdk_pixbuf-2.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir harfbuzz-icu)/usr/lib/libharfbuzz*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir pango)/usr/lib/libpango*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
  cp -PL $(get_install_dir libepoxy)/usr/lib/libepoxy.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
}

post_install_addon() {
  sed -e "s/@PKG_VERSION@/${PKG_VERSION}/g" -i "${INSTALL}/default.py"
}
