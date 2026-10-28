# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="externalhelper"
PKG_VERSION="0"
PKG_REV="12"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain seatd wayland wlroots sway-kiosk wvkbd wob wayvnc inih cairo pango json-c pcre2"
PKG_SECTION="tools"
PKG_SHORTDESC="External programs helper"
PKG_LONGDESC="Tools to run external programs in a minimal wayland session"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="External programs helper"
PKG_ADDON_ICON_NAME="HELPER"
PKG_ADDON_ICON_SIZE="250"
PKG_ADDON_PROJECTS="any !Generic-legacy"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

addon() {
  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir seatd)/usr/bin/{seatd,seatd-launch} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir sway-kiosk)/usr/bin/{sway,swaymsg} "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir wvkbd)/usr/bin/wvkbd-mobintl "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir wob)/usr/bin/wob "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"
    cp -P $(get_install_dir wayvnc)/usr/bin/wayvnc "${ADDON_BUILD}/${PKG_ADDON_ID}/bin"

    for f in seatd seatd-launch sway swaymsg wvkbd-mobintl wob wayvnc; do
      patchelf --add-rpath '${ORIGIN}/../lib.private' "${ADDON_BUILD}/${PKG_ADDON_ID}/bin/${f}"
    done

  mkdir -p "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private"
    cp -L $(get_install_dir aml)/usr/lib/libaml.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir jansson)/usr/lib/libjansson.so.4 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir neatvnc)/usr/lib/libneatvnc.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir seatd)/usr/lib/libseat.so.1 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir wayland)/usr/lib/libwayland-{client,server}.so.0 "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir wlroots)/usr/lib/libwlroots*.so "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir inih)/usr/lib/libinih.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir cairo)/usr/lib/libcairo*.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir pango)/usr/lib/libpango*-1.0.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir json-c)/usr/lib/libjson-c.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"
    cp -L $(get_install_dir pcre2)/usr/lib/libpcre2-8.so* "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"

    for f in "${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private/"*.so*; do
      [ -f "$f" ] && patchelf --add-rpath '${ORIGIN}/../lib.private' "$f" 2>/dev/null || true
    done
}
